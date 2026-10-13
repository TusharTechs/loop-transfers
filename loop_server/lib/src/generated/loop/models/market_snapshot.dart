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
import '../../loop/models/market_flow.dart' as _ik7woh8q;
import '../../loop/models/market_place.dart' as _ildk68xc;
import '../../loop/models/solver_run.dart' as _iz0lxjx7;

/// Anonymised picture of an exchange for the live map.
abstract class MarketSnapshot
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MarketSnapshot._({
    required this.exchangeId,
    required this.places,
    required this.flows,
    required this.loops,
    required this.activeListings,
    this.lastRun,
  });

  factory MarketSnapshot({
    required int exchangeId,
    required List<_ildk68xc.MarketPlace> places,
    required List<_ik7woh8q.MarketFlow> flows,
    required List<_iw2xx8jb.LoopTrace> loops,
    required int activeListings,
    _iz0lxjx7.SolverRun? lastRun,
  }) = _MarketSnapshotImpl;

  factory MarketSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketSnapshot(
      exchangeId: jsonSerialization['exchangeId'] as int,
      places: _iq3hot10.Protocol().deserialize<List<_ildk68xc.MarketPlace>>(
        jsonSerialization['places'],
      ),
      flows: _iq3hot10.Protocol().deserialize<List<_ik7woh8q.MarketFlow>>(
        jsonSerialization['flows'],
      ),
      loops: _iq3hot10.Protocol().deserialize<List<_iw2xx8jb.LoopTrace>>(
        jsonSerialization['loops'],
      ),
      activeListings: jsonSerialization['activeListings'] as int,
      lastRun: jsonSerialization['lastRun'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_iz0lxjx7.SolverRun>(
              jsonSerialization['lastRun'],
            ),
    );
  }

  int exchangeId;

  /// Places with at least one listing or wish.
  List<_ildk68xc.MarketPlace> places;

  /// Aggregated wishes: people at `fromPlaceId` wanting `toPlaceId`.
  List<_ik7woh8q.MarketFlow> flows;

  /// Recent loops as ordered place ids.
  List<_iw2xx8jb.LoopTrace> loops;

  int activeListings;

  _iz0lxjx7.SolverRun? lastRun;

  /// Returns a shallow copy of this [MarketSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MarketSnapshot copyWith({
    int? exchangeId,
    List<_ildk68xc.MarketPlace>? places,
    List<_ik7woh8q.MarketFlow>? flows,
    List<_iw2xx8jb.LoopTrace>? loops,
    int? activeListings,
    _iz0lxjx7.SolverRun? lastRun,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MarketSnapshot',
      'exchangeId': exchangeId,
      'places': places.toJson(valueToJson: (v) => v.toJson()),
      'flows': flows.toJson(valueToJson: (v) => v.toJson()),
      'loops': loops.toJson(valueToJson: (v) => v.toJson()),
      'activeListings': activeListings,
      if (lastRun != null) 'lastRun': lastRun?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MarketSnapshot',
      'exchangeId': exchangeId,
      'places': places.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'flows': flows.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'loops': loops.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'activeListings': activeListings,
      if (lastRun != null) 'lastRun': lastRun?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MarketSnapshotImpl extends MarketSnapshot {
  _MarketSnapshotImpl({
    required int exchangeId,
    required List<_ildk68xc.MarketPlace> places,
    required List<_ik7woh8q.MarketFlow> flows,
    required List<_iw2xx8jb.LoopTrace> loops,
    required int activeListings,
    _iz0lxjx7.SolverRun? lastRun,
  }) : super._(
         exchangeId: exchangeId,
         places: places,
         flows: flows,
         loops: loops,
         activeListings: activeListings,
         lastRun: lastRun,
       );

  /// Returns a shallow copy of this [MarketSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MarketSnapshot copyWith({
    int? exchangeId,
    List<_ildk68xc.MarketPlace>? places,
    List<_ik7woh8q.MarketFlow>? flows,
    List<_iw2xx8jb.LoopTrace>? loops,
    int? activeListings,
    Object? lastRun = _Undefined,
  }) {
    return MarketSnapshot(
      exchangeId: exchangeId ?? this.exchangeId,
      places: places ?? this.places.map((e0) => e0.copyWith()).toList(),
      flows: flows ?? this.flows.map((e0) => e0.copyWith()).toList(),
      loops: loops ?? this.loops.map((e0) => e0.copyWith()).toList(),
      activeListings: activeListings ?? this.activeListings,
      lastRun: lastRun is _iz0lxjx7.SolverRun?
          ? lastRun
          : this.lastRun?.copyWith(),
    );
  }
}
