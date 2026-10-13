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
import '../../loop/models/loop_event.dart' as _ifw3hhum;
import '../../loop/models/loop_status.dart' as _ipcz1n71;
import '../../loop/models/seat_view.dart' as _ip091m2u;

abstract class LoopView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LoopView._({
    required this.id,
    required this.exchangeId,
    required this.exchangeName,
    required this.status,
    required this.size,
    required this.createdAt,
    required this.deadline,
    this.resolvedAt,
    required this.seats,
    required this.myPosition,
    required this.events,
    this.publicCode,
  });

  factory LoopView({
    required int id,
    required int exchangeId,
    required String exchangeName,
    required _ipcz1n71.LoopStatus status,
    required int size,
    required DateTime createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
    required List<_ip091m2u.SeatView> seats,
    required int myPosition,
    required List<_ifw3hhum.LoopEvent> events,
    String? publicCode,
  }) = _LoopViewImpl;

  factory LoopView.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopView(
      id: jsonSerialization['id'] as int,
      exchangeId: jsonSerialization['exchangeId'] as int,
      exchangeName: jsonSerialization['exchangeName'] as String,
      status: _ipcz1n71.LoopStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      size: jsonSerialization['size'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      deadline: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
      seats: _iunif0pu.Protocol().deserialize<List<_ip091m2u.SeatView>>(
        jsonSerialization['seats'],
      ),
      myPosition: jsonSerialization['myPosition'] as int,
      events: _iunif0pu.Protocol().deserialize<List<_ifw3hhum.LoopEvent>>(
        jsonSerialization['events'],
      ),
      publicCode: jsonSerialization['publicCode'] as String?,
    );
  }

  int id;

  int exchangeId;

  String exchangeName;

  _ipcz1n71.LoopStatus status;

  int size;

  DateTime createdAt;

  DateTime deadline;

  DateTime? resolvedAt;

  List<_ip091m2u.SeatView> seats;

  int myPosition;

  List<_ifw3hhum.LoopEvent> events;

  /// Verification code, present once confirmed.
  String? publicCode;

  /// Returns a shallow copy of this [LoopView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoopView copyWith({
    int? id,
    int? exchangeId,
    String? exchangeName,
    _ipcz1n71.LoopStatus? status,
    int? size,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? resolvedAt,
    List<_ip091m2u.SeatView>? seats,
    int? myPosition,
    List<_ifw3hhum.LoopEvent>? events,
    String? publicCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopView',
      'id': id,
      'exchangeId': exchangeId,
      'exchangeName': exchangeName,
      'status': status.toJson(),
      'size': size,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'seats': seats.toJson(valueToJson: (v) => v.toJson()),
      'myPosition': myPosition,
      'events': events.toJson(valueToJson: (v) => v.toJson()),
      if (publicCode != null) 'publicCode': publicCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopView',
      'id': id,
      'exchangeId': exchangeId,
      'exchangeName': exchangeName,
      'status': status.toJson(),
      'size': size,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'seats': seats.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'myPosition': myPosition,
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (publicCode != null) 'publicCode': publicCode,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoopViewImpl extends LoopView {
  _LoopViewImpl({
    required int id,
    required int exchangeId,
    required String exchangeName,
    required _ipcz1n71.LoopStatus status,
    required int size,
    required DateTime createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
    required List<_ip091m2u.SeatView> seats,
    required int myPosition,
    required List<_ifw3hhum.LoopEvent> events,
    String? publicCode,
  }) : super._(
         id: id,
         exchangeId: exchangeId,
         exchangeName: exchangeName,
         status: status,
         size: size,
         createdAt: createdAt,
         deadline: deadline,
         resolvedAt: resolvedAt,
         seats: seats,
         myPosition: myPosition,
         events: events,
         publicCode: publicCode,
       );

  /// Returns a shallow copy of this [LoopView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoopView copyWith({
    int? id,
    int? exchangeId,
    String? exchangeName,
    _ipcz1n71.LoopStatus? status,
    int? size,
    DateTime? createdAt,
    DateTime? deadline,
    Object? resolvedAt = _Undefined,
    List<_ip091m2u.SeatView>? seats,
    int? myPosition,
    List<_ifw3hhum.LoopEvent>? events,
    Object? publicCode = _Undefined,
  }) {
    return LoopView(
      id: id ?? this.id,
      exchangeId: exchangeId ?? this.exchangeId,
      exchangeName: exchangeName ?? this.exchangeName,
      status: status ?? this.status,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      seats: seats ?? this.seats.map((e0) => e0.copyWith()).toList(),
      myPosition: myPosition ?? this.myPosition,
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
      publicCode: publicCode is String? ? publicCode : this.publicCode,
    );
  }
}
