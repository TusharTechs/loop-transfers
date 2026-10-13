import 'dart:async';

import 'jobs.dart';

/// Keeps simulated markets alive while someone is watching them.
///
/// Every open `exchange.watch` stream counts as a viewer. While an exchange
/// has viewers, simulated colleagues arrive every [pulseEvery] (and the
/// longest-waiting ones give up), so the engine keeps finding new loops and
/// the live map keeps moving. With nobody watching, the markets rest and the
/// server stays idle.
abstract final class Simulation {
  static const pulseEvery = Duration(seconds: 30);
  static final _viewers = <int, int>{};
  static Timer? _ticker;

  static bool watched(int exchangeId) => (_viewers[exchangeId] ?? 0) > 0;

  static void join(int exchangeId) {
    final first = !watched(exchangeId);
    _viewers[exchangeId] = (_viewers[exchangeId] ?? 0) + 1;
    if (first) Jobs.pulse(exchangeId, const Duration(seconds: 2));
    _ticker ??= Timer.periodic(pulseEvery, (_) {
      if (_viewers.isEmpty) {
        _ticker?.cancel();
        _ticker = null;
        return;
      }
      for (final id in _viewers.keys) {
        Jobs.pulse(id, Duration.zero);
      }
    });
  }

  static void leave(int exchangeId) {
    final left = (_viewers[exchangeId] ?? 1) - 1;
    if (left <= 0) {
      _viewers.remove(exchangeId);
    } else {
      _viewers[exchangeId] = left;
    }
  }
}
