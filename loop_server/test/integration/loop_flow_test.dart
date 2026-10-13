import 'package:loop_server/src/generated/protocol.dart';
import 'package:loop_server/src/loop/services/loop_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// A small market: three teachers whose wishes form a loop that a pairwise
/// portal cannot see (Pune → Nagpur → Mumbai → Pune).
class Fixture {
  final TestSessionBuilder base;
  final TestEndpoints endpoints;
  late Exchange exchange;
  late Map<String, Place> places;

  Fixture(this.base, this.endpoints);

  Session get session => base.build();

  TestSessionBuilder as(String userId) => base.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(userId, {}),
  );

  Future<void> setUp() async {
    final rows = {
      'Pune': (18.52, 73.85),
      'Nagpur': (21.15, 79.09),
      'Mumbai': (19.08, 72.88),
      'Thane': (19.22, 72.98), // ~20 km from Mumbai
      'Nashik': (20.0, 73.79),
    };
    places = {};
    for (final MapEntry(key: name, value: (lat, lon)) in rows.entries) {
      places[name] = await Place.db.insertRow(
        session,
        Place(
          code: 'T-$name',
          name: name,
          state: 'Maharashtra',
          point: GeographyPoint(latitude: lat, longitude: lon),
        ),
      );
    }
    exchange = await Exchange.db.insertRow(
      session,
      Exchange(
        slug: 'test',
        name: 'Test teachers',
        cadre: 'Teacher',
        scope: 'Maharashtra',
        state: 'Maharashtra',
        description: 'test',
        maxLoopSize: 4,
      ),
    );
  }

  /// Creates a member with a listing at [at] wanting [wants].
  Future<MyListing> teacher(
    String userId,
    String name,
    String at,
    List<String> wants, {
    int radiusKm = 0,
  }) async {
    await endpoints.member.saveProfile(
      as(userId),
      name,
      phone: '+91 90000 0000',
    );
    return endpoints.listing.save(
      as(userId),
      exchangeId: exchange.id!,
      currentPlaceId: places[at]!.id!,
      postTitle: 'Teacher, $at',
      yearsInPost: 3,
      wishes: [
        for (final w in wants)
          WishInput(placeId: places[w]!.id!, radiusKm: radiusKm),
      ],
    );
  }

  Future<SolverRun?> solve() =>
      LoopService.solveExchange(session, exchange.id!, trigger: 'test');
}

const asha = '0199d000-0000-7000-8000-000000000001';
const bala = '0199d000-0000-7000-8000-000000000002';
const chitra = '0199d000-0000-7000-8000-000000000003';
const dev = '0199d000-0000-7000-8000-000000000004';

