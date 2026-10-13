import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../theme.dart';
import 'common.dart';

/// Loop Lab: drag the sliders and the server builds a synthetic cadre and
/// solves it with the real engine — pairs only vs. loops.
class LoopLab extends StatefulWidget {
  const LoopLab({super.key});

  @override
  State<LoopLab> createState() => _LoopLabState();
}

class _LoopLabState extends State<LoopLab> {
  static const _sizes = [50, 100, 200, 400, 800, 1500, 3000];
  int _sizeIndex = 2;
  int _choices = 1;
  int _maxLoop = 4;
  int _seed = 7;
  LabResult? _result;
  bool _busy = false;
  Object? _error;
  Timer? _debounce;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _run();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _schedule() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), _run);
  }

  Future<void> _run() async {
    final request = ++_request;
    setState(() => _busy = true);
    try {
      final r = await client.lab.run(
        members: _sizes[_sizeIndex],
        choices: _choices,
        maxLoopSize: _maxLoop,
        seed: _seed,
      );
      if (!mounted || request != _request) return;
      setState(() {
        _result = r;
        _error = null;
      });
    } catch (e) {
      if (mounted && request == _request) setState(() => _error = e);
    } finally {
      if (mounted && request == _request) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = _result;
    final wide = MediaQuery.sizeOf(context).width >= 760;
    final controls = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, 'People in the cadre', '${_sizes[_sizeIndex]}'),
        Slider(
          value: _sizeIndex.toDouble(),
          max: (_sizes.length - 1).toDouble(),
          divisions: _sizes.length - 1,
          onChanged: (v) {
            setState(() => _sizeIndex = v.round());
            _schedule();
          },
        ),
        _label(context, 'Places each person would accept', '$_choices'),
        Slider(
          value: _choices.toDouble(),
          min: 1,
          max: 5,
          divisions: 4,
          onChanged: (v) {
            setState(() => _choices = v.round());
            _schedule();
          },
        ),
        _label(context, 'Longest loop', '$_maxLoop people'),
        const SizedBox(height: 6),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 2, label: Text('2')),
            ButtonSegment(value: 3, label: Text('3')),
            ButtonSegment(value: 4, label: Text('4')),
          ],
          selected: {_maxLoop},
          showSelectedIcon: false,
          onSelectionChanged: (s) {
            setState(() => _maxLoop = s.first);
            _schedule();
          },
        ),
        const SizedBox(height: 14),
        TextButton.icon(
          onPressed: () {
            setState(() => _seed = math.Random().nextInt(1 << 30));
            _run();
          },
          icon: const Icon(Icons.casino_outlined, size: 18),
          label: const Text('Shuffle the cadre'),
        ),
      ],
    );

    final factor = r == null || r.pairwisePeople == 0
        ? null
        : r.loopPeople / r.pairwisePeople;
    final results = AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _busy ? 0.55 : 1,
      child: r == null
          ? (_error != null
                ? Text(describe(_error!), style: context.text.bodyMedium)
                : const Padding(padding: EdgeInsets.all(24), child: Loading()))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ResultBar(
                  label: 'Pairs only',
                  value: r.pairwisePeople,
                  max: math.max(r.loopPeople, r.pairwisePeople),
                  color: c.inkSoft,
                ),
                const SizedBox(height: 12),
                _ResultBar(
                  label: 'Loop',
                  value: r.loopPeople,
                  max: math.max(r.loopPeople, r.pairwisePeople),
                  color: c.loop,
                ),
                const SizedBox(height: 18),
                Text(
                  factor == null
                      ? (r.loopPeople > 0
                            ? '${r.loopPeople} people move — pairs move nobody'
                            : 'Nobody can move yet — add people or flexibility')
                      : factor >= 1.05
                      ? '${factor.toStringAsFixed(1)}× as many people move'
                      : 'Same as pairs — loops add little here',
                  style: context.text.headlineSmall!.copyWith(color: c.loop),
                ),
                const SizedBox(height: 6),
                Text(
                  '${r.loops2} pairs · ${r.loops3} three-way · ${r.loops4} four-way loops'
                  '  ·  solved ${r.members} people in '
                  '${(r.elapsedMicros / 1000).toStringAsFixed(r.elapsedMicros < 10000 ? 1 : 0)} ms on the server',
                  style: context.text.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  _insight(r, factor),
                  style: context.text.bodyMedium!.copyWith(height: 1.5),
                ),
              ],
            ),
    );

    return Panel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Loop Lab'),
          const SizedBox(height: 8),
          Text('Run the engine yourself', style: context.text.headlineMedium),
          const SizedBox(height: 6),
          Text(
            'Each change builds a fresh cadre across 36 districts on the server '
            'and solves it twice: once with pairs only, once with Loop.',
            style: context.text.bodyMedium,
          ),
          const SizedBox(height: 22),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: controls),
                const SizedBox(width: 32),
                Expanded(flex: 6, child: results),
              ],
            )
          else ...[
            controls,
            const SizedBox(height: 20),
            results,
          ],
        ],
      ),
    );
  }

  static String _insight(LabResult r, double? factor) {
    if (r.maxLoopSize == 2) {
      return 'With loops limited to two people, Loop is a pairs portal. '
          'Allow three or four and watch what happens.';
    }
    if (factor == null || factor >= 2) {
      return 'Thin markets of people who need one specific place are exactly '
          'where pairs fail — and where loops shine.';
    }
    if (factor >= 1.2) {
      return 'Loops add ${((factor - 1) * 100).round()}% more moves on top of '
          'every possible pair.';
    }
    return 'When everyone is flexible, pairs are easy to find. Loops still '
        'catch the people pairs leave behind.';
  }

  Widget _label(BuildContext context, String text, String value) => Row(
    children: [
      Expanded(child: Text(text, style: context.text.bodyMedium)),
      Text(value, style: mono(context, size: 15)),
    ],
  );

  static String describe(Object e) => 'Could not reach the engine. Try again.';
}

class _ResultBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;
  const _ResultBar({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 86, child: Text(label, style: context.text.labelLarge)),
      Expanded(
        child: LayoutBuilder(
          builder: (context, box) => Stack(
            children: [
              Container(
                height: 22,
                decoration: BoxDecoration(
                  color: context.colors.line.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeOutCubic,
                height: 22,
                width: max == 0 ? 0 : box.maxWidth * value / max,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 64,
        child: Text(
          '$value',
          textAlign: TextAlign.right,
          style: mono(context, size: 18, weight: FontWeight.w600),
        ),
      ),
    ],
  );
}
