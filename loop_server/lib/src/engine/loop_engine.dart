import 'dart:math' as math;

import 'swap_graph.dart';

export 'swap_graph.dart' show SwapEdge;

/// A candidate swap loop: `nodes[i]` takes the posting of `nodes[i + 1]`, and
/// the last node takes the posting of the first.
class CandidateLoop {
  final List<int> nodes;
  final List<SwapEdge> edges;
  final double score;

  CandidateLoop(this.nodes, this.edges, this.score);

  int get size => nodes.length;

  double get averagePreference =>
      edges.fold(0.0, (s, e) => s + e.preference) / edges.length;

  @override
  String toString() => 'Loop(${nodes.join('→')}→${nodes.first}, '
      'score ${score.toStringAsFixed(3)})';
}

class SolveResult {
  /// Vertex-disjoint loops chosen for proposal, best first.
  final List<CandidateLoop> loops;

  /// What a pairwise-only portal would achieve on the same graph.
  final int pairwisePeople;

  final int nodeCount;
  final int edgeCount;
  final int coreSize;
  final int candidateCount;

  /// True when enumeration hit [LoopEngine.maxCandidates].
  final bool truncated;
  final Duration elapsed;

  SolveResult({
    required this.loops,
    required this.pairwisePeople,
    required this.nodeCount,
    required this.edgeCount,
    required this.coreSize,
    required this.candidateCount,
    required this.truncated,
    required this.elapsed,
  });

  int get people => loops.fold(0, (s, l) => s + l.size);
}

/// Finds and packs swap loops.
///
/// Every member in a loop must accept before anything happens, so a loop of
/// size k only succeeds with probability ~p^k. The engine therefore maximises
/// *expected people moved*, which naturally prefers short loops when they
/// cover the same people, while still finding the long loops that pairwise
/// matching can never see.
class LoopEngine {
  /// Assumed probability that a single member accepts a proposal.
  final double acceptProbability;

  /// Upper bound on enumerated candidates, to keep worst cases bounded.
  final int maxCandidates;

  /// Rounds of local improvement after the greedy packing.
  final int improvementRounds;

  const LoopEngine({
    this.acceptProbability = 0.85,
    this.maxCandidates = 200000,
    this.improvementRounds = 3,
  });

  double scoreFor(int size, double averagePreference) =>
      size * math.pow(acceptProbability, size) * (1 + 0.25 * averagePreference);

  /// Finds and packs loops. Loops through any node in [priority] are
  /// strongly preferred (used in simulated markets so the real person
  /// trying Loop is never crowded out by simulated members).
  SolveResult solve(
    Iterable<SwapEdge> edges, {
    int maxLoopSize = 4,
    Set<int> priority = const {},
  }) {
    final watch = Stopwatch()..start();
    final graph = SwapGraph(edges);
    final core = graph.cyclicCore();
    final components = graph.stronglyConnectedComponents(core);

    final candidates = <CandidateLoop>[];
    var truncated = false;
    for (final component in components) {
      if (!_enumerate(graph, component, maxLoopSize, candidates, priority)) {
        truncated = true;
        break;
      }
    }

    final chosen = _pack(candidates);
    final pairwise = _pack([
      for (final c in candidates)
        if (c.size == 2) c,
    ]);

    watch.stop();
    return SolveResult(
      loops: chosen,
      pairwisePeople: pairwise.fold(0, (s, l) => s + l.size),
      nodeCount: graph.nodes.length,
      edgeCount: graph.edgeCount,
      coreSize: core.length,
      candidateCount: candidates.length,
      truncated: truncated,
      elapsed: watch.elapsed,
    );
  }

  /// Enumerates each simple cycle of length 2..[maxLen] in [component]
  /// exactly once: the cycle is reported from its smallest node, and the
  /// search from start s only visits nodes greater than s.
  /// Returns false if the candidate cap was hit.
  bool _enumerate(
    SwapGraph graph,
    List<int> component,
    int maxLen,
    List<CandidateLoop> out,
    Set<int> priority,
  ) {
    final members = component.toSet();
    final path = <int>[];
    final onPath = <int>{};

    bool dfs(int start, int node) {
      path.add(node);
      onPath.add(node);
      final next = graph.successors(node).where(members.contains).toList()
        ..sort();
      for (final m in next) {
        if (m == start && path.length >= 2) {
          out.add(_candidate(graph, List.of(path), priority));
          if (out.length >= maxCandidates) return false;
        } else if (m > start && !onPath.contains(m) && path.length < maxLen) {
          if (!dfs(start, m)) return false;
        }
      }
      path.removeLast();
      onPath.remove(node);
      return true;
    }

    for (final s in component) {
      if (!dfs(s, s)) return false;
    }
    return true;
  }

