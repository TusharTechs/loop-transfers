/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:loop_server/src/generated/protocol.dart' as _iq3hot10;
import 'package:serverpod/serverpod.dart' as _is;
import '../../loop/models/exchange.dart' as _if8hwbkr;
import '../../loop/models/solver_run.dart' as _iz0lxjx7;

abstract class ExchangeSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ExchangeSummary._({
    required this.exchange,
    required this.activeListings,
    required this.confirmedLoops,
    required this.peopleMatched,
    this.lastRun,
  });

  factory ExchangeSummary({
    required _if8hwbkr.Exchange exchange,
    required int activeListings,
    required int confirmedLoops,
    required int peopleMatched,
    _iz0lxjx7.SolverRun? lastRun,
  }) = _ExchangeSummaryImpl;

  factory ExchangeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExchangeSummary(
      exchange: _iq3hot10.Protocol().deserialize<_if8hwbkr.Exchange>(
        jsonSerialization['exchange'],
      ),
      activeListings: jsonSerialization['activeListings'] as int,
      confirmedLoops: jsonSerialization['confirmedLoops'] as int,
      peopleMatched: jsonSerialization['peopleMatched'] as int,
      lastRun: jsonSerialization['lastRun'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_iz0lxjx7.SolverRun>(
              jsonSerialization['lastRun'],
            ),
    );
  }

  _if8hwbkr.Exchange exchange;

  int activeListings;

  int confirmedLoops;

  int peopleMatched;

  _iz0lxjx7.SolverRun? lastRun;

  /// Returns a shallow copy of this [ExchangeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExchangeSummary copyWith({
    _if8hwbkr.Exchange? exchange,
    int? activeListings,
    int? confirmedLoops,
    int? peopleMatched,
    _iz0lxjx7.SolverRun? lastRun,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExchangeSummary',
      'exchange': exchange.toJson(),
      'activeListings': activeListings,
      'confirmedLoops': confirmedLoops,
      'peopleMatched': peopleMatched,
      if (lastRun != null) 'lastRun': lastRun?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExchangeSummary',
      'exchange': exchange.toJsonForProtocol(),
      'activeListings': activeListings,
      'confirmedLoops': confirmedLoops,
      'peopleMatched': peopleMatched,
      if (lastRun != null) 'lastRun': lastRun?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExchangeSummaryImpl extends ExchangeSummary {
  _ExchangeSummaryImpl({
    required _if8hwbkr.Exchange exchange,
    required int activeListings,
    required int confirmedLoops,
    required int peopleMatched,
    _iz0lxjx7.SolverRun? lastRun,
  }) : super._(
         exchange: exchange,
         activeListings: activeListings,
         confirmedLoops: confirmedLoops,
         peopleMatched: peopleMatched,
         lastRun: lastRun,
       );

  /// Returns a shallow copy of this [ExchangeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExchangeSummary copyWith({
    _if8hwbkr.Exchange? exchange,
    int? activeListings,
    int? confirmedLoops,
    int? peopleMatched,
    Object? lastRun = _Undefined,
  }) {
    return ExchangeSummary(
      exchange: exchange ?? this.exchange.copyWith(),
      activeListings: activeListings ?? this.activeListings,
      confirmedLoops: confirmedLoops ?? this.confirmedLoops,
      peopleMatched: peopleMatched ?? this.peopleMatched,
      lastRun: lastRun is _iz0lxjx7.SolverRun?
          ? lastRun
          : this.lastRun?.copyWith(),
    );
  }
}
