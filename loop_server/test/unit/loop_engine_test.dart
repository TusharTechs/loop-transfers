import 'dart:math';

import 'package:loop_server/src/engine/loop_engine.dart';
import 'package:test/test.dart';

List<SwapEdge> edges(List<(int, int)> pairs) => [
  for (final (a, b) in pairs) SwapEdge(from: a, to: b),
];

void main() {
  const engine = LoopEngine();

  group('Given a graph with no cycles', () {
    test('then no loops are proposed', () {
      final result = engine.solve(edges([(1, 2), (2, 3), (3, 4)]));
      expect(result.loops, isEmpty);
      expect(result.coreSize, 0);
    });
  });

  group('Given a classic 3-way loop that pairwise matching cannot see', () {
    // Pune wants Nagpur, Nagpur wants Mumbai, Mumbai wants Pune.
    final result = engine.solve(edges([(1, 2), (2, 3), (3, 1)]));

    test('then one loop of three is found', () {
      expect(result.loops, hasLength(1));
      expect(result.loops.single.nodes, [1, 2, 3]);
    });

    test('then the pairwise baseline matches nobody', () {
      expect(result.pairwisePeople, 0);
      expect(result.people, 3);
    });
  });

  group('Given two disjoint pairs and a 4-cycle over the same people', () {
    final result = engine.solve(
      edges([
        (1, 2), (2, 1), (3, 4), (4, 3), // two pairs
        (1, 3), (3, 2), (2, 4), (4, 1), // one 4-cycle
      ]),
    );

    test('then the two robust pairs are preferred', () {
      expect(result.loops.map((l) => l.size), [2, 2]);
      expect(result.people, 4);
    });
  });

  group('Given a loop longer than the maximum size', () {
    test('then it is not proposed', () {
      final ring = [for (var i = 1; i <= 5; i++) (i, i % 5 + 1)];
      expect(engine.solve(edges(ring), maxLoopSize: 4).loops, isEmpty);
      expect(engine.solve(edges(ring), maxLoopSize: 5).loops, hasLength(1));
    });
  });

  group('Given a greedy trap where one big loop blocks two smaller ones', () {
    // 3-cycle A (1,2,3) shares node 2 with 3-cycle B (2,4,5) and node 3 with
    // 3-cycle C (3,6,7). The local search should prefer B + C (6 people).
    final result = engine.solve([
      SwapEdge(from: 1, to: 2),
      SwapEdge(from: 2, to: 3),
      SwapEdge(from: 3, to: 1),
      SwapEdge(from: 2, to: 4, wishRank: 2, km: 90),
      SwapEdge(from: 4, to: 5, wishRank: 2, km: 90),
      SwapEdge(from: 5, to: 2, wishRank: 2, km: 90),
      SwapEdge(from: 3, to: 6, wishRank: 2, km: 90),
      SwapEdge(from: 6, to: 7, wishRank: 2, km: 90),
      SwapEdge(from: 7, to: 3, wishRank: 2, km: 90),
    ]);

    test('then more people are served than with greedy alone', () {
      expect(result.people, 6);
    });
  });

  group('Given a priority member competing with simulated ones', () {
    test('then the loop through the priority member wins', () {
      // Two equally good pairs compete for member 2; 9 is a real person.
      final list = edges([(1, 2), (2, 1), (2, 9), (9, 2)]);
      expect(engine.solve(list).loops.single.nodes, [1, 2]);
      final result = engine.solve(list, priority: {9});
      expect(result.loops.single.nodes, [2, 9]);
    });
  });

  group('Given duplicate edges from several wishes', () {
    test('then the most preferred edge is kept', () {
      final result = engine.solve([
        SwapEdge(from: 1, to: 2, wishRank: 3, km: 40),
        SwapEdge(from: 1, to: 2, wishRank: 0, km: 0),
        SwapEdge(from: 2, to: 1),
      ]);
      expect(result.loops.single.edges.first.wishRank, 0);
    });
  });

  group('Given random markets', () {
    test('then chosen loops are valid, disjoint, and beat pairwise', () {
      final rng = Random(42);
      for (var trial = 0; trial < 30; trial++) {
        final n = 20 + rng.nextInt(60);
        final pairs = <(int, int)>{};
        for (var i = 0; i < n * 2; i++) {
          final a = rng.nextInt(n), b = rng.nextInt(n);
          if (a != b) pairs.add((a, b));
        }
        final edgeSet = pairs.toSet();
        final result = engine.solve(edges(pairs.toList()));

        final seen = <int>{};
        for (final loop in result.loops) {
          expect(loop.size, inInclusiveRange(2, 4));
          for (var i = 0; i < loop.size; i++) {
            final from = loop.nodes[i];
            final to = loop.nodes[(i + 1) % loop.size];
            expect(
              edgeSet.contains((from, to)),
              isTrue,
              reason: '$loop uses a missing edge $from→$to',
            );
            expect(seen.add(from), isTrue, reason: '$from is in two loops');
          }
        }
        expect(result.people, greaterThanOrEqualTo(result.pairwisePeople));
      }
    });

    test('then a large market solves quickly', () {
      final rng = Random(7);
      const n = 5000;
      final list = <SwapEdge>[];
      for (var i = 0; i < n; i++) {
        for (var k = 0; k < 3; k++) {
          final j = rng.nextInt(n);
          if (j != i) list.add(SwapEdge(from: i, to: j, wishRank: k));
        }
      }
      final result = engine.solve(list);
      expect(result.elapsed, lessThan(const Duration(seconds: 10)));
      expect(result.loops, isNotEmpty);
    });
  });
}
