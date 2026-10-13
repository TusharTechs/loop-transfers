// Benchmarks the loop engine on random markets: dart run tool/bench.dart
// ignore_for_file: avoid_print
import 'dart:math';

import 'package:loop_server/src/engine/loop_engine.dart';

void main() {
  const engine = LoopEngine();
  for (final n in [500, 2000, 5000, 20000]) {
    final rng = Random(n);
    final edges = <SwapEdge>[];
    for (var i = 0; i < n; i++) {
      for (var k = 0; k < 3; k++) {
        final j = rng.nextInt(n);
        if (j != i) edges.add(SwapEdge(from: i, to: j, wishRank: k));
      }
    }
    final r = engine.solve(edges);
    print(
      '$n people, ${edges.length} edges: ${r.elapsed.inMilliseconds} ms, '
      '${r.candidateCount} candidate loops, ${r.people} placed in loops '
      'vs ${r.pairwisePeople} with pairs only',
    );
  }
}
