import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../generated/protocol.dart';
import '../services/bots.dart';
import '../services/loop_service.dart';
import '../services/views.dart';
import 'member_context.dart';

/// The signed-in member's profile. Contact details are stored server side and
/// only ever shown to partners in a confirmed loop.
class MemberEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Member?> me(Session session) => currentMember(session);

  Future<MemberContact> myContact(Session session) async {
    final m = await requireMember(session);
    return MemberContact(phone: m.phone, email: m.contactEmail);
  }

  Future<Member> saveProfile(
    Session session,
    String displayName, {
    String? phone,
    String? email,
  }) async {
    final name = displayName.trim();
    if (name.length < 2 || name.length > 60) {
      throw invalid('Please enter your name (2–60 characters).');
    }
    final cleanPhone = phone?.trim().isEmpty ?? true ? null : phone!.trim();
    final cleanEmail = email?.trim().isEmpty ?? true ? null : email!.trim();
    if (cleanPhone == null && cleanEmail == null) {
      throw invalid(
        'Add a phone number or an email so loop partners can '
        'reach you once everyone has agreed.',
      );
    }
    final existing = await currentMember(session);
    if (existing != null) {
      return Member.db.updateRow(
        session,
        existing.copyWith(
          displayName: name,
          phone: cleanPhone,
          contactEmail: cleanEmail,
        ),
      );
    }
    return Member.db.insertRow(
      session,
      Member(
        authUserId: session.authenticated!.authUserId,
        displayName: name,
        phone: cleanPhone,
        contactEmail: cleanEmail,
      ),
    );
  }
}

