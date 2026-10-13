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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// One run of the loop engine over an exchange.
abstract class SolverRun
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SolverRun._({
    this.id,
    required this.exchangeId,
    DateTime? at,
    required this.trigger,
    required this.activeListings,
    required this.edgeCount,
    required this.coreSize,
    required this.candidateCount,
    required this.loopsProposed,
    required this.peopleInLoops,
    required this.pairwisePeople,
    required this.elapsedMs,
  }) : at = at ?? DateTime.now();

  factory SolverRun({
    int? id,
    required int exchangeId,
    DateTime? at,
    required String trigger,
    required int activeListings,
    required int edgeCount,
    required int coreSize,
    required int candidateCount,
    required int loopsProposed,
    required int peopleInLoops,
    required int pairwisePeople,
    required int elapsedMs,
  }) = _SolverRunImpl;

  factory SolverRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return SolverRun(
      id: jsonSerialization['id'] as int?,
      exchangeId: jsonSerialization['exchangeId'] as int,
      at: jsonSerialization['at'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      trigger: jsonSerialization['trigger'] as String,
      activeListings: jsonSerialization['activeListings'] as int,
      edgeCount: jsonSerialization['edgeCount'] as int,
      coreSize: jsonSerialization['coreSize'] as int,
      candidateCount: jsonSerialization['candidateCount'] as int,
      loopsProposed: jsonSerialization['loopsProposed'] as int,
      peopleInLoops: jsonSerialization['peopleInLoops'] as int,
      pairwisePeople: jsonSerialization['pairwisePeople'] as int,
      elapsedMs: jsonSerialization['elapsedMs'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exchangeId;

  DateTime at;

  String trigger;

  int activeListings;

  int edgeCount;

  int coreSize;

  int candidateCount;

  int loopsProposed;

  int peopleInLoops;

  /// People a pairwise-only portal would have matched on the same graph.
  int pairwisePeople;

  int elapsedMs;

  /// Returns a shallow copy of this [SolverRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SolverRun copyWith({
    int? id,
    int? exchangeId,
    DateTime? at,
    String? trigger,
    int? activeListings,
    int? edgeCount,
    int? coreSize,
    int? candidateCount,
    int? loopsProposed,
    int? peopleInLoops,
    int? pairwisePeople,
    int? elapsedMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SolverRun',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'at': at.toJson(),
      'trigger': trigger,
      'activeListings': activeListings,
      'edgeCount': edgeCount,
      'coreSize': coreSize,
      'candidateCount': candidateCount,
      'loopsProposed': loopsProposed,
      'peopleInLoops': peopleInLoops,
      'pairwisePeople': pairwisePeople,
      'elapsedMs': elapsedMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SolverRun',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'at': at.toJson(),
      'trigger': trigger,
      'activeListings': activeListings,
      'edgeCount': edgeCount,
      'coreSize': coreSize,
      'candidateCount': candidateCount,
      'loopsProposed': loopsProposed,
      'peopleInLoops': peopleInLoops,
      'pairwisePeople': pairwisePeople,
      'elapsedMs': elapsedMs,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SolverRunImpl extends SolverRun {
  _SolverRunImpl({
    int? id,
    required int exchangeId,
    DateTime? at,
    required String trigger,
    required int activeListings,
    required int edgeCount,
    required int coreSize,
    required int candidateCount,
    required int loopsProposed,
    required int peopleInLoops,
    required int pairwisePeople,
    required int elapsedMs,
  }) : super._(
         id: id,
         exchangeId: exchangeId,
         at: at,
         trigger: trigger,
         activeListings: activeListings,
         edgeCount: edgeCount,
         coreSize: coreSize,
         candidateCount: candidateCount,
         loopsProposed: loopsProposed,
         peopleInLoops: peopleInLoops,
         pairwisePeople: pairwisePeople,
         elapsedMs: elapsedMs,
       );

  /// Returns a shallow copy of this [SolverRun]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SolverRun copyWith({
    Object? id = _Undefined,
    int? exchangeId,
    DateTime? at,
    String? trigger,
    int? activeListings,
    int? edgeCount,
    int? coreSize,
    int? candidateCount,
    int? loopsProposed,
    int? peopleInLoops,
    int? pairwisePeople,
    int? elapsedMs,
  }) {
    return SolverRun(
      id: id is int? ? id : this.id,
      exchangeId: exchangeId ?? this.exchangeId,
      at: at ?? this.at,
      trigger: trigger ?? this.trigger,
      activeListings: activeListings ?? this.activeListings,
      edgeCount: edgeCount ?? this.edgeCount,
      coreSize: coreSize ?? this.coreSize,
      candidateCount: candidateCount ?? this.candidateCount,
      loopsProposed: loopsProposed ?? this.loopsProposed,
      peopleInLoops: peopleInLoops ?? this.peopleInLoops,
      pairwisePeople: pairwisePeople ?? this.pairwisePeople,
      elapsedMs: elapsedMs ?? this.elapsedMs,
    );
  }
}
