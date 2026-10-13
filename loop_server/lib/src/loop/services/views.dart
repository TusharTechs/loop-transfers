import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'edges.dart';

/// Builds the client-facing views. Identities of other members are only
/// included once a loop is confirmed by everyone in it.
abstract final class Views {
  static Future<LoopView> loop(
    Session session,
    SwapLoop loop,
    int viewerMemberId,
  ) async {
    final seats = await LoopSeat.db.find(
      session,
      where: (t) => t.loopId.equals(loop.id!),
      orderBy: (t) => t.position,
    );
    final placeIds = {for (final s in seats) ...[s.fromPlaceId, s.toPlaceId]};
    final places = {
      for (final p in await Place.db.find(session, where: (t) => t.id.inSet(placeIds)))
        p.id!: p,
    };
    final listings = {
      for (final l in await Listing.db.find(session,
          where: (t) => t.id.inSet(<int>{for (final s in seats) s.listingId})))
        l.id!: l,
    };
    final revealed = loop.status == LoopStatus.confirmed;
    final members = {
      for (final m in await Member.db.find(session,
          where: (t) => t.id.inSet(<int>{for (final s in seats) s.memberId})))
        m.id!: m,
    };
    final exchange = await Exchange.db.findById(session, loop.exchangeId);
    final events = await LoopEvent.db.find(
      session,
      where: (t) => t.loopId.equals(loop.id!),
      orderBy: (t) => t.at,
    );

    final views = <SeatView>[];
    var myPosition = -1;
    for (final s in seats) {
      final isMe = s.memberId == viewerMemberId;
      if (isMe) myPosition = s.position;
      final from = places[s.fromPlaceId]!;
      final listing = listings[s.listingId];
      final member = members[s.memberId];
      final show = revealed || isMe;
      views.add(SeatView(
        position: s.position,
        label: '${exchange?.cadre ?? 'Member'} · ${from.name}',
        fromPlace: from,
        toPlace: places[s.toPlaceId]!,
        isMe: isMe,
        response: s.response,
        wishRank: s.wishRank,
        km: s.km,
        yearsInPost: listing?.yearsInPost ?? 0,
        name: show ? member?.displayName : null,
        phone: show ? member?.phone : null,
        email: show ? member?.contactEmail : null,
        postTitle: show ? listing?.postTitle : null,
      ));
    }

    return LoopView(
      id: loop.id!,
      exchangeId: loop.exchangeId,
      exchangeName: exchange?.name ?? '',
      status: loop.status,
      size: loop.size,
      createdAt: loop.createdAt,
      deadline: loop.deadline,
      resolvedAt: loop.resolvedAt,
      seats: views,
      myPosition: myPosition,
      events: events,
      publicCode: revealed ? loop.publicCode : null,
    );
  }

  static Future<MyListing> myListing(Session session, Listing listing) async {
    final exchange = await Exchange.db.findById(session, listing.exchangeId);
    final withPlace = await Listing.db.findById(
      session,
      listing.id!,
      include: Listing.include(currentPlace: Place.include()),
    );
    final wishes = await Wish.db.find(
      session,
      where: (t) => t.listingId.equals(listing.id!),
      orderBy: (t) => t.rank,
      include: Wish.include(place: Place.include()),
    );
    final mySeats = await LoopSeat.db.find(
      session,
      where: (t) => t.listingId.equals(listing.id!),
    );
    final live = mySeats.isEmpty
        ? null
        : await SwapLoop.db.findFirstRow(
            session,
            where: (t) =>
                t.id.inSet(<int>{for (final s in mySeats) s.loopId}) &
                t.status.equals(LoopStatus.proposed),
          );
    final demand = await demandFor(
      session,
      exchangeId: listing.exchangeId,
      listingId: listing.id!,
      placeId: listing.currentPlaceId,
    );
    return MyListing(
      listing: withPlace!,
      exchange: exchange!,
      wishes: wishes,
      activeLoopId: live?.id,
      wantMyPlace: demand.wantMyPlace,
      atMyWishes: demand.atMyWishes,
    );
  }
}
