import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/india_map.dart';

/// The live, anonymised market of one exchange: who wants to go where, and
/// loops lighting up as the engine finds them and people accept.
class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _Lit {
  LoopTrace trace;
  DateTime at;
  _Lit(this.trace, this.at);
}

class _MarketScreenState extends State<MarketScreen> with SingleTickerProviderStateMixin {
  static const _glowFor = Duration(milliseconds: 4500);

  IndiaGeo? _geo;
  List<ExchangeSummary> _exchanges = [];
  int? _selected;
  MarketSnapshot? _snapshot;
  Object? _error;
  final _lit = <int, _Lit>{};
  final _ticker = <(DateTime, String, Color?)>[];
  StreamSubscription<MarketEvent>? _sub;
  Timer? _refreshSoon;
  Timer? _retry;
  bool _live = false;
  late final Ticker _frames;

  @override
  void initState() {
    super.initState();
    _frames = createTicker((_) {
      final now = DateTime.now();
      if (_lit.values.any((l) => now.difference(l.at) < _glowFor)) setState(() {});
    })
      ..start();
    _init();
  }

  @override
  void dispose() {
    _frames.dispose();
    _sub?.cancel();
    _refreshSoon?.cancel();
    _retry?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      final results = await Future.wait([IndiaGeo.load(), client.exchange.list()]);
      _geo = results[0] as IndiaGeo;
      _exchanges = results[1] as List<ExchangeSummary>;
      final preferred = _exchanges
          .where((e) => !e.exchange.isSandbox)
          .fold<ExchangeSummary?>(null, (best, e) =>
              best == null || e.activeListings > best.activeListings ? e : best);
      await _select((preferred ?? _exchanges.first).exchange.id!);
    } catch (e) {
      setState(() => _error = e);
    }
  }

  Future<void> _select(int id) async {
    _sub?.cancel();
    _retry?.cancel();
    setState(() {
      _selected = id;
      _snapshot = null;
      _lit.clear();
      _ticker.clear();
    });
    await _loadSnapshot();
    _watch(id);
  }

  Future<void> _loadSnapshot() async {
    final id = _selected;
    if (id == null) return;
    try {
      final snap = await client.exchange.snapshot(id);
      if (mounted && id == _selected) setState(() => _snapshot = snap);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _watch(int id) {
    _sub = client.exchange.watch(id).listen(
      (event) {
        _live = true;
        _onEvent(event);
      },
      onError: (_) => _reconnect(id),
      onDone: () => _reconnect(id),
      cancelOnError: true,
    );
    setState(() => _live = true);
  }

  void _reconnect(int id) {
    if (!mounted || id != _selected) return;
    setState(() => _live = false);
    _retry = Timer(const Duration(seconds: 3), () {
      if (mounted && id == _selected) {
        _loadSnapshot();
        _watch(id);
      }
    });
  }

  void _onEvent(MarketEvent e) {
    final c = context.colors;
    String route(LoopTrace t) {
      final names = {for (final p in _snapshot?.places ?? <MarketPlace>[]) p.id: p.name};
      final ns = [for (final id in t.placeIds) names[id]];
      if (ns.any((n) => n == null)) return '${t.placeIds.length}-way loop';
      return '${ns.join(' → ')} → ${ns.first}';
    }

    setState(() {
      switch (e.kind) {
        case MarketEventKind.loopProposed:
          _lit[e.loop!.loopId] = _Lit(e.loop!, DateTime.now());
          _log('Loop found: ${route(e.loop!)}', c.loop);
        case MarketEventKind.loopConfirmed:
          _lit[e.loop!.loopId] = _Lit(e.loop!, DateTime.now());
          _log('Everyone said yes: ${route(e.loop!)}', c.accepted);
        case MarketEventKind.loopDissolved:
          _lit[e.loop!.loopId] = _Lit(e.loop!, DateTime.now());
          _log('Loop dissolved, back to the market', c.muted);
        case MarketEventKind.solverRan:
          final r = e.run!;
          if (r.loopsProposed > 0) {
            _log('Engine run: ${r.candidateCount} candidate loops, '
                '${r.loopsProposed} proposed in ${r.elapsedMs} ms', null);
          }
        case MarketEventKind.listingsChanged:
          break;
      }
    });
    _refreshSoon?.cancel();
    _refreshSoon = Timer(const Duration(milliseconds: 1200), _loadSnapshot);
  }

  void _log(String text, Color? color) {
    _ticker.insert(0, (DateTime.now(), text, color));
    if (_ticker.length > 9) _ticker.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && _snapshot == null) {
      return Center(child: Text(describeError(_error!)));
    }
    if (_geo == null || _selected == null) return const Loading(label: 'Loading the market…');
    final wide = MediaQuery.sizeOf(context).width >= 1000;
    final map = _buildMap(context);
    final side = _buildSide(context);
    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Padding(padding: const EdgeInsets.all(16), child: map)),
          SizedBox(
            width: 380,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(8, 28, 28, 28),
              child: side,
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(aspectRatio: 0.95, child: map),
          Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 32), child: side),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    final snap = _snapshot;
    final exchange = _exchanges.firstWhere((e) => e.exchange.id == _selected).exchange;
    final now = DateTime.now();
    final points = {
      for (final p in snap?.places ?? <MarketPlace>[])
        p.id: MapPoint(p.id, p.name, p.latitude, p.longitude, p.postedHere),
    };
    final loops = <MapLoop>[];
    final hot = <int>{};
    final seen = <int>{};
    for (final lit in _lit.values) {
      final glow = 1 - now.difference(lit.at).inMilliseconds / _glowFor.inMilliseconds;
      seen.add(lit.trace.loopId);
      if (glow > 0) hot.addAll(lit.trace.placeIds);
      loops.add(MapLoop(
        lit.trace.placeIds,
        confirmed: lit.trace.status == LoopStatus.confirmed,
        dissolved: lit.trace.status == LoopStatus.declined || lit.trace.status == LoopStatus.expired,
        glow: math.max(0, glow),
      ));
    }
    for (final t in snap?.loops.take(12) ?? <LoopTrace>[]) {
      if (seen.contains(t.loopId) || t.status == LoopStatus.declined || t.status == LoopStatus.expired) {
        continue;
      }
      loops.add(MapLoop(t.placeIds, confirmed: t.status == LoopStatus.confirmed));
    }
    return Stack(
      children: [
        Positioned.fill(
          child: IndiaMap(
            geo: _geo!,
            points: points,
            flows: [
              for (final f in snap?.flows ?? <MarketFlow>[])
                MapFlow(f.fromPlaceId, f.toPlaceId, f.count),
            ],
            loops: loops,
            focusState: exchange.state,
            highlight: hot,
          ),
        ),
        Positioned(
          left: 16,
          bottom: 12,
          child: _Legend(),
        ),
        if (snap == null) const Center(child: Loading()),
      ],
    );
  }

  Widget _buildSide(BuildContext context) {
    final c = context.colors;
    final snap = _snapshot;
    final summary = _exchanges.firstWhere((e) => e.exchange.id == _selected);
    final loopPeople = snap?.loopPeopleTotal ?? 0;
    final pairPeople = snap?.pairPeopleTotal ?? 0;
    final factor = pairPeople == 0 ? null : loopPeople / pairPeople;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Eyebrow('Live market'),
          const Spacer(),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: _live ? c.accepted : c.muted, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(_live ? 'LIVE' : 'RECONNECTING', style: context.text.labelSmall),
        ]),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          initialValue: _selected,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Exchange'),
          items: [
            for (final e in _exchanges)
              DropdownMenuItem(value: e.exchange.id, child: Text(e.exchange.name, overflow: TextOverflow.ellipsis)),
          ],
          onChanged: (id) {
            if (id != null) _select(id);
          },
        ),
        if (summary.exchange.isSimulated) ...[
          const SizedBox(height: 8),
          Text(
            'Demo market: members are simulated so you can watch the engine work. '
            'Real exchanges look exactly the same.',
            style: context.text.bodySmall,
          ),
        ],
        const SizedBox(height: 22),
        Wrap(
          spacing: 28,
          runSpacing: 16,
          children: [
            Stat('${snap?.activeListings ?? '–'}', 'searching now'),
            Stat('${snap?.peopleMatched ?? '–'}', 'people matched', color: c.accepted),
            Stat('${snap?.confirmedLoops ?? '–'}', 'loops confirmed'),
          ],
        ),
        const SizedBox(height: 26),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Loops vs pairs', style: context.text.titleMedium),
              const SizedBox(height: 4),
              Text(
                'Across ${snap?.runs ?? 0} engine runs on this market, people placed '
                'in proposed loops vs. what a pairwise-only portal finds on the '
                'same requests.',
                style: context.text.bodySmall,
              ),
              const SizedBox(height: 16),
              _Bar(label: 'Loop', value: loopPeople, max: math.max(loopPeople, pairPeople), color: c.loop),
              const SizedBox(height: 10),
              _Bar(label: 'Pairs only', value: pairPeople, max: math.max(loopPeople, pairPeople), color: c.inkSoft),
              if (factor != null && factor > 1) ...[
                const SizedBox(height: 14),
                Text(
                  '${factor.toStringAsFixed(1)}× more people moved',
                  style: context.text.headlineSmall!.copyWith(color: c.loop),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Eyebrow('As it happens'),
        const SizedBox(height: 10),
        if (_ticker.isEmpty)
          Text('Waiting for the engine… new loops appear here live.', style: context.text.bodySmall),
        for (final (at, text, color) in _ticker)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(color: color ?? c.muted, shape: BoxShape.circle),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(text, style: context.text.bodyMedium)),
                Text(
                  '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}:${at.second.toString().padLeft(2, '0')}',
                  style: mono(context, size: 11, color: c.muted),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;
  const _Bar({required this.label, required this.value, required this.max, required this.color});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(width: 78, child: Text(label, style: context.text.labelMedium)),
          Expanded(
            child: LayoutBuilder(
              builder: (context, box) => Stack(
                children: [
                  Container(height: 14, decoration: BoxDecoration(color: context.colors.line, borderRadius: BorderRadius.circular(7))),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    height: 14,
                    width: max == 0 ? 0 : box.maxWidth * value / max,
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 52,
            child: Text('$value', textAlign: TextAlign.right, style: mono(context, size: 14)),
          ),
        ],
      );
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget item(Color color, String text, {bool line = true}) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            line
                ? Container(width: 16, height: 3, color: color)
                : Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(text, style: context.text.labelSmall!.copyWith(letterSpacing: 0.2)),
          ],
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: c.paper.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.line),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 4,
        children: [
          item(c.ink, 'people posted', line: false),
          item(c.inkSoft.withValues(alpha: 0.4), 'wants to move'),
          item(c.loop, 'loop proposed'),
          item(c.accepted, 'loop confirmed'),
        ],
      ),
    );
  }
}
