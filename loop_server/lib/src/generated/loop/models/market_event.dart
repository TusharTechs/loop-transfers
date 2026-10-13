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
import '../../loop/models/loop_trace.dart' as _iw2xx8jb;
import '../../loop/models/market_event_kind.dart' as _ilyrf6ry;
import '../../loop/models/solver_run.dart' as _iz0lxjx7;

/// Pushed live to everyone watching an exchange.
abstract class MarketEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MarketEvent._({
    required this.exchangeId,
    required this.kind,
    this.loop,
    this.run,
    this.activeListings,
    required this.at,
  });

  factory MarketEvent({
    required int exchangeId,
    required _ilyrf6ry.MarketEventKind kind,
    _iw2xx8jb.LoopTrace? loop,
    _iz0lxjx7.SolverRun? run,
    int? activeListings,
    required DateTime at,
  }) = _MarketEventImpl;

  factory MarketEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketEvent(
      exchangeId: jsonSerialization['exchangeId'] as int,
      kind: _ilyrf6ry.MarketEventKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      loop: jsonSerialization['loop'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_iw2xx8jb.LoopTrace>(
              jsonSerialization['loop'],
            ),
      run: jsonSerialization['run'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_iz0lxjx7.SolverRun>(
              jsonSerialization['run'],
            ),
      activeListings: jsonSerialization['activeListings'] as int?,
      at: _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  int exchangeId;

  _ilyrf6ry.MarketEventKind kind;

  _iw2xx8jb.LoopTrace? loop;

  _iz0lxjx7.SolverRun? run;

  int? activeListings;

  DateTime at;

  /// Returns a shallow copy of this [MarketEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MarketEvent copyWith({
    int? exchangeId,
    _ilyrf6ry.MarketEventKind? kind,
    _iw2xx8jb.LoopTrace? loop,
    _iz0lxjx7.SolverRun? run,
    int? activeListings,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MarketEvent',
      'exchangeId': exchangeId,
      'kind': kind.toJson(),
      if (loop != null) 'loop': loop?.toJson(),
      if (run != null) 'run': run?.toJson(),
      if (activeListings != null) 'activeListings': activeListings,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MarketEvent',
      'exchangeId': exchangeId,
      'kind': kind.toJson(),
      if (loop != null) 'loop': loop?.toJsonForProtocol(),
      if (run != null) 'run': run?.toJsonForProtocol(),
      if (activeListings != null) 'activeListings': activeListings,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MarketEventImpl extends MarketEvent {
  _MarketEventImpl({
    required int exchangeId,
    required _ilyrf6ry.MarketEventKind kind,
    _iw2xx8jb.LoopTrace? loop,
    _iz0lxjx7.SolverRun? run,
    int? activeListings,
    required DateTime at,
  }) : super._(
         exchangeId: exchangeId,
         kind: kind,
         loop: loop,
         run: run,
         activeListings: activeListings,
         at: at,
       );

  /// Returns a shallow copy of this [MarketEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MarketEvent copyWith({
    int? exchangeId,
    _ilyrf6ry.MarketEventKind? kind,
    Object? loop = _Undefined,
    Object? run = _Undefined,
    Object? activeListings = _Undefined,
    DateTime? at,
  }) {
    return MarketEvent(
      exchangeId: exchangeId ?? this.exchangeId,
      kind: kind ?? this.kind,
      loop: loop is _iw2xx8jb.LoopTrace? ? loop : this.loop?.copyWith(),
      run: run is _iz0lxjx7.SolverRun? ? run : this.run?.copyWith(),
      activeListings: activeListings is int?
          ? activeListings
          : this.activeListings,
      at: at ?? this.at,
    );
  }
}
