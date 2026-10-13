import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'jobs.dart';
import 'loop_service.dart';
import 'simulation.dart';

/// Simulated members. They exist only in exchanges flagged `isSimulated`
/// (clearly labelled in the app) so the market, the map and the sandbox are
/// alive for demos. Real members are never mixed with bots outside of those.
abstract final class Bots {
  static final _rng = Random();

  /// How many live listings each simulated exchange is kept at.
  static int targetSize(Exchange e) =>
      e.isSandbox ? 50 : (e.state == null ? 180 : 150);

  // ---------------------------------------------------------------------------
  // Answering proposals
  // ---------------------------------------------------------------------------

  /// Schedules an answer for every bot seat. In the sandbox bots answer within
  /// seconds (and always accept) so a visitor sees the loop close live.
  static Future<void> onProposed(
    Session session,
    Exchange exchange,
    List<(SwapLoop, List<LoopSeat>)> proposed,
  ) async {
    if (proposed.isEmpty) return;
    final members = await Member.db.find(
      session,
      where: (t) => t.id.inSet(<int>{
        for (final (_, seats) in proposed)
          for (final s in seats) s.memberId,
      }),
    );
    final bots = {
      for (final m in members)
        if (m.isBot) m.id!,
    };
    for (final (loop, seats) in proposed) {
      final hasHuman = seats.any((s) => !bots.contains(s.memberId));
      for (final seat in seats.where((s) => bots.contains(s.memberId))) {
        final seconds = hasHuman
            ? 3 + _rng.nextInt(6)
            : Simulation.watched(exchange.id!)
            ? 4 + _rng.nextInt(26)
            : 20 + _rng.nextInt(160);
        await Jobs.botReply(
          loop.id!,
          seat.position,
          Duration(seconds: seconds),
        );
      }
    }
  }

  static Future<void> respond(
    Session session,
    int loopId,
    int seatPosition,
  ) async {
    final loop = await SwapLoop.db.findById(session, loopId);
    if (loop == null || loop.status != LoopStatus.proposed) return;
    final seat = await LoopSeat.db.findFirstRow(
      session,
      where: (t) => t.loopId.equals(loopId) & t.position.equals(seatPosition),
    );
    if (seat == null || seat.response != SeatResponse.pending) return;
    final member = await Member.db.findById(session, seat.memberId);
    if (member == null || !member.isBot) return;

    final exchange = await Exchange.db.findById(session, loop.exchangeId);
    final accept = exchange?.isSandbox == true || _rng.nextDouble() < 0.9;
    try {
      await LoopService.respond(
        session,
        loopId: loopId,
        memberId: member.id!,
        accept: accept,
      );
    } on LoopException {
      // The loop moved on while we were "thinking"; nothing to do.
    }
  }

  // ---------------------------------------------------------------------------
  // Populating simulated markets
  // ---------------------------------------------------------------------------

  /// Tops a simulated exchange back up towards [targetSize] so loops keep
  /// forming, and clears out old settled bot listings.
  static Future<int> replenish(
    Session session,
    Exchange exchange, {
    int? max,
  }) async {
    final cutoff = DateTime.now().toUtc().subtract(const Duration(hours: 6));
    final stale = await Listing.db.find(
      session,
      where: (t) =>
          t.exchangeId.equals(exchange.id!) &
          t.status.inSet({
            ListingStatus.matched,
            ListingStatus.paused,
            ListingStatus.withdrawn,
          }) &
          (t.updatedAt < cutoff),
    );
    final staleBots = await Member.db.find(
      session,
      where: (t) =>
          t.id.inSet(<int>{for (final l in stale) l.memberId}) &
          t.isBot.equals(true),
    );
    if (staleBots.isNotEmpty) await Member.db.delete(session, staleBots);

    final live = await Listing.db.count(
      session,
      where: (t) =>
          t.exchangeId.equals(exchange.id!) &
          t.status.inSet({ListingStatus.active, ListingStatus.reserved}),
    );
    final missing = targetSize(exchange) - live;
    if (missing <= 0) return 0;
    final count = min(missing, max ?? 8);

    final places = await _placesFor(session, exchange);
    if (places.length < 3) return 0;
    final specs = <(Place, List<(Place, int)>)>[];
    for (var i = 0; i < count; i++) {
      final here = _pickPosting(places);
      specs.add((here, _pickWishes(places, here)));
    }
    await _createBotListings(session, exchange, specs);
    await LoopService.postListingsChanged(session, exchange.id!);
    return count;
  }