  CandidateLoop _candidate(SwapGraph graph, List<int> nodes, Set<int> priority) {
    final edges = [
      for (var i = 0; i < nodes.length; i++)
        graph.edge(nodes[i], nodes[(i + 1) % nodes.length])!,
    ];
    final avg = edges.fold(0.0, (s, e) => s + e.preference) / edges.length;
    final boost = 10.0 * nodes.where(priority.contains).length;
    return CandidateLoop(nodes, edges, scoreFor(nodes.length, avg) + boost);
  }

  /// Picks vertex-disjoint loops with high total score: greedy, then local
  /// search that tries dropping one chosen loop and refilling the freed
  /// members with better combinations.
  List<CandidateLoop> _pack(List<CandidateLoop> candidates) {
    if (candidates.isEmpty) return [];
    final sorted = List.of(candidates)
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        if (byScore != 0) return byScore;
        return _lexCompare(a.nodes, b.nodes);
      });

    final byNode = <int, List<int>>{};
    for (var i = 0; i < sorted.length; i++) {
      for (final n in sorted[i].nodes) {
        (byNode[n] ??= []).add(i);
      }
    }

    final used = <int, int>{}; // node -> chosen candidate index
    final chosen = <int>{};

    bool fits(int i) => sorted[i].nodes.every((n) => !used.containsKey(n));
    void take(int i) {
      chosen.add(i);
      for (final n in sorted[i].nodes) {
        used[n] = i;
      }
    }

    void drop(int i) {
      chosen.remove(i);
      for (final n in sorted[i].nodes) {
        used.remove(n);
      }
    }

    for (var i = 0; i < sorted.length; i++) {
      if (fits(i)) take(i);
    }

    for (var round = 0; round < improvementRounds; round++) {
      var improved = false;
      for (final victim in chosen.toList()..sort()) {
        if (!chosen.contains(victim)) continue;
        drop(victim);
        // Candidates touching the freed members, best first.
        final options = [
          for (final i in <int>{
            for (final n in sorted[victim].nodes) ...byNode[n]!,
          })
            if (i != victim && fits(i)) i,
        ]..sort();
        final (refill, gain) = _bestDisjoint(sorted, options);
        if (gain > sorted[victim].score + 1e-9) {
          refill.forEach(take);
          improved = true;
        } else {
          take(victim);
        }
      }
      if (!improved) break;
    }

    return [for (final i in chosen.toList()..sort()) sorted[i]];
  }

  /// Best-scoring set of mutually disjoint candidates among [options]
  /// (indices into [sorted], best first). Exact branch and bound, with a step
  /// budget after which the best set found so far is returned.
  static (List<int>, double) _bestDisjoint(
    List<CandidateLoop> sorted,
    List<int> options, {
    int budget = 20000,
  }) {
    var best = <int>[];
    var bestScore = 0.0;
    var steps = 0;
    final current = <int>[];
    final usedNodes = <int>{};

    // Suffix sums give an optimistic bound for pruning.
    final suffix = List<double>.filled(options.length + 1, 0);
    for (var k = options.length - 1; k >= 0; k--) {
      suffix[k] = suffix[k + 1] + sorted[options[k]].score;
    }

    void search(int k, double score) {
      if (++steps > budget) return;
      if (score > bestScore) {
        bestScore = score;
        best = List.of(current);
      }
      if (k == options.length || score + suffix[k] <= bestScore) return;
      final c = sorted[options[k]];
      if (c.nodes.every((n) => !usedNodes.contains(n))) {
        current.add(options[k]);
        usedNodes.addAll(c.nodes);
        search(k + 1, score + c.score);
        usedNodes.removeAll(c.nodes);
        current.removeLast();
      }
      search(k + 1, score);
    }

    search(0, 0);
    return (best, bestScore);
  }

  static int _lexCompare(List<int> a, List<int> b) {
    for (var i = 0; i < math.min(a.length, b.length); i++) {
      final c = a[i].compareTo(b[i]);
      if (c != 0) return c;
    }
    return a.length.compareTo(b.length);
  }
}