/// Creating and managing transfer requests.
class ListingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const maxWishes = 5;
  static const maxRadiusKm = 200;

  Future<List<MyListing>> mine(Session session) async {
    final member = await requireMember(session);
    final listings = await Listing.db.find(
      session,
      where: (t) =>
          t.memberId.equals(member.id!) &
          t.status.notEquals(ListingStatus.withdrawn),
      orderBy: (t) => t.createdAt,
    );
    return [for (final l in listings) await Views.myListing(session, l)];
  }

  /// Creates or replaces the member's listing in [exchangeId].
  Future<MyListing> save(
    Session session, {
    required int exchangeId,
    required int currentPlaceId,
    required String postTitle,
    required int yearsInPost,
    required List<WishInput> wishes,
  }) async {
    final member = await requireMember(session);
    final exchange = await Exchange.db.findById(session, exchangeId);
    if (exchange == null) throw invalid('Unknown exchange.');
    if (wishes.isEmpty || wishes.length > maxWishes) {
      throw invalid('Add between 1 and $maxWishes places you would move to.');
    }
    final title = postTitle.trim();
    if (title.isEmpty || title.length > 120) {
      throw invalid('Describe your post (up to 120 characters).');
    }
    if (yearsInPost < 0 || yearsInPost > 45) {
      throw invalid('Check years in post.');
    }

    final placeIds = {currentPlaceId, for (final w in wishes) w.placeId};
    final places = {
      for (final p in await Place.db.find(
        session,
        where: (t) => t.id.inSet(placeIds),
      ))
        p.id!: p,
    };
    if (places.length != placeIds.length) throw invalid('Unknown district.');
    if (exchange.state != null &&
        places.values.any((p) => p.state != exchange.state)) {
      throw invalid('This exchange only covers ${exchange.state}.');
    }
    if (wishes.any((w) => w.placeId == currentPlaceId && w.radiusKm == 0)) {
      throw invalid('You already work there — pick other places.');
    }
    if (wishes.any((w) => w.radiusKm < 0 || w.radiusKm > maxRadiusKm)) {
      throw invalid('Radius must be between 0 and $maxRadiusKm km.');
    }

    final listing = await session.db.transaction((tx) async {
      var listing = await Listing.db.findFirstRow(
        session,
        where: (t) =>
            t.memberId.equals(member.id!) & t.exchangeId.equals(exchangeId),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (listing?.status == ListingStatus.reserved) {
        throw LoopException(
          code: LoopErrorCode.invalidState,
          message:
              'You are in a loop waiting for answers. '
              'Respond to it before editing your request.',
        );
      }
      final now = DateTime.now().toUtc();
      if (listing == null) {
        listing = await Listing.db.insertRow(
          session,
          Listing(
            memberId: member.id!,
            exchangeId: exchangeId,
            currentPlaceId: currentPlaceId,
            postTitle: title,
            yearsInPost: yearsInPost,
          ),
          transaction: tx,
        );
      } else {
        listing = await Listing.db.updateRow(
          session,
          listing.copyWith(
            currentPlaceId: currentPlaceId,
            postTitle: title,
            yearsInPost: yearsInPost,
            status: ListingStatus.active,
            updatedAt: now,
          ),
          transaction: tx,
        );
        await Wish.db.deleteWhere(
          session,
          where: (t) => t.listingId.equals(listing!.id!),
          transaction: tx,
        );
        // A changed request deserves a fresh look at previously declined moves.
        await DeclinedEdge.db.deleteWhere(
          session,
          where: (t) => t.fromListingId.equals(listing!.id!),
          transaction: tx,
        );
      }
      await Wish.db.insert(
        session,
        [
          for (var i = 0; i < wishes.length; i++)
            Wish(
              listingId: listing.id!,
              placeId: wishes[i].placeId,
              radiusKm: wishes[i].radiusKm,
              rank: i,
              point: places[wishes[i].placeId]!.point,
            ),
        ],
        transaction: tx,
      );
      return listing;
    });

    final saved = await Wish.db.find(
      session,
      where: (t) => t.listingId.equals(listing.id!),
      orderBy: (t) => t.rank,
    );
    await Bots.completeLoopFor(session, exchange, listing, saved);
    await LoopService.postListingsChanged(session, exchangeId);
    await LoopService.scheduleSolve(session, exchangeId, urgent: true);
    return Views.myListing(session, listing);
  }

  /// Pauses (stop matching) or resumes a listing.
  Future<MyListing> setPaused(
    Session session,
    int listingId,
    bool paused,
  ) => _transition(session, listingId, (status) {
    if (paused && status == ListingStatus.active) return ListingStatus.paused;
    if (!paused && status == ListingStatus.paused) return ListingStatus.active;
    return null;
  });

  Future<MyListing> withdraw(Session session, int listingId) =>
      _transition(session, listingId, (status) {
        if (status == ListingStatus.active || status == ListingStatus.paused) {
          return ListingStatus.withdrawn;
        }
        return null;
      });

  Future<MyListing> _transition(
    Session session,
    int listingId,
    ListingStatus? Function(ListingStatus) next,
  ) async {
    final member = await requireMember(session);
    final listing = await session.db.transaction((tx) async {
      final listing = await Listing.db.findById(
        session,
        listingId,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (listing == null || listing.memberId != member.id) {
        throw LoopException(
          code: LoopErrorCode.notFound,
          message: 'Not found.',
        );
      }
      final to = next(listing.status);
      if (to == null) {
        throw LoopException(
          code: LoopErrorCode.invalidState,
          message:
              'That is not possible while the request is '
              '${listing.status.name}.',
        );
      }
      return Listing.db.updateRow(
        session,
        listing.copyWith(status: to, updatedAt: DateTime.now().toUtc()),
        transaction: tx,
      );
    });
    if (listing.status == ListingStatus.active) {
      final exchange = await Exchange.db.findById(session, listing.exchangeId);
      if (exchange != null) {
        final wishes = await Wish.db.find(
          session,
          where: (t) => t.listingId.equals(listing.id!),
          orderBy: (t) => t.rank,
        );
        await Bots.completeLoopFor(session, exchange, listing, wishes);
      }
      await LoopService.scheduleSolve(
        session,
        listing.exchangeId,
        urgent: true,
      );
    }
    await LoopService.postListingsChanged(session, listing.exchangeId);
    return Views.myListing(session, listing);
  }
}

/// Loop proposals: view, answer, and follow live.
class LoopEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<LoopView>> mine(Session session) async {
    final member = await requireMember(session);
    final seats = await LoopSeat.db.find(
      session,
      where: (t) => t.memberId.equals(member.id!),
    );
    if (seats.isEmpty) return [];
    final loops = await SwapLoop.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final s in seats) s.loopId}),
      orderBy: (t) => t.createdAt.desc(),
      limit: 20,
    );
    return [for (final l in loops) await Views.loop(session, l, member.id!)];
  }

  Future<LoopView> get(Session session, int loopId) async {
    final member = await requireMember(session);
    final loop = await _loopFor(session, loopId, member);
    return Views.loop(session, loop, member.id!);
  }

  Future<LoopView> respond(Session session, int loopId, bool accept) async {
    final member = await requireMember(session);
    final loop = await LoopService.respond(
      session,
      loopId: loopId,
      memberId: member.id!,
      accept: accept,
    );
    return Views.loop(session, loop, member.id!);
  }

  /// Live updates for every loop the signed-in member is part of.
  Stream<MemberUpdate> watch(Session session) async* {
    final member = await requireMember(session);
    session.log('Live updates opened for member ${member.id}');
    yield* session.messages
        .createStream<MemberUpdate>(Channels.member(member.id!))
        .map((u) {
          session.log(
            'Pushing loop ${u.loopId} (${u.status.name}) to ${member.id}',
          );
          return u;
        });
  }

  Future<SwapLoop> _loopFor(Session session, int loopId, Member member) async {
    final seat = await LoopSeat.db.findFirstRow(
      session,
      where: (t) => t.loopId.equals(loopId) & t.memberId.equals(member.id!),
    );
    final loop = seat == null
        ? null
        : await SwapLoop.db.findById(session, loopId);
    if (loop == null) {
      throw LoopException(
        code: LoopErrorCode.notFound,
        message: 'Loop not found.',
      );
    }
    return loop;
  }
}