  /// While an exchange is watched: a few simulated colleagues arrive, the
  /// longest-waiting ones give up once the market is over its size, and the
  /// engine runs straight away.
  static Future<void> pulse(Session session, int exchangeId) async {
    final exchange = await Exchange.db.findById(session, exchangeId);
    if (exchange == null || !exchange.isSimulated || exchange.isSandbox) return;
    final places = await _placesFor(session, exchange);
    if (places.length < 3) return;

    // Two newcomers who close a 3-way loop with someone already waiting:
    // X (at P) wants W; Y arrives at W wanting V; Z arrives at V wanting P.
    // Plus one ordinary arrival.
    final byId = {for (final p in places) p.id!: p};
    final waiting = await session.db.unsafeQuery(
      r'''
SELECT x."currentPlaceId", w."placeId"
FROM listing x
JOIN wish w ON w."listingId" = x.id AND w."radiusKm" = 0
WHERE x."exchangeId" = @id AND x."status" = 'active'
ORDER BY random()
LIMIT 1''',
      parameters: QueryParameters.named({'id': exchangeId}),
    );
    final specs = <(Place, List<(Place, int)>)>[];
    for (final row in waiting) {
      final at = byId[row[0] as int];
      final wanted = byId[row[1] as int];
      if (at == null || wanted == null) continue;
      final via = places
          .where((p) => p.id != at.id && p.id != wanted.id)
          .toList()[_rng.nextInt(places.length - 2)];
      specs
        ..add((wanted, [(via, 0)]))
        ..add((via, [(at, 0)]));
    }
    final here = _pickPosting(places);
    specs.add((here, _pickWishes(places, here)));
    await _createBotListings(session, exchange, specs);
    await session.db.unsafeExecute(
      r'''
UPDATE listing SET "status" = 'withdrawn', "updatedAt" = now()
WHERE id IN (
  SELECT l.id FROM listing l JOIN member m ON m.id = l."memberId"
  WHERE l."exchangeId" = @id AND l."status" = 'active' AND m."isBot"
  ORDER BY l."createdAt"
  LIMIT GREATEST(0, (
    SELECT COUNT(*) FROM listing x
    WHERE x."exchangeId" = @id AND x."status" IN ('active', 'reserved')
  ) - @target)
)''',
      parameters: QueryParameters.named({
        'id': exchangeId,
        'target': targetSize(exchange),
      }),
    );
    await LoopService.solveExchange(session, exchangeId, trigger: 'arrivals');
    await LoopService.postListingsChanged(session, exchangeId);
  }

  /// Timer mode only: replies scheduled in memory are lost when the server
  /// restarts. Re-schedule any simulated answer that is overdue.
  static Future<void> recoverPending(Session session) async {
    final rows = await session.db.unsafeQuery(r'''
SELECT s."loopId", s."position"
FROM loop_seat s
JOIN swap_loop l ON l.id = s."loopId"
JOIN member m ON m.id = s."memberId"
WHERE l."status" = 'proposed' AND s."response" = 'pending' AND m."isBot"
  AND l."createdAt" < now() - interval '2 minutes'
LIMIT 500''');
    for (final r in rows) {
      await Jobs.botReply(
        r[0] as int,
        r[1] as int,
        Duration(seconds: 1 + _rng.nextInt(30)),
      );
    }
  }

  /// Sandbox only: adds simulated colleagues that close a 3-way loop with a
  /// visitor's listing, so the full flow can be tried in under a minute.
  static Future<void> completeLoopFor(
    Session session,
    Exchange exchange,
    Listing listing,
    List<Wish> wishes,
  ) async {
    if (!exchange.isSandbox || wishes.isEmpty) return;
    final places = await _placesFor(session, exchange);
    final first = wishes.first.placeId;
    final others = places
        .where((p) => p.id != first && p.id != listing.currentPlaceId)
        .toList();
    if (others.isEmpty) return;
    final via = others[_rng.nextInt(others.length)];

    // listing → A (at the visitor's first wish) → B (at `via`) → listing.
    final byId = {for (final p in places) p.id!: p};
    await _createBotListings(session, exchange, [
      (byId[first]!, [(via, 0)]),
      (via, [(byId[listing.currentPlaceId]!, 0)]),
    ]);
  }

