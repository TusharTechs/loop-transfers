import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../engine/loop_engine.dart';
import '../../generated/protocol.dart';
import 'bots.dart';
import 'edges.dart';
import 'jobs.dart';

/// Message channels used for live updates.
abstract final class Channels {
  static String member(int memberId) => 'member:$memberId';
  static String exchange(int exchangeId) => 'exchange:$exchangeId';
}

/// The loop lifecycle: solve → propose → (accept | decline | expire).
///
/// Every transition happens inside one database transaction with the rows it
/// touches locked, so a listing can never sit in two live loops and a loop
/// can never be both confirmed and dissolved. Notifications and scheduling
/// happen only after the transaction has committed.
abstract final class LoopService {
  static const engine = LoopEngine();
  static const solveDebounce = Duration(seconds: 2);
  static final _random = Random.secure();

  static DateTime get _now => DateTime.now().toUtc();

  // ---------------------------------------------------------------------------
  // Solving and proposing
  // ---------------------------------------------------------------------------

  /// Schedules a (debounced) solve of [exchangeId]. Bursts of listing changes
  /// collapse into one engine run.
  static Future<void> scheduleSolve(
    Session session,
    int exchangeId, {
    Duration delay = solveDebounce,
  }) async {
    await Jobs.solveSoon(exchangeId, delay);
  }

  /// Runs the engine over [exchangeId] and proposes every loop it chooses.
  /// Returns null when another solve for the same exchange holds the lock.
  static Future<SolverRun?> solveExchange(
    Session session,
    int exchangeId, {
    required String trigger,
  }) async {
    final exchange = await Exchange.db.findById(session, exchangeId);
    if (exchange == null) return null;

    final proposed = <(SwapLoop, List<LoopSeat>)>[];
    final run = await session.db.transaction((tx) async {
      // One solver per exchange at a time; a busy exchange retries shortly.
      final lock = await session.db.unsafeQuery(
        'SELECT pg_try_advisory_xact_lock(4242, @id)',
        parameters: QueryParameters.named({'id': exchangeId}),
        transaction: tx,
      );
      if (lock.first[0] != true) return null;

      final edges = await buildEdges(session, exchangeId, transaction: tx);
      final result = engine.solve(
        edges,
        maxLoopSize: exchange.maxLoopSize,
        priority: exchange.isSimulated
            ? await _realPeople(session, exchangeId, tx)
            : const {},
      );

      final ids = {for (final l in result.loops) ...l.nodes};
      final listings = ids.isEmpty
          ? <Listing>[]
          : await Listing.db.find(
              session,
              where: (t) => t.id.inSet(ids),
              lockMode: LockMode.forUpdate,
              transaction: tx,
            );
      final byId = {for (final l in listings) l.id!: l};

      final chosen = <(CandidateLoop, List<Listing>)>[];
      for (final candidate in result.loops) {
        final members = [for (final n in candidate.nodes) byId[n]];
        if (members.any((l) => l?.status != ListingStatus.active)) continue;
        chosen.add((candidate, members.cast<Listing>()));
      }
      proposed.addAll(await _proposeAll(session, tx, exchange, chosen));

      final active = await Listing.db.count(
        session,
        where: (t) =>
            t.exchangeId.equals(exchangeId) &
            t.status.inSet({ListingStatus.active, ListingStatus.reserved}),
        transaction: tx,
      );
      return SolverRun.db.insertRow(
        session,
        SolverRun(
          exchangeId: exchangeId,
          trigger: trigger,
          activeListings: active,
          edgeCount: result.edgeCount,
          coreSize: result.coreSize,
          candidateCount: result.candidateCount,
          loopsProposed: proposed.length,
          peopleInLoops: proposed.fold(0, (s, p) => s + p.$1.size),
          pairwisePeople: result.pairwisePeople,
          elapsedMs: result.elapsed.inMilliseconds,
        ),
        transaction: tx,
      );
    });

    if (run == null) {
      await scheduleSolve(session, exchangeId, delay: solveDebounce * 2);
      return null;
    }

    for (final (loop, seats) in proposed) {
      await Jobs.loopDeadline(loop.id!, loop.deadline);
      await _notifyMembers(session, loop, seats);
      await _postMarket(
        session,
        exchangeId,
        MarketEventKind.loopProposed,
        loop: await _trace(session, loop, seats),
      );
    }
    await Bots.onProposed(session, exchange, proposed);
    await _postMarket(
      session,
      exchangeId,
      MarketEventKind.solverRan,
      run: run,
      activeListings: run.activeListings,
    );
    return run;
  }

