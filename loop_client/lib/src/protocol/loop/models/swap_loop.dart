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
import '../../loop/models/loop_status.dart' as _ipcz1n71;

/// A proposed or settled cycle of swaps.
abstract class SwapLoop
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SwapLoop._({
    this.id,
    required this.exchangeId,
    _ipcz1n71.LoopStatus? status,
    required this.size,
    required this.score,
    DateTime? createdAt,
    required this.deadline,
    this.resolvedAt,
  }) : status = status ?? _ipcz1n71.LoopStatus.proposed,
       createdAt = createdAt ?? DateTime.now();

  factory SwapLoop({
    int? id,
    required int exchangeId,
    _ipcz1n71.LoopStatus? status,
    required int size,
    required double score,
    DateTime? createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
  }) = _SwapLoopImpl;

  factory SwapLoop.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapLoop(
      id: jsonSerialization['id'] as int?,
      exchangeId: jsonSerialization['exchangeId'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _ipcz1n71.LoopStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      size: jsonSerialization['size'] as int,
      score: (jsonSerialization['score'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      deadline: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int exchangeId;

  _ipcz1n71.LoopStatus status;

  int size;

  double score;

  DateTime createdAt;

  DateTime deadline;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [SwapLoop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SwapLoop copyWith({
    int? id,
    int? exchangeId,
    _ipcz1n71.LoopStatus? status,
    int? size,
    double? score,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapLoop',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'status': status.toJson(),
      'size': size,
      'score': score,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SwapLoop',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'status': status.toJson(),
      'size': size,
      'score': score,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapLoopImpl extends SwapLoop {
  _SwapLoopImpl({
    int? id,
    required int exchangeId,
    _ipcz1n71.LoopStatus? status,
    required int size,
    required double score,
    DateTime? createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         exchangeId: exchangeId,
         status: status,
         size: size,
         score: score,
         createdAt: createdAt,
         deadline: deadline,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [SwapLoop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SwapLoop copyWith({
    Object? id = _Undefined,
    int? exchangeId,
    _ipcz1n71.LoopStatus? status,
    int? size,
    double? score,
    DateTime? createdAt,
    DateTime? deadline,
    Object? resolvedAt = _Undefined,
  }) {
    return SwapLoop(
      id: id is int? ? id : this.id,
      exchangeId: exchangeId ?? this.exchangeId,
      status: status ?? this.status,
      size: size ?? this.size,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