void main() {
  withServerpod('Given a three-way loop that pairwise matching misses', (
    sessionBuilder,
    endpoints,
  ) {
    late Fixture f;

    setUp(() async {
      f = Fixture(sessionBuilder, endpoints);
      await f.setUp();
      await f.teacher(asha, 'Asha', 'Pune', ['Nagpur']);
      await f.teacher(bala, 'Bala', 'Nagpur', ['Mumbai']);
      await f.teacher(chitra, 'Chitra', 'Mumbai', ['Pune']);
    });

    test(
      'when solved then one loop of three is proposed and pairwise finds 0',
      () async {
        final run = await f.solve();
        expect(run!.loopsProposed, 1);
        expect(run.peopleInLoops, 3);
        expect(run.pairwisePeople, 0);

        final loops = await endpoints.loop.mine(f.as(asha));
        expect(loops.single.status, LoopStatus.proposed);
        expect(loops.single.size, 3);

        final listings = await endpoints.listing.mine(f.as(bala));
        expect(listings.single.listing.status, ListingStatus.reserved);
        expect(listings.single.activeLoopId, loops.single.id);
      },
    );

    test('when a loop is proposed then members are told live', () async {
      final updates = endpoints.loop.watch(f.as(asha));
      final first = updates.first;
      // Give the stream a moment to subscribe before the engine runs.
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await f.solve();
      final update = await first.timeout(const Duration(seconds: 5));
      expect(update.status, LoopStatus.proposed);
    });

    test('when proposed then partners stay anonymous', () async {
      await f.solve();
      final view = (await endpoints.loop.mine(f.as(asha))).single;
      final me = view.seats.singleWhere((s) => s.isMe);
      final others = view.seats.where((s) => !s.isMe);
      expect(me.name, 'Asha');
      expect(others.map((s) => s.name), everyElement(isNull));
      expect(others.map((s) => s.phone), everyElement(isNull));
      expect(view.publicCode, isNull);
      // Asha moves to Nagpur, the posting of the next seat.
      expect(me.toPlace.name, 'Nagpur');
    });

    test(
      'when everyone accepts then the loop is confirmed and revealed',
      () async {
        await f.solve();
        final loopId = (await endpoints.loop.mine(f.as(asha))).single.id;
        await endpoints.loop.respond(f.as(asha), loopId, true);
        await endpoints.loop.respond(f.as(bala), loopId, true);
        final view = await endpoints.loop.respond(f.as(chitra), loopId, true);

        expect(view.status, LoopStatus.confirmed);
        expect(view.publicCode, isNotNull);
        expect(
          view.seats.map((s) => s.name),
          containsAll(['Asha', 'Bala', 'Chitra']),
        );
        final mine = await endpoints.listing.mine(f.as(asha));
        expect(mine.single.listing.status, ListingStatus.matched);

        final summary = (await endpoints.exchange.list(
          f.base,
        )).singleWhere((s) => s.exchange.id == f.exchange.id);
        expect(summary.confirmedLoops, 1);
        expect(summary.peopleMatched, 3);
        expect(summary.lastRun!.peopleInLoops, 3);

        final snapshot = await endpoints.exchange.snapshot(
          f.base,
          f.exchange.id!,
        );
        expect(snapshot.loops.single.status, LoopStatus.confirmed);
        expect(snapshot.loops.single.placeIds, hasLength(3));
        // Matched members have left the live market.
        expect(snapshot.flows, isEmpty);
        expect(snapshot.activeListings, 0);
      },
    );

    test('when answering twice the same way then it is idempotent', () async {
      await f.solve();
      final loopId = (await endpoints.loop.mine(f.as(asha))).single.id;
      await endpoints.loop.respond(f.as(asha), loopId, true);
      final again = await endpoints.loop.respond(f.as(asha), loopId, true);
      expect(again.status, LoopStatus.proposed);
    });

    test('when someone declines then everyone is released and the move is '
        'never proposed again', () async {
      await f.solve();
      final loopId = (await endpoints.loop.mine(f.as(asha))).single.id;
      await endpoints.loop.respond(f.as(asha), loopId, true);
      final view = await endpoints.loop.respond(f.as(bala), loopId, false);
      expect(view.status, LoopStatus.declined);

      for (final user in [asha, bala, chitra]) {
        final l = await endpoints.listing.mine(f.as(user));
        expect(l.single.listing.status, ListingStatus.active);
      }
      final rerun = await f.solve();
      expect(rerun!.loopsProposed, 0, reason: 'Bala declined Nagpur→Mumbai');

      expect(
        () => endpoints.loop.respond(f.as(chitra), loopId, true),
        throwsA(
          isA<LoopException>().having(
            (e) => e.code,
            'code',
            LoopErrorCode.invalidState,
          ),
        ),
      );
    });

    test('when the deadline passes then silent members are paused', () async {
      await f.solve();
      final loopId = (await endpoints.loop.mine(f.as(asha))).single.id;
      await endpoints.loop.respond(f.as(asha), loopId, true);
      final loop = await SwapLoop.db.findById(f.session, loopId);
      await SwapLoop.db.updateRow(
        f.session,
        loop!.copyWith(
          deadline: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
        ),
      );

      await LoopService.expire(f.session, loopId);

      final view = await endpoints.loop.get(f.as(asha), loopId);
      expect(view.status, LoopStatus.expired);
      expect(
        (await endpoints.listing.mine(f.as(asha))).single.listing.status,
        ListingStatus.active,
      );
      expect(
        (await endpoints.listing.mine(f.as(bala))).single.listing.status,
        ListingStatus.paused,
      );
    });

    test('when a stranger answers then it is refused', () async {
      await f.solve();
      final loopId = (await endpoints.loop.mine(f.as(asha))).single.id;
      await endpoints.member.saveProfile(f.as(dev), 'Dev', email: 'd@x.in');
      expect(
        () => endpoints.loop.respond(f.as(dev), loopId, true),
        throwsA(
          isA<LoopException>().having(
            (e) => e.code,
            'code',
            LoopErrorCode.notAllowed,
          ),
        ),
      );
    });

    test('when solved twice then no listing is in two loops', () async {
      await f.solve();
      final second = await f.solve();
      expect(second!.loopsProposed, 0);
      expect(await SwapLoop.db.count(f.session), 1);
    });

    test('when editing a reserved listing then it is refused', () async {
      await f.solve();
      expect(
        () => f.teacher(asha, 'Asha', 'Pune', ['Nashik']),
        throwsA(
          isA<LoopException>().having(
            (e) => e.code,
            'code',
            LoopErrorCode.invalidState,
          ),
        ),
      );
    });
  });

  withServerpod('Given radius wishes', (sessionBuilder, endpoints) {
    test('then "within 40 km of Mumbai" matches a posting in Thane', () async {
      final f = Fixture(sessionBuilder, endpoints);
      await f.setUp();
      await f.teacher(asha, 'Asha', 'Pune', ['Mumbai'], radiusKm: 40);
      await f.teacher(bala, 'Bala', 'Thane', ['Pune']);

      final run = await f.solve();
      expect(run!.loopsProposed, 1);
      expect(run.pairwisePeople, 2);

      final seat = (await endpoints.loop.mine(
        f.as(asha),
      )).single.seats.singleWhere((s) => s.isMe);
      expect(seat.toPlace.name, 'Thane');
      expect(seat.km, closeTo(20, 8));
    });

    test('then "within 40 km of Mumbai" does not match Nashik', () async {
      final f = Fixture(sessionBuilder, endpoints);
      await f.setUp();
      await f.teacher(asha, 'Asha', 'Pune', ['Mumbai'], radiusKm: 40);
      await f.teacher(bala, 'Bala', 'Nashik', ['Pune']);
      expect((await f.solve())!.loopsProposed, 0);
    });
  });

  withServerpod('Given input validation', (sessionBuilder, endpoints) {
    test('then a listing without a profile is refused', () async {
      final f = Fixture(sessionBuilder, endpoints);
      await f.setUp();
      expect(
        () => endpoints.listing.save(
          f.as(asha),
          exchangeId: f.exchange.id!,
          currentPlaceId: f.places['Pune']!.id!,
          postTitle: 'Teacher',
          yearsInPost: 2,
          wishes: [WishInput(placeId: f.places['Nagpur']!.id!)],
        ),
        throwsA(
          isA<LoopException>().having(
            (e) => e.code,
            'code',
            LoopErrorCode.profileRequired,
          ),
        ),
      );
    });

    test('then wishing for your own district is refused', () async {
      final f = Fixture(sessionBuilder, endpoints);
      await f.setUp();
      expect(
        () => f.teacher(asha, 'Asha', 'Pune', ['Pune']),
        throwsA(
          isA<LoopException>().having(
            (e) => e.code,
            'code',
            LoopErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('then a profile needs a way to be contacted', () async {
      final f = Fixture(sessionBuilder, endpoints);
      expect(
        () => endpoints.member.saveProfile(f.as(asha), 'Asha'),
        throwsA(isA<LoopException>()),
      );
    });
  });
}