  /// Active listings of real (non-simulated) members in an exchange.
  static Future<Set<int>> _realPeople(
    Session session,
    int exchangeId,
    Transaction tx,
  ) async {
    final rows = await session.db.unsafeQuery(
      r'''SELECT l.id FROM listing l JOIN member m ON m.id = l."memberId"
          WHERE l."exchangeId" = @id AND l."status" = 'active'
            AND m."isBot" = false''',
      parameters: QueryParameters.named({'id': exchangeId}),
      transaction: tx,
    );
    return {for (final r in rows) r[0] as int};
  }

  /// Writes every loop chosen by one engine run with four batched queries
  /// (loops, seats, listing reservations, events), whatever the number of
  /// loops — round trips dominate on a remote database.
  static Future<List<(SwapLoop, List<LoopSeat>)>> _proposeAll(
    Session session,
    Transaction tx,
    Exchange exchange,
    List<(CandidateLoop, List<Listing>)> chosen,
  ) async {
    if (chosen.isEmpty) return [];
    final deadline = _now.add(Duration(minutes: exchange.acceptWindowMinutes));
    final codes = [for (final _ in chosen) _newCode()];
    final inserted = await SwapLoop.db.insert(
      session,
      [
        for (var k = 0; k < chosen.length; k++)
          SwapLoop(
            exchangeId: exchange.id!,
            size: chosen[k].$1.size,
            score: chosen[k].$1.score,
            publicCode: codes[k],
            deadline: deadline,
          ),
      ],
      transaction: tx,
    );
    final byCode = {for (final l in inserted) l.publicCode: l};
    final loops = [for (final c in codes) byCode[c]!];

    final seats = await LoopSeat.db.insert(
      session,
      [
        for (var k = 0; k < chosen.length; k++)
          for (var i = 0; i < chosen[k].$2.length; i++)
            LoopSeat(
              loopId: loops[k].id!,
              listingId: chosen[k].$2[i].id!,
              memberId: chosen[k].$2[i].memberId,
              position: i,
              fromPlaceId: chosen[k].$2[i].currentPlaceId,
              toPlaceId:
                  chosen[k].$2[(i + 1) % chosen[k].$2.length].currentPlaceId,
              wishRank: chosen[k].$1.edges[i].wishRank,
              km: chosen[k].$1.edges[i].km,
            ),
      ],
      transaction: tx,
    );
    await Listing.db.update(
      session,
      [
        for (final (_, listings) in chosen)
          for (final l in listings)
            l.copyWith(status: ListingStatus.reserved, updatedAt: _now),
      ],
      transaction: tx,
    );
    await LoopEvent.db.insert(
      session,
      [
        for (final l in loops)
          LoopEvent(loopId: l.id!, kind: LoopEventKind.proposed),
      ],
      transaction: tx,
    );
    return [
      for (final l in loops)
        (
          l,
          seats.where((s) => s.loopId == l.id).toList()
            ..sort((a, b) => a.position.compareTo(b.position)),
        ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Responding
  // ---------------------------------------------------------------------------

  /// Records [memberId]'s answer to [loopId]. Confirms the loop when the last
  /// seat accepts; dissolves it on any decline. Idempotent for repeated
  /// identical answers.
  static Future<SwapLoop> respond(
    Session session, {
    required int loopId,
    required int memberId,
    required bool accept,
  }) async {
    final (loop, seats, changed) = await session.db.transaction((tx) async {
      final loop = await SwapLoop.db.findById(
        session,
        loopId,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (loop == null) throw _error(LoopErrorCode.notFound, 'Loop not found.');
      var seats = await _seats(session, loopId, tx);
      final seat = seats.where((s) => s.memberId == memberId).firstOrNull;
      if (seat == null) {
        throw _error(LoopErrorCode.notAllowed, 'You are not in this loop.');
      }

      final wanted = accept ? SeatResponse.accepted : SeatResponse.declined;
      if (seat.response == wanted) return (loop, seats, false);
      if (loop.status != LoopStatus.proposed ||
          seat.response != SeatResponse.pending) {
        throw _error(
          LoopErrorCode.invalidState,
          'This loop is no longer waiting for your answer.',
        );
      }

      final updated = await LoopSeat.db.updateRow(
        session,
        seat.copyWith(response: wanted, respondedAt: _now),
        transaction: tx,
      );
      seats = [for (final s in seats) s.id == updated.id ? updated : s];
      await LoopEvent.db.insertRow(
        session,
        LoopEvent(
          loopId: loopId,
          kind: accept ? LoopEventKind.accepted : LoopEventKind.declined,
          // Who declined is never revealed, not even to the loop.
          seatPosition: accept ? seat.position : null,
        ),
        transaction: tx,
      );

      if (!accept) {
        final dissolved = await _dissolve(
          session,
          tx,
          loop,
          seats,
          LoopStatus.declined,
          decliner: updated,
        );
        return (dissolved, seats, true);
      }
      if (seats.every((s) => s.response == SeatResponse.accepted)) {
        return (await _confirm(session, tx, loop, seats), seats, true);
      }
      return (loop, seats, true);
    });

    if (changed) await _afterChange(session, loop, seats);
    return loop;
  }

  /// Deadline reached: silent members are paused (so they stop blocking
  /// others), everyone else goes back into the market.
  static Future<void> expire(Session session, int loopId) async {
    final result = await session.db.transaction((tx) async {
      final loop = await SwapLoop.db.findById(
        session,
        loopId,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (loop == null || loop.status != LoopStatus.proposed) return null;
      if (loop.deadline.isAfter(_now.add(const Duration(seconds: 5)))) {
        return null; // Fired early (clock skew); the sweep will retry.
      }
      final seats = await _seats(session, loopId, tx);
      final dissolved = await _dissolve(
        session,
        tx,
        loop,
        seats,
        LoopStatus.expired,
      );
      return (dissolved, await _seats(session, loopId, tx));
    });
    if (result != null) await _afterChange(session, result.$1, result.$2);
  }

  static Future<SwapLoop> _confirm(
    Session session,
    Transaction tx,
    SwapLoop loop,
    List<LoopSeat> seats,
  ) async {
    final listings = await _lockListings(session, tx, seats);
    await Listing.db.update(
      session,
      [
        for (final l in listings)
          l.copyWith(status: ListingStatus.matched, updatedAt: _now),
      ],
      transaction: tx,
    );
    await LoopEvent.db.insertRow(
      session,
      LoopEvent(loopId: loop.id!, kind: LoopEventKind.confirmed),
      transaction: tx,
    );
    return SwapLoop.db.updateRow(
      session,
      loop.copyWith(status: LoopStatus.confirmed, resolvedAt: _now),
      transaction: tx,
    );
  }

  static Future<SwapLoop> _dissolve(
    Session session,
    Transaction tx,
    SwapLoop loop,
    List<LoopSeat> seats,
    LoopStatus status, {
    LoopSeat? decliner,
  }) async {
    final listings = {
      for (final l in await _lockListings(session, tx, seats)) l.id!: l,
    };
    final silent = <int>{};
    if (status == LoopStatus.expired) {
      for (final s in seats.where((s) => s.response == SeatResponse.pending)) {
        silent.add(s.listingId);
        await LoopSeat.db.updateRow(
          session,
          s.copyWith(response: SeatResponse.timedOut, respondedAt: _now),
          transaction: tx,
        );
      }
    }
    if (decliner != null) {
      final next = seats[(decliner.position + 1) % seats.length];
      await DeclinedEdge.db.insert(
        session,
        [
          DeclinedEdge(
            fromListingId: decliner.listingId,
            toListingId: next.listingId,
          ),
        ],
        ignoreConflicts: true,
        transaction: tx,
      );
    }
    await Listing.db.update(
      session,
      [
        for (final l in listings.values)
          if (l.status == ListingStatus.reserved)
            l.copyWith(
              status: silent.contains(l.id)
                  ? ListingStatus.paused
                  : ListingStatus.active,
              updatedAt: _now,
            ),
      ],
      transaction: tx,
    );
    if (status == LoopStatus.expired) {
      await LoopEvent.db.insertRow(
        session,
        LoopEvent(loopId: loop.id!, kind: LoopEventKind.expired),
        transaction: tx,
      );
    }
    return SwapLoop.db.updateRow(
      session,
      loop.copyWith(status: status, resolvedAt: _now),
      transaction: tx,
    );
  }

  static Future<void> _afterChange(
    Session session,
    SwapLoop loop,
    List<LoopSeat> seats,
  ) async {
    await _notifyMembers(session, loop, seats);
    switch (loop.status) {
      case LoopStatus.confirmed:
        await Jobs.cancelLoopDeadline(loop.id!);
        await _postMarket(
          session,
          loop.exchangeId,
          MarketEventKind.loopConfirmed,
          loop: await _trace(session, loop, seats),
        );
      case LoopStatus.declined || LoopStatus.expired:
        await Jobs.cancelLoopDeadline(loop.id!);
        await _postMarket(
          session,
          loop.exchangeId,
          MarketEventKind.loopDissolved,
          loop: await _trace(session, loop, seats),
        );
        await scheduleSolve(session, loop.exchangeId);
      case LoopStatus.proposed:
        break;
    }
  }

  // ---------------------------------------------------------------------------
  // Sweep
  // ---------------------------------------------------------------------------

  /// Periodic safety net: expires overdue loops whose deadline call was lost,
  /// tops up simulated markets, and re-solves every exchange.
  static Future<void> sweep(Session session) async {
    final overdue = await SwapLoop.db.find(
      session,
      where: (t) =>
          t.status.equals(LoopStatus.proposed) &
          (t.deadline < _now.subtract(const Duration(minutes: 1))),
    );
    for (final loop in overdue) {
      await expire(session, loop.id!);
    }
    for (final exchange in await Exchange.db.find(session)) {
      if (exchange.isSimulated) await Bots.replenish(session, exchange);
      await solveExchange(session, exchange.id!, trigger: 'sweep');
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  static Future<List<LoopSeat>> _seats(
    Session session,
    int loopId, [
    Transaction? tx,
  ]) => LoopSeat.db.find(
    session,
    where: (t) => t.loopId.equals(loopId),
    orderBy: (t) => t.position,
    transaction: tx,
  );

  static Future<List<Listing>> _lockListings(
    Session session,
    Transaction tx,
    List<LoopSeat> seats,
  ) => Listing.db.find(
    session,
    where: (t) => t.id.inSet(<int>{for (final s in seats) s.listingId}),
    lockMode: LockMode.forUpdate,
    transaction: tx,
  );

  static Future<void> _notifyMembers(
    Session session,
    SwapLoop loop,
    List<LoopSeat> seats,
  ) async {
    final update = MemberUpdate(
      loopId: loop.id!,
      status: loop.status,
      at: _now,
    );
    for (final memberId in {for (final s in seats) s.memberId}) {
      await session.messages.postMessage(Channels.member(memberId), update);
    }
  }

  static Future<LoopTrace> _trace(
    Session session,
    SwapLoop loop,
    List<LoopSeat> seats,
  ) async => LoopTrace(
    loopId: loop.id!,
    status: loop.status,
    placeIds: [for (final s in seats) s.fromPlaceId],
    at: _now,
  );

  static Future<void> postListingsChanged(
    Session session,
    int exchangeId,
  ) async {
    final active = await Listing.db.count(
      session,
      where: (t) =>
          t.exchangeId.equals(exchangeId) &
          t.status.inSet({ListingStatus.active, ListingStatus.reserved}),
    );
    await _postMarket(
      session,
      exchangeId,
      MarketEventKind.listingsChanged,
      activeListings: active,
    );
  }

  static Future<void> _postMarket(
    Session session,
    int exchangeId,
    MarketEventKind kind, {
    LoopTrace? loop,
    SolverRun? run,
    int? activeListings,
  }) => session.messages.postMessage(
    Channels.exchange(exchangeId),
    MarketEvent(
      exchangeId: exchangeId,
      kind: kind,
      loop: loop,
      run: run,
      activeListings: activeListings,
      at: _now,
    ),
  );

  /// Short, unambiguous public code (no 0/O, 1/I).
  static String _newCode() {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final chars = List.generate(
      8,
      (_) => alphabet[_random.nextInt(alphabet.length)],
    );
    return '${chars.take(4).join()}-${chars.skip(4).join()}';
  }

  static LoopException _error(LoopErrorCode code, String message) =>
      LoopException(code: code, message: message);
}
