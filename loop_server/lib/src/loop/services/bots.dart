import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'jobs.dart';
import 'loop_service.dart';

/// Simulated members. They exist only in exchanges flagged `isSimulated`
/// (clearly labelled in the app) so the market, the map and the sandbox are
/// alive for demos. Real members are never mixed with bots outside of those.
abstract final class Bots {
  static final _rng = Random();

  /// How many live listings each simulated exchange is kept at.
  static int targetSize(Exchange e) =>
      e.isSandbox ? 60 : (e.state == null ? 300 : 240);

  // ---------------------------------------------------------------------------
  // Answering proposals
  // ---------------------------------------------------------------------------

  /// Schedules an answer for every bot seat. In the sandbox bots answer within
  /// seconds (and always accept) so a visitor sees the loop close live.
  static Future<void> onProposed(
    Session session,
    Exchange exchange,
    SwapLoop loop,
    List<LoopSeat> seats,
  ) async {
    final members = await Member.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final s in seats) s.memberId}),
    );
    final bots = {
      for (final m in members)
        if (m.isBot) m.id!,
    };
    if (bots.isEmpty) return;
    final hasHuman = bots.length < members.length;
    for (final seat in seats.where((s) => bots.contains(s.memberId))) {
      final seconds = hasHuman ? 3 + _rng.nextInt(6) : 4 + _rng.nextInt(80);
      await Jobs.botReply(loop.id!, seat.position, Duration(seconds: seconds));
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
          t.status.inSet({ListingStatus.matched, ListingStatus.paused}) &
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
    final count = min(missing, max ?? 16);

    final places = await _placesFor(session, exchange);
    if (places.length < 3) return 0;
    for (var i = 0; i < count; i++) {
      await _createBotListing(session, exchange, places);
    }
    await LoopService.postListingsChanged(session, exchange.id!);
    return count;
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
    await _createBotListing(
      session,
      exchange,
      places,
      at: first,
      wants: [via.id!],
    );
    await _createBotListing(
      session,
      exchange,
      places,
      at: via.id!,
      wants: [listing.currentPlaceId],
    );
  }

  static Future<void> _createBotListing(
    Session session,
    Exchange exchange,
    List<Place> places, {
    int? at,
    List<int>? wants,
  }) async {
    final byId = {for (final p in places) p.id!: p};
    final here = at != null ? byId[at]! : _pickPosting(places);
    final wishes = wants != null
        ? [for (final id in wants) (byId[id]!, 0)]
        : _pickWishes(places, here);

    final member = await Member.db.insertRow(
      session,
      Member(
        displayName: _name(),
        contactEmail: 'simulated.member@loop.example',
        isBot: true,
      ),
    );
    final listing = await Listing.db.insertRow(
      session,
      Listing(
        memberId: member.id!,
        exchangeId: exchange.id!,
        currentPlaceId: here.id!,
        postTitle: '${exchange.cadre}, ${here.name}',
        yearsInPost: 1 + _rng.nextInt(11),
      ),
    );
    await Wish.db.insert(session, [
      for (var i = 0; i < wishes.length; i++)
        Wish(
          listingId: listing.id!,
          placeId: wishes[i].$1.id!,
          radiusKm: wishes[i].$2,
          rank: i,
          point: wishes[i].$1.point,
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
