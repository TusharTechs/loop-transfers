import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the Loop Lab', (sessionBuilder, endpoints) {
    test('then loops never move fewer people than pairs', () async {
      for (final members in [100, 400, 1500]) {
        for (final choices in [1, 2, 3]) {
          final r = await endpoints.lab.run(
            sessionBuilder,
            members: members,
            choices: choices,
            maxLoopSize: 4,
            seed: 7,
          );
          // ignore: avoid_print
          print(
            'members=$members choices=$choices pairs=${r.pairwisePeople} '
            'loops=${r.loopPeople} (2:${r.loops2} 3:${r.loops3} '
            '4:${r.loops4}) ${r.elapsedMicros}µs',
          );
          expect(r.loopPeople, greaterThanOrEqualTo(r.pairwisePeople));
        }
      }
    });

    test('then inputs are clamped', () async {
      final r = await endpoints.lab.run(
        sessionBuilder,
        members: 1000000,
        choices: 99,
        maxLoopSize: 9,
        seed: 1,
      );
      expect(r.members, 5000);
      expect(r.choices, 5);
      expect(r.maxLoopSize, 4);
    });
  });
}
