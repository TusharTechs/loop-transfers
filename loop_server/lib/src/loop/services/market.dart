import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Read models for exchanges: summaries and the anonymised live map.
abstract final class Market {
  static const _live = {ListingStatus.active, ListingStatus.reserved};

  static Future<List<ExchangeSummary>> summaries(Session session) async {
    final exchanges = await Exchange.db.find(
      session,
      orderByList: (t) => [t.isSandbox.desc(), t.name.asc()],
    );
    return [
      for (final e in exchanges)
        ExchangeSummary(
          exchange: e,
          activeListings: await Listing.db.count(
            session,
            where: (t) => t.exchangeId.equals(e.id!) & t.status.inSet(_live),
          ),
          confirmedLoops: await SwapLoop.db.count(
            session,
            where: (t) =>
                t.exchangeId.equals(e.id!) &
                t.status.equals(LoopStatus.confirmed),
          ),
          peopleMatched: await _peopleMatched(session, e.id!),
          lastRun: await SolverRun.db.findFirstRow(
            session,
            where: (t) => t.exchangeId.equals(e.id!),
            orderBy: (t) => t.at.desc(),
          ),
        ),
    ];
  }

  static Future<int> _peopleMatched(Session session, int exchangeId) async {
    final rows = await session.db.unsafeQuery(
      r'''SELECT COALESCE(SUM("size"), 0)::bigint FROM swap_loop
          WHERE "exchangeId" = @id AND "status" = 'confirmed' ''',
      parameters: QueryParameters.named({'id': exchangeId}),
    );
    return (rows.first[0] as num).toInt();
  }

  static Future<MarketSnapshot> snapshot(
    Session session,
    int exchangeId,
  ) async {
    final params = QueryParameters.named({'id': exchangeId});
    final posted = await session.db.unsafeQuery(
      r'''SELECT "currentPlaceId", COUNT(*) FROM listing
          WHERE "exchangeId" = @id AND "status" IN ('active', 'reserved')
          GROUP BY 1''',
      parameters: params,
    );
    final flows = await session.db.unsafeQuery(
      r'''SELECT l."currentPlaceId", w."placeId", COUNT(*) FROM listing l
          JOIN wish w ON w."listingId" = l.id AND w."rank" = 0
          WHERE l."exchangeId" = @id AND l."status" IN ('active', 'reserved')
          GROUP BY 1, 2''',
      parameters: params,
    );
    final loops = await SwapLoop.db.find(
      session,
      where: (t) => t.exchangeId.equals(exchangeId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );
    final seats = loops.isEmpty
        ? <LoopSeat>[]
        : await LoopSeat.db.find(
            session,
            where: (t) => t.loopId.inSet({for (final l in loops) l.id!}),
            orderBy: (t) => t.position,
          );

    final counts = {for (final r in posted) r[0] as int: r[1] as int};
    final placeIds = {
      ...counts.keys,
      for (final f in flows) ...[f[0] as int, f[1] as int],
      for (final s in seats) s.fromPlaceId,
    };
    final places = placeIds.isEmpty
        ? <Place>[]
        : await Place.db.find(session, where: (t) => t.id.inSet(placeIds));

    final totals = await session.db.unsafeQuery(
      r'''SELECT
            (SELECT COUNT(*) FROM swap_loop WHERE "exchangeId" = @id AND "status" = 'confirmed'),
            (SELECT COALESCE(SUM("size"), 0)::bigint FROM swap_loop
              WHERE "exchangeId" = @id AND "status" = 'confirmed'),
            COALESCE(SUM(r."peopleInLoops"), 0)::bigint,
            COALESCE(SUM(r."pairwisePeople"), 0)::bigint,
            COUNT(*)
          FROM solver_run r WHERE r."exchangeId" = @id''',
      parameters: params,
    );
    final t = totals.first;
    int n(Object? v) => (v as num).toInt();

    return MarketSnapshot(
      exchangeId: exchangeId,
      confirmedLoops: n(t[0]),
      peopleMatched: n(t[1]),
      loopPeopleTotal: n(t[2]),
      pairPeopleTotal: n(t[3]),
      runs: n(t[4]),
      places: [
        for (final p in places)
          MarketPlace(
            id: p.id!,
            name: p.name,
            latitude: p.point.latitude,
            longitude: p.point.longitude,
            postedHere: counts[p.id] ?? 0,
          ),
      ],
      flows: [
        for (final f in flows)
          MarketFlow(
            fromPlaceId: f[0] as int,
            toPlaceId: f[1] as int,
            count: f[2] as int,
          ),
      ],
      loops: [
        for (final l in loops)
          LoopTrace(
            loopId: l.id!,
            status: l.status,
            placeIds: [
              for (final s in seats)
                if (s.loopId == l.id) s.fromPlaceId,
            ],
            at: l.resolvedAt ?? l.createdAt,
          ),
      ],
      activeListings: counts.values.fold(0, (a, b) => a + b),
      lastRun: await SolverRun.db.findFirstRow(
        session,
        where: (t) => t.exchangeId.equals(exchangeId),
        orderBy: (t) => t.at.desc(),
      ),
    );
  }

  /// Totals across all exchanges, for the landing page.
  static Future<
    ({int people, int loops, int listings, int loopPeople, int pairPeople})
  >
  totals(Session session) async {
    final rows = await session.db.unsafeQuery(r'''
SELECT
  (SELECT COALESCE(SUM("size"), 0)::bigint FROM swap_loop WHERE "status" = 'confirmed'),
  (SELECT COUNT(*) FROM swap_loop WHERE "status" = 'confirmed'),
  (SELECT COUNT(*) FROM listing WHERE "status" IN ('active', 'reserved')),
  (SELECT COALESCE(SUM(r."peopleInLoops"), 0)::bigint FROM solver_run r),
  (SELECT COALESCE(SUM(r."pairwisePeople"), 0)::bigint FROM solver_run r)
''');
    final r = rows.first;
    int n(Object? v) => (v as num).toInt();
    return (
      people: n(r[0]),
      loops: n(r[1]),
      listings: n(r[2]),
      loopPeople: n(r[3]),
      pairPeople: n(r[4]),
    );
  }
}
