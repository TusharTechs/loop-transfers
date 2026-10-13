import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../generated/future_calls.dart';
import 'bots.dart';
import 'loop_service.dart';

/// All delayed work in Loop goes through here.
///
/// With future calls available, jobs are durable Serverpod future calls.
/// Where they are not (e.g. a Serverpod Cloud Starter plan, or a serverless
/// role), the same jobs run on in-process timers. Correctness never depends
/// on a timer firing: deadlines live in the database and the periodic sweep
/// expires overdue loops and re-solves every exchange, also right after
/// start-up.
abstract final class Jobs {
  static Serverpod? _pod;
  static bool _durable = true;
  static final _timers = <String, Timer>{};
  static var _seq = 0;

  static bool get durable => _durable;

  static void init(Serverpod pod) {
    _pod = pod;
    final config = pod.config;
    final override = Platform.environment['LOOP_SCHEDULER'];
    _durable = switch (override) {
      'durable' => true,
      'timers' => false,
      _ =>
        config.futureCall.enabled &&
            config.futureCallExecutionEnabled &&
            config.role.name == 'monolith',
    };
  }

  static Future<void> solveSoon(int exchangeId, Duration delay) async {
    final id = 'solve-$exchangeId';
    if (_durable) {
      await FutureCalls().cancel(id);
      await FutureCalls()
          .callWithDelay(delay, identifier: id)
          .solve
          .solve(exchangeId);
    } else {
      _timer(
        id,
        delay,
        (s) => LoopService.solveExchange(s, exchangeId, trigger: 'change'),
      );
    }
  }

  static Future<void> loopDeadline(int loopId, DateTime at) async {
    final id = 'loop-deadline-$loopId';
    if (_durable) {
      await FutureCalls()
          .callAtTime(at, identifier: id)
          .loopDeadline
          .expire(loopId);
    } else {
      _timer(
        id,
        at.difference(DateTime.now().toUtc()),
        (s) => LoopService.expire(s, loopId),
      );
    }
  }

  static Future<void> cancelLoopDeadline(int loopId) async {
    final id = 'loop-deadline-$loopId';
    if (_durable) {
      await FutureCalls().cancel(id);
    } else {
      _timers.remove(id)?.cancel();
    }
  }

  static Future<void> botReply(
    int loopId,
    int seatPosition,
    Duration delay,
  ) async {
    if (_durable) {
      await FutureCalls()
          .callWithDelay(delay)
          .bot
          .respond(loopId, seatPosition);
    } else {
      _timer(
        'bot-${_seq++}',
        delay,
        (s) => Bots.respond(s, loopId, seatPosition),
      );
    }
  }

  /// A market pulse (simulated arrivals while someone watches). Always runs
  /// in-process: it only matters while this server has viewers.
  static void pulse(int exchangeId, Duration delay) {
    _timer('pulse-$exchangeId', delay, (s) => Bots.pulse(s, exchangeId));
  }

  /// The recurring sweep. In timer mode it also runs once right away to
  /// recover anything that was due while the server was down.
  static Future<void> startSweep(Duration every) async {
    if (_durable) {
      await FutureCalls().cancel('sweep');
      await FutureCalls()
          .callRecurring(identifier: 'sweep')
          .every(every)
          .sweep
          .sweep();
      return;
    }
    _timer('sweep-now', const Duration(seconds: 5), LoopService.sweep);
    Timer.periodic(
      every,
      (_) => _timer('sweep-${_seq++}', Duration.zero, LoopService.sweep),
    );
  }

  static void _timer(
    String id,
    Duration delay,
    Future<void> Function(Session) work,
  ) {
    final pod = _pod;
    if (pod == null) return;
    _timers.remove(id)?.cancel();
    _timers[id] = Timer(delay.isNegative ? Duration.zero : delay, () {
      _timers.remove(id);
      _enqueue(() async {
        final session = await pod.createSession();
        try {
          await work(session);
        } catch (e, stack) {
          session.log(
            'Job $id failed: $e',
            level: LogLevel.error,
            stackTrace: stack,
          );
        } finally {
          await session.close();
        }
      });
    });
  }

  /// At most [maxConcurrent] jobs touch the database at once, so API and web
  /// requests always find a free connection in the pool.
  static const maxConcurrent = 2;
  static var _running = 0;
  static final _queue = <Future<void> Function()>[];

  static void _enqueue(Future<void> Function() job) {
    _queue.add(job);
    _drain();
  }

  static void _drain() {
    while (_running < maxConcurrent && _queue.isNotEmpty) {
      final job = _queue.removeAt(0);
      _running++;
      job().whenComplete(() {
        _running--;
        _drain();
      });
    }
  }
}
