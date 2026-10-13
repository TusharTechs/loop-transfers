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
import '../../loop/models/loop_event_kind.dart' as _i66as2so;

/// Audit timeline of a loop.
abstract class LoopEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LoopEvent._({
    this.id,
    required this.loopId,
    required this.kind,
    this.seatPosition,
    DateTime? at,
  }) : at = at ?? DateTime.now();

  factory LoopEvent({
    int? id,
    required int loopId,
    required _i66as2so.LoopEventKind kind,
    int? seatPosition,
    DateTime? at,
  }) = _LoopEventImpl;

  factory LoopEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopEvent(
      id: jsonSerialization['id'] as int?,
      loopId: jsonSerialization['loopId'] as int,
      kind: _i66as2so.LoopEventKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      seatPosition: jsonSerialization['seatPosition'] as int?,
      at: jsonSerialization['at'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int loopId;

  _i66as2so.LoopEventKind kind;

  int? seatPosition;

  DateTime at;

  /// Returns a shallow copy of this [LoopEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoopEvent copyWith({
    int? id,
    int? loopId,
    _i66as2so.LoopEventKind? kind,
    int? seatPosition,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopEvent',
      if (id != null) 'id': id,
      'loopId': loopId,
      'kind': kind.toJson(),
      if (seatPosition != null) 'seatPosition': seatPosition,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopEvent',
      if (id != null) 'id': id,
      'loopId': loopId,
      'kind': kind.toJson(),
      if (seatPosition != null) 'seatPosition': seatPosition,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoopEventImpl extends LoopEvent {
  _LoopEventImpl({
    int? id,
    required int loopId,
    required _i66as2so.LoopEventKind kind,
    int? seatPosition,
    DateTime? at,
  }) : super._(
         id: id,
         loopId: loopId,
         kind: kind,
         seatPosition: seatPosition,
         at: at,
       );

  /// Returns a shallow copy of this [LoopEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoopEvent copyWith({
    Object? id = _Undefined,
    int? loopId,
    _i66as2so.LoopEventKind? kind,
    Object? seatPosition = _Undefined,
    DateTime? at,
  }) {
    return LoopEvent(
      id: id is int? ? id : this.id,
      loopId: loopId ?? this.loopId,
      kind: kind ?? this.kind,
      seatPosition: seatPosition is int? ? seatPosition : this.seatPosition,
      at: at ?? this.at,
    );
  }
}
