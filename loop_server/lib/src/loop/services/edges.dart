import 'package:serverpod/serverpod.dart';

import '../../engine/loop_engine.dart';

/// Builds the "would accept" graph of one exchange inside Postgres.
///
/// An edge a→b exists when b's current posting satisfies one of a's wishes:
/// either the exact district (radius 0) or within the wish radius, using a
/// PostGIS `ST_DWithin` on geography (metres). For each pair only the best
/// ranked wish is kept. Declined moves are excluded forever.
Future<List<SwapEdge>> buildEdges(
  Session session,
  int exchangeId, {
  Transaction? transaction,
}) async {
  final rows = await session.db.unsafeQuery(
    r'''
SELECT DISTINCT ON (a.id, b.id)
       a.id AS "from",
       b.id AS "to",
       w."rank" AS "rank",
       ST_Distance(w."point", p."point") / 1000.0 AS "km"
FROM listing a
JOIN wish w ON w."listingId" = a.id
JOIN listing b
  ON b."exchangeId" = a."exchangeId"
 AND b.id <> a.id
 AND b."status" = 'active'
 AND b."currentPlaceId" <> a."currentPlaceId"
JOIN place p ON p.id = b."currentPlaceId"
WHERE a."exchangeId" = @exchangeId
  AND a."status" = 'active'
  AND (
        (w."radiusKm" = 0 AND w."placeId" = b."currentPlaceId")
     OR (w."radiusKm" > 0 AND ST_DWithin(w."point", p."point", w."radiusKm" * 1000.0))
  )
  AND NOT EXISTS (
        SELECT 1 FROM declined_edge d
        WHERE d."fromListingId" = a.id AND d."toListingId" = b.id
  )
ORDER BY a.id, b.id, w."rank" ASC
''',
    parameters: QueryParameters.named({'exchangeId': exchangeId}),
    transaction: transaction,
  );
  return [
    for (final row in rows)
      SwapEdge(
        from: row[0] as int,
        to: row[1] as int,
        wishRank: row[2] as int,
        km: (row[3] as num).toDouble(),
      ),
  ];
}

/// How many active members of the exchange want [placeId] (and are not
/// already there), and how many are posted where [listingId] wants to go.
Future<({int wantMyPlace, int atMyWishes})> demandFor(
  Session session, {
  required int exchangeId,
  required int listingId,
  required int placeId,
}) async {
  final rows = await session.db.unsafeQuery(
    r'''
SELECT
  (SELECT COUNT(DISTINCT a.id)
     FROM listing a
     JOIN wish w ON w."listingId" = a.id
     JOIN place p ON p.id = @placeId
    WHERE a."exchangeId" = @exchangeId AND a.id <> @listingId
      AND a."status" IN ('active', 'reserved')
      AND a."currentPlaceId" <> @placeId
      AND ((w."radiusKm" = 0 AND w."placeId" = @placeId)
        OR (w."radiusKm" > 0 AND ST_DWithin(w."point", p."point", w."radiusKm" * 1000.0)))
  ) AS "wantMyPlace",
  (SELECT COUNT(DISTINCT b.id)
     FROM wish w
     JOIN listing b ON b."exchangeId" = @exchangeId AND b.id <> @listingId
      AND b."status" IN ('active', 'reserved')
     JOIN place p ON p.id = b."currentPlaceId"
    WHERE w."listingId" = @listingId
      AND b."currentPlaceId" <> @placeId
      AND ((w."radiusKm" = 0 AND w."placeId" = b."currentPlaceId")
        OR (w."radiusKm" > 0 AND ST_DWithin(w."point", p."point", w."radiusKm" * 1000.0)))
  ) AS "atMyWishes"
''',
    parameters: QueryParameters.named({
      'exchangeId': exchangeId,
      'listingId': listingId,
      'placeId': placeId,
    }),
  );
  final row = rows.first;
  return (wantMyPlace: row[0] as int, atMyWishes: row[1] as int);
}