  /// Creates simulated members with their listings and wishes in three
  /// batched queries.
  static Future<void> _createBotListings(
    Session session,
    Exchange exchange,
    List<(Place, List<(Place, int)>)> specs,
  ) async {
    if (specs.isEmpty) return;
    final tag = DateTime.now().microsecondsSinceEpoch;
    String email(int i) => 'simulated-$tag-$i@loop.example';
    final members = await Member.db.insert(session, [
      for (var i = 0; i < specs.length; i++)
        Member(displayName: _name(), contactEmail: email(i), isBot: true),
    ]);
    final memberIds = {for (final m in members) m.contactEmail: m.id!};
    final listings = await Listing.db.insert(session, [
      for (var i = 0; i < specs.length; i++)
        Listing(
          memberId: memberIds[email(i)]!,
          exchangeId: exchange.id!,
          currentPlaceId: specs[i].$1.id!,
          postTitle: '${exchange.cadre}, ${specs[i].$1.name}',
          yearsInPost: 1 + _rng.nextInt(11),
        ),
    ]);
    final listingIds = {for (final l in listings) l.memberId: l.id!};
    await Wish.db.insert(session, [
      for (var i = 0; i < specs.length; i++)
        for (var r = 0; r < specs[i].$2.length; r++)
          Wish(
            listingId: listingIds[memberIds[email(i)]!]!,
            placeId: specs[i].$2[r].$1.id!,
            radiusKm: specs[i].$2[r].$2,
            rank: r,
            point: specs[i].$2[r].$1.point,
          ),
    ]);
  }

  static Future<List<Place>> _placesFor(Session session, Exchange e) {
    if (e.state != null) {
      return Place.db.find(session, where: (t) => t.state.equals(e.state!));
    }
    // All-India exchanges: the 120 most populous districts.
    return Place.db.find(
      session,
      orderBy: (t) => t.population.desc(),
      limit: 120,
    );
  }

  /// Postings skew towards smaller districts: that is where people are sent
  /// and where they want to leave from.
  static Place _pickPosting(List<Place> places) =>
      _weighted(places, (p) => 1 / sqrt(max(p.population, 50000)));

  /// One to three wishes: a hometown / spouse's district, a big city with a
  /// radius, or somewhere near the current posting.
  static List<(Place, int)> _pickWishes(List<Place> places, Place here) {
    final count = 1 + _rng.nextInt(3);
    final out = <(Place, int)>[];
    for (var i = 0; i < count; i++) {
      final roll = _rng.nextDouble();
      Place target;
      var radius = 0;
      if (roll < 0.45) {
        target = _weighted(places, (p) => sqrt(max(p.population, 50000)));
      } else if (roll < 0.75) {
        target = _weighted(
          places,
          (p) => pow(max(p.population, 50000), 0.9).toDouble(),
        );
        radius = [40, 60, 80][_rng.nextInt(3)];
      } else {
        final near = places
            .where((p) => p.id != here.id && _km(p, here) < 180)
            .toList();
        target = near.isEmpty
            ? places[_rng.nextInt(places.length)]
            : near[_rng.nextInt(near.length)];
      }
      if (target.id == here.id || out.any((w) => w.$1.id == target.id)) {
        continue;
      }
      out.add((target, radius));
    }
    if (out.isEmpty) {
      out.add((places.firstWhere((p) => p.id != here.id), 0));
    }
    return out;
  }

  static Place _weighted(List<Place> places, double Function(Place) weight) {
    final weights = [for (final p in places) weight(p)];
    var roll = _rng.nextDouble() * weights.fold(0.0, (a, b) => a + b);
    for (var i = 0; i < places.length; i++) {
      roll -= weights[i];
      if (roll <= 0) return places[i];
    }
    return places.last;
  }

  static double _km(Place a, Place b) {
    const r = 6371.0;
    double rad(double d) => d * pi / 180;
    final dLat = rad(b.point.latitude - a.point.latitude);
    final dLon = rad(b.point.longitude - a.point.longitude);
    final h =
        pow(sin(dLat / 2), 2) +
        cos(rad(a.point.latitude)) *
            cos(rad(b.point.latitude)) *
            pow(sin(dLon / 2), 2);
    return 2 * r * asin(sqrt(h));
  }

  static const _first = [
    'Aarti',
    'Abhishek',
    'Aditi',
    'Ajay',
    'Amit',
    'Anita',
    'Anjali',
    'Arjun',
    'Deepa',
    'Ganesh',
    'Geeta',
    'Harish',
    'Kavita',
    'Kiran',
    'Lakshmi',
    'Mahesh',
    'Manoj',
    'Meena',
    'Mohan',
    'Neha',
    'Nikhil',
    'Pooja',
    'Prakash',
    'Priya',
    'Rahul',
    'Rajesh',
    'Rekha',
    'Rohit',
    'Sachin',
    'Sangeeta',
    'Santosh',
    'Shweta',
    'Sneha',
    'Sunil',
    'Sunita',
    'Suresh',
    'Swati',
    'Vandana',
    'Vijay',
    'Vinod',
  ];

  static String _name() =>
      '${_first[_rng.nextInt(_first.length)]} '
      '${String.fromCharCode(65 + _rng.nextInt(26))}.';
}
