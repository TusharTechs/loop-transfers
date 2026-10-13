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
  String toString() =>
      'Loop(${nodes.join('→')}→${nodes.first}, '
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

  /// In dense markets many people are interchangeable (same district, same
  /// wishes), so the search expands only the [branching] most preferred
  /// successors of each node and keeps at most [cyclesPerStart] loops rooted
  /// at each person. Sparse markets stay exhaustive.
  final int branching;
  final int cyclesPerStart;

  /// Upper bound for the local-improvement phase.
  final Duration improvementBudget;

  const LoopEngine({
    this.acceptProbability = 0.85,
    this.maxCandidates = 100000,
    this.improvementRounds = 3,
    this.branching = 16,
    this.cyclesPerStart = 40,
    this.improvementBudget = const Duration(milliseconds: 1500),
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

    // The pairs-only baseline is computed exhaustively (every mutual pair),
    // never from the bounded loop search, so the comparison is honest.
    final pairs = [
      for (final a in core)
        for (final b in graph.successors(a))
          if (a < b && core.contains(b) && graph.edge(b, a) != null)
            _candidate(graph, [a, b], priority),
    ];
    final pairwise = _pack(pairs);

    // Loop starts from the best pairs-only solution and adds loops among the
    // people pairs leave behind, so it never moves fewer people than pairs.
    final seen = {for (final c in candidates) c.nodes.join(',')};
    final chosen = _pack([
      ...candidates,
      for (final p in pairs)
        if (seen.add(p.nodes.join(','))) p,
    ], start: pairwise);

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
    // Successors inside the component, most preferred first.
    final succ = <int, List<int>>{
      for (final n in component)
        n: graph.successors(n).where(members.contains).toList()
          ..sort((a, b) {
            final byPref = graph
                .edge(n, b)!
                .preference
                .compareTo(graph.edge(n, a)!.preference);
            return byPref != 0 ? byPref : a.compareTo(b);
          }),
    };
    final path = <int>[];
    final onPath = <int>{};
    var foundFromStart = 0;

    // Returns false when the global candidate cap is hit.
    bool dfs(int start, int node) {
      path.add(node);
      onPath.add(node);
      try {
        if (path.length >= 2 && graph.edge(node, start) != null) {
          out.add(_candidate(graph, List.of(path), priority));
          foundFromStart++;
          if (out.length >= maxCandidates) return false;
        }
        if (path.length >= maxLen || foundFromStart >= cyclesPerStart) {
          return true;
        }
        var expanded = 0;
        for (final m in succ[node]!) {
          if (m <= start || onPath.contains(m)) continue;
          if (++expanded > branching) break;
          if (!dfs(start, m)) return false;
          if (foundFromStart >= cyclesPerStart) break;
        }
        return true;
      } finally {
        path.removeLast();
        onPath.remove(node);
      }
    }

    for (final s in component) {
      foundFromStart = 0;
      if (!dfs(s, s)) return false;
    }
    return true;
  }

  CandidateLoop _candidate(
    SwapGraph graph,
    List<int> nodes,
    Set<int> priority,
  ) {
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
  List<CandidateLoop> _pack(
    List<CandidateLoop> candidates, {
    List<CandidateLoop> start = const [],
  }) {
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

    final startKeys = {for (final c in start) c.nodes.join(',')};
    for (var i = 0; i < sorted.length; i++) {
      if (startKeys.contains(sorted[i].nodes.join(',')) && fits(i)) take(i);
    }
    for (var i = 0; i < sorted.length; i++) {
      if (fits(i)) take(i);
    }

    final budget = Stopwatch()..start();
    for (var round = 0; round < improvementRounds; round++) {
      var improved = false;
      for (final victim in chosen.toList()..sort()) {
        if (budget.elapsed > improvementBudget) break;
        if (!chosen.contains(victim)) continue;
        drop(victim);
        // Candidates touching the freed members, best first.
        final options = [
          for (final i in <int>{
            for (final n in sorted[victim].nodes) ...byNode[n]!,
          })
            if (i != victim && fits(i)) i,
        ]..sort();
        if (options.length > 60) options.length = 60;
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
