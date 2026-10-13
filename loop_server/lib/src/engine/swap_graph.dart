import 'dart:math' as math;

/// A directed "would accept" edge: the member behind listing [from] would
/// accept the posting currently held by the member behind listing [to].
class SwapEdge {
  final int from;
  final int to;

  /// 0-based rank of the wish this edge satisfies (0 = first choice).
  final int wishRank;

  /// Distance in km from the wish's centre to the posting.
  final double km;

  const SwapEdge({
    required this.from,
    required this.to,
    this.wishRank = 0,
    this.km = 0,
  });

  /// How happy [from] is with this move, in (0, 1].
  double get preference {
    final rankScore = 1 / (wishRank + 1);
    final distanceScore = 1 / (1 + km / 50);
    return 0.6 * rankScore + 0.4 * distanceScore;
  }

  @override
  String toString() => '$from→$to';
}

/// Directed graph of listings, deduplicated so that each ordered pair keeps
/// its most preferred edge.
class SwapGraph {
  final Map<int, Map<int, SwapEdge>> _out = {};
  final Map<int, Set<int>> _in = {};

  SwapGraph(Iterable<SwapEdge> edges) {
    for (final e in edges) {
      if (e.from == e.to) continue;
      final existing = _out[e.from]?[e.to];
      if (existing == null || e.preference > existing.preference) {
        (_out[e.from] ??= {})[e.to] = e;
      }
      (_in[e.to] ??= {}).add(e.from);
    }
  }

  Iterable<int> get nodes => {..._out.keys, ..._in.keys};

  int get edgeCount => _out.values.fold(0, (sum, m) => sum + m.length);

  SwapEdge? edge(int from, int to) => _out[from]?[to];

  Iterable<int> successors(int node) => _out[node]?.keys ?? const [];

  /// Removes, repeatedly, every node with no incoming or no outgoing edges.
  /// Such nodes can never be part of a cycle. Returns the surviving nodes.
  Set<int> cyclicCore() {
    final alive = nodes.toSet();
    final outDeg = <int, int>{};
    final inDeg = <int, int>{};
    for (final n in alive) {
      outDeg[n] = _out[n]?.length ?? 0;
      inDeg[n] = _in[n]?.length ?? 0;
    }
    final queue = [
      for (final n in alive)
        if (outDeg[n] == 0 || inDeg[n] == 0) n,
    ];
    while (queue.isNotEmpty) {
      final n = queue.removeLast();
      if (!alive.remove(n)) continue;
      for (final m in _out[n]?.keys ?? const <int>[]) {
        if (!alive.contains(m)) continue;
        inDeg[m] = inDeg[m]! - 1;
        if (inDeg[m] == 0) queue.add(m);
      }
      for (final m in _in[n] ?? const <int>{}) {
        if (!alive.contains(m)) continue;
        outDeg[m] = outDeg[m]! - 1;
        if (outDeg[m] == 0) queue.add(m);
      }
    }
    return alive;
  }

  /// Strongly connected components restricted to [within] (Tarjan,
  /// iterative so deep graphs cannot overflow the stack). Singletons are
  /// dropped since a self-loop is not a swap.
  List<List<int>> stronglyConnectedComponents(Set<int> within) {
    var index = 0;
    final indices = <int, int>{};
    final lowLink = <int, int>{};
    final onStack = <int>{};
    final stack = <int>[];
    final result = <List<int>>[];

    for (final root in within.toList()..sort()) {
      if (indices.containsKey(root)) continue;
      // Each frame: node + iterator over its successors.
      final work = <(int, Iterator<int>)>[];
      void open(int v) {
        indices[v] = index;
        lowLink[v] = index;
        index++;
        stack.add(v);
        onStack.add(v);
        final succ = successors(v).where(within.contains).toList()..sort();
        work.add((v, succ.iterator));
      }

      open(root);
      while (work.isNotEmpty) {
        final (v, it) = work.last;
        if (it.moveNext()) {
          final w = it.current;
          if (!indices.containsKey(w)) {
            open(w);
          } else if (onStack.contains(w)) {
            lowLink[v] = math.min(lowLink[v]!, indices[w]!);
          }
          continue;
        }
        work.removeLast();
        if (work.isNotEmpty) {
          final parent = work.last.$1;
          lowLink[parent] = math.min(lowLink[parent]!, lowLink[v]!);
        }
        if (lowLink[v] == indices[v]) {
          final component = <int>[];
          int w;
          do {
            w = stack.removeLast();
            onStack.remove(w);
            component.add(w);
          } while (w != v);
          if (component.length > 1) result.add(component..sort());
        }
      }
    }
    return result;
  }
}
