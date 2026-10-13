import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../../engine/loop_engine.dart';
import '../../generated/protocol.dart';

/// Loop Lab: builds a synthetic cadre and solves it with the real engine, so
/// anyone can see how many more people loops move than pairs, and why
/// flexibility matters. Public and stateless; inputs are clamped.
class LabEndpoint extends Endpoint {
  static const engine = LoopEngine();

  Future<LabResult> run(
    Session session, {
    required int members,
    required int choices,
    required int maxLoopSize,
    required int seed,
  }) async {
    final n = members.clamp(20, 5000);
    final k = choices.clamp(1, 5);
    final maxLen = maxLoopSize.clamp(2, 4);
    const districts = 36; // e.g. Maharashtra

    // Districts differ in size; people are posted more often to small ones
    // and want to move towards bigger ones (a gravity model).
    final rng = Random(seed);
    final weight = [for (var d = 0; d < districts; d++) 1 / pow(d + 1, 0.8)];
    int pick(bool towardsBig) {
      final w = [for (final x in weight) towardsBig ? x : 1 / (x + 0.35)];
      var r = rng.nextDouble() * w.reduce((a, b) => a + b);
      for (var d = 0; d < districts; d++) {
        r -= w[d];
        if (r <= 0) return d;
      }
      return districts - 1;
    }

    final at = [for (var i = 0; i < n; i++) pick(false)];
    final wants = [
      for (var i = 0; i < n; i++)
        {
          for (var j = 0; j < k * 3 && j < 40; j++) pick(true),
        }.where((d) => d != at[i]).take(k).toList(),
    ];

    // Edge i → j when j is posted where i wants to go.
    final byDistrict = <int, List<int>>{};
    for (var i = 0; i < n; i++) {
      (byDistrict[at[i]] ??= []).add(i);
    }
    final edges = <SwapEdge>[
      for (var i = 0; i < n; i++)
        for (var r = 0; r < wants[i].length; r++)
          for (final j in byDistrict[wants[i][r]] ?? const <int>[])
            SwapEdge(from: i, to: j, wishRank: r),
    ];

    final watch = Stopwatch()..start();
    final result = engine.solve(edges, maxLoopSize: maxLen);
    watch.stop();
    int count(int size) => result.loops.where((l) => l.size == size).length;
    return LabResult(
      members: n,
      districts: districts,
      choices: k,
      maxLoopSize: maxLen,
      pairwisePeople: result.pairwisePeople,
      loopPeople: result.people,
      loops2: count(2),
      loops3: count(3),
      loops4: count(4),
      candidateLoops: result.candidateCount,
      elapsedMicros: watch.elapsedMicroseconds,
    );
  }
}
