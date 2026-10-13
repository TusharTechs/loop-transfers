import 'package:loop_server/src/generated/protocol.dart';
import 'package:loop_server/src/loop/services/bots.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a watched simulated market', (sessionBuilder, endpoints) {
    test('then every pulse brings a loop to life', () async {
      final session = sessionBuilder.build();
      final names = ['Pune', 'Nagpur', 'Mumbai', 'Nashik', 'Thane', 'Satara'];
      for (var i = 0; i < names.length; i++) {
        await Place.db.insertRow(
          session,
          Place(
            code: 'S-$i',
            name: names[i],
            state: 'Maharashtra',
            point: GeographyPoint(latitude: 18.0 + i, longitude: 73.0 + i),
            population: 100000 * (i + 1),
          ),
        );
      }
      final exchange = await Exchange.db.insertRow(
        session,
        Exchange(
          slug: 'sim',
          name: 'Simulated',
          cadre: 'Teacher',
          scope: 'Maharashtra',
          state: 'Maharashtra',
          description: 'test',
          isSimulated: true,
        ),
      );
      // A small market that is already stuck: nobody can form a loop.
      await Bots.replenish(session, exchange, max: 4);

      await Bots.pulse(session, exchange.id!);

      final proposed = await SwapLoop.db.count(
        session,
        where: (t) => t.exchangeId.equals(exchange.id!),
      );
      expect(proposed, greaterThanOrEqualTo(1));
    });
  });
}
