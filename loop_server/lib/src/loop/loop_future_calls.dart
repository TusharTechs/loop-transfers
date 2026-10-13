import 'package:serverpod/serverpod.dart';

import 'services/bots.dart';
import 'services/loop_service.dart';

/// Expires a proposed loop whose acceptance window has closed.
class LoopDeadlineFutureCall extends FutureCall {
  Future<void> expire(Session session, int loopId) =>
      LoopService.expire(session, loopId);
}

/// Runs the loop engine over one exchange. Scheduled (debounced) whenever
/// listings change, and after loops dissolve.
class SolveFutureCall extends FutureCall {
  Future<void> solve(Session session, int exchangeId) =>
      LoopService.solveExchange(session, exchangeId, trigger: 'change');
}

/// Safety net: periodically re-solves every exchange and keeps the simulated
/// markets lively.
class SweepFutureCall extends FutureCall {
  Future<void> sweep(Session session) => LoopService.sweep(session);
}

/// A simulated member answering a loop proposal.
class BotFutureCall extends FutureCall {
  Future<void> respond(Session session, int loopId, int seatPosition) =>
      Bots.respond(session, loopId, seatPosition);
}
