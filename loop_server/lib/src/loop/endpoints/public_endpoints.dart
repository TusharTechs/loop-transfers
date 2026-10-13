import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../services/loop_service.dart';
import '../services/market.dart';
import '../services/simulation.dart';

/// District search for postings and wishes. Public.
class PlaceEndpoint extends Endpoint {
  Future<List<Place>> search(
    Session session,
    String query, {
    String? state,
  }) async {
    final q = query.trim();
    return Place.db.find(
      session,
      where: (t) {
        Expression e = q.isEmpty ? Constant.bool(true) : t.name.ilike('%$q%');
        if (state != null) e = e & t.state.equals(state);
        return e;
      },
      orderBy: (t) => t.population.desc(),
      limit: 25,
    );
  }

  Future<List<Place>> byIds(Session session, List<int> ids) => Place.db.find(
    session,
    where: (t) => t.id.inSet(ids.take(200).toSet()),
  );
}

/// Exchanges and their live, anonymised market. Public, so anyone can watch
/// loops form before signing up.
class ExchangeEndpoint extends Endpoint {
  Future<List<ExchangeSummary>> list(Session session) =>
      Market.summaries(session);

  Future<MarketSnapshot> snapshot(Session session, int exchangeId) =>
      Market.snapshot(session, exchangeId);

  /// Live market events for one exchange. Watching a simulated market keeps
  /// it moving (see [Simulation]).
  Stream<MarketEvent> watch(Session session, int exchangeId) async* {
    Simulation.join(exchangeId);
    try {
      yield* session.messages.createStream<MarketEvent>(
        Channels.exchange(exchangeId),
      );
    } finally {
      Simulation.leave(exchangeId);
    }
  }
}
