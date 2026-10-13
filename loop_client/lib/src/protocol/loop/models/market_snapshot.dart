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
import 'package:loop_client/src/protocol/protocol.dart' as _iunif0pu;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../loop/models/loop_trace.dart' as _iw2xx8jb;
import '../../loop/models/market_flow.dart' as _ik7woh8q;
import '../../loop/models/market_place.dart' as _ildk68xc;
import '../../loop/models/solver_run.dart' as _iz0lxjx7;

/// Anonymised picture of an exchange for the live map.
abstract class MarketSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MarketSnapshot._({
    required this.exchangeId,
    required this.places,
    required this.flows,
    required this.loops,
    required this.activeListings,
    this.lastRun,
    required this.confirmedLoops,
    required this.peopleMatched,
    required this.loopPeopleTotal,
    required this.pairPeopleTotal,
    required this.runs,
  });

  factory MarketSnapshot({
    required int exchangeId,
    required List<_ildk68xc.MarketPlace> places,
    required List<_ik7woh8q.MarketFlow> flows,
    required List<_iw2xx8jb.LoopTrace> loops,
    required int activeListings,
    _iz0lxjx7.SolverRun? lastRun,
    required int confirmedLoops,
    required int peopleMatched,
    required int loopPeopleTotal,
    required int pairPeopleTotal,
    required int runs,
  }) = _MarketSnapshotImpl;

  factory MarketSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketSnapshot(
      exchangeId: jsonSerialization['exchangeId'] as int,
      places: _iunif0pu.Protocol().deserialize<List<_ildk68xc.MarketPlace>>(
        jsonSerialization['places'],
      ),
      flows: _iunif0pu.Protocol().deserialize<List<_ik7woh8q.MarketFlow>>(
        jsonSerialization['flows'],
      ),
      loops: _iunif0pu.Protocol().deserialize<List<_iw2xx8jb.LoopTrace>>(
        jsonSerialization['loops'],
      ),
      activeListings: jsonSerialization['activeListings'] as int,
      lastRun: jsonSerialization['lastRun'] == null
          ? null
          : _iunif0pu.Protocol().deserialize<_iz0lxjx7.SolverRun>(
              jsonSerialization['lastRun'],
            ),
      confirmedLoops: jsonSerialization['confirmedLoops'] as int,
      peopleMatched: jsonSerialization['peopleMatched'] as int,
      loopPeopleTotal: jsonSerialization['loopPeopleTotal'] as int,
      pairPeopleTotal: jsonSerialization['pairPeopleTotal'] as int,
      runs: jsonSerialization['runs'] as int,
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

  int confirmedLoops;

  int peopleMatched;

  /// Sum over every engine run: people placed in proposed loops, and people
  /// a pairwise-only portal would have matched on the same graphs.
  int loopPeopleTotal;

  int pairPeopleTotal;

  int runs;

  /// Returns a shallow copy of this [MarketSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MarketSnapshot copyWith({
    int? exchangeId,
    List<_ildk68xc.MarketPlace>? places,
    List<_ik7woh8q.MarketFlow>? flows,
    List<_iw2xx8jb.LoopTrace>? loops,
    int? activeListings,
    _iz0lxjx7.SolverRun? lastRun,
    int? confirmedLoops,
    int? peopleMatched,
    int? loopPeopleTotal,
    int? pairPeopleTotal,
    int? runs,
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
      'confirmedLoops': confirmedLoops,
      'peopleMatched': peopleMatched,
      'loopPeopleTotal': loopPeopleTotal,
      'pairPeopleTotal': pairPeopleTotal,
      'runs': runs,
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
      'confirmedLoops': confirmedLoops,
      'peopleMatched': peopleMatched,
      'loopPeopleTotal': loopPeopleTotal,
      'pairPeopleTotal': pairPeopleTotal,
      'runs': runs,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
    required int confirmedLoops,
    required int peopleMatched,
    required int loopPeopleTotal,
    required int pairPeopleTotal,
    required int runs,
  }) : super._(
         exchangeId: exchangeId,
         places: places,
         flows: flows,
         loops: loops,
         activeListings: activeListings,
         lastRun: lastRun,
         confirmedLoops: confirmedLoops,
         peopleMatched: peopleMatched,
         loopPeopleTotal: loopPeopleTotal,
         pairPeopleTotal: pairPeopleTotal,
         runs: runs,
       );

  /// Returns a shallow copy of this [MarketSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MarketSnapshot copyWith({
    int? exchangeId,
    List<_ildk68xc.MarketPlace>? places,
    List<_ik7woh8q.MarketFlow>? flows,
    List<_iw2xx8jb.LoopTrace>? loops,
    int? activeListings,
    Object? lastRun = _Undefined,
    int? confirmedLoops,
    int? peopleMatched,
    int? loopPeopleTotal,
    int? pairPeopleTotal,
    int? runs,
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
      confirmedLoops: confirmedLoops ?? this.confirmedLoops,
      peopleMatched: peopleMatched ?? this.peopleMatched,
      loopPeopleTotal: loopPeopleTotal ?? this.loopPeopleTotal,
      pairPeopleTotal: pairPeopleTotal ?? this.pairPeopleTotal,
      runs: runs ?? this.runs,
    );
  }
}
