/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../loop/loop_future_calls.dart' as _i2aqe79y;
import 'future_calls_generated_models/bot_future_call_respond_model.dart'
    as _ivgds3jj;
import 'future_calls_generated_models/loop_deadline_future_call_expire_model.dart'
    as _irmg46bk;
import 'future_calls_generated_models/solve_future_call_solve_model.dart'
    as _it5h8prl;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'LoopDeadlineExpireFutureCall': LoopDeadlineExpireFutureCall(),
      'SolveSolveFutureCall': SolveSolveFutureCall(),
      'SweepSweepFutureCall': SweepSweepFutureCall(),
      'BotRespondFutureCall': BotRespondFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final loopDeadline = _LoopDeadlineFutureCallDispatcher(
    _invokeFutureCall,
  );

  late final solve = _SolveFutureCallDispatcher(_invokeFutureCall);

  late final sweep = _SweepFutureCallDispatcher(_invokeFutureCall);

  late final bot = _BotFutureCallDispatcher(_invokeFutureCall);
}

class _LoopDeadlineFutureCallDispatcher {
  _LoopDeadlineFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> expire(int loopId) {
    var object = _irmg46bk.LoopDeadlineFutureCallExpireModel(loopId: loopId);
    return _invokeFutureCall(
      'LoopDeadlineExpireFutureCall',
      object,
    );
  }
}

class _SolveFutureCallDispatcher {
  _SolveFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> solve(int exchangeId) {
    var object = _it5h8prl.SolveFutureCallSolveModel(exchangeId: exchangeId);
    return _invokeFutureCall(
      'SolveSolveFutureCall',
      object,
    );
  }
}

class _SweepFutureCallDispatcher {
  _SweepFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> sweep() {
    return _invokeFutureCall(
      'SweepSweepFutureCall',
      null,
    );
  }
}

class _BotFutureCallDispatcher {
  _BotFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> respond(
    int loopId,
    int seatPosition,
  ) {
    var object = _ivgds3jj.BotFutureCallRespondModel(
      loopId: loopId,
      seatPosition: seatPosition,
    );
    return _invokeFutureCall(
      'BotRespondFutureCall',
      object,
    );
  }
}

class LoopDeadlineExpireFutureCall
    extends _is.FutureCall<_irmg46bk.LoopDeadlineFutureCallExpireModel>
    implements
        _is.InvokableFutureCall<_irmg46bk.LoopDeadlineFutureCallExpireModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _irmg46bk.LoopDeadlineFutureCallExpireModel? object,
  ) async {
    if (object != null) {
      await _i2aqe79y.LoopDeadlineFutureCall().expire(
        session,
        object.loopId,
      );
    }
  }
}

class SolveSolveFutureCall
    extends _is.FutureCall<_it5h8prl.SolveFutureCallSolveModel>
    implements _is.InvokableFutureCall<_it5h8prl.SolveFutureCallSolveModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _it5h8prl.SolveFutureCallSolveModel? object,
  ) async {
    if (object != null) {
      await _i2aqe79y.SolveFutureCall().solve(
        session,
        object.exchangeId,
      );
    }
  }
}

class SweepSweepFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _i2aqe79y.SweepFutureCall().sweep(session);
  }
}

class BotRespondFutureCall
    extends _is.FutureCall<_ivgds3jj.BotFutureCallRespondModel>
    implements _is.InvokableFutureCall<_ivgds3jj.BotFutureCallRespondModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _ivgds3jj.BotFutureCallRespondModel? object,
  ) async {
    if (object != null) {
      await _i2aqe79y.BotFutureCall().respond(
        session,
        object.loopId,
        object.seatPosition,
      );
    }
  }
}
