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

/// Pushed live to one member when one of their loops changes.
abstract class MemberUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemberUpdate._({
    required this.loopId,
    required this.status,
    required this.at,
  });

  factory MemberUpdate({
    required int loopId,
    required _ipcz1n71.LoopStatus status,
    required DateTime at,
  }) = _MemberUpdateImpl;

  factory MemberUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberUpdate(
      loopId: jsonSerialization['loopId'] as int,
      status: _ipcz1n71.LoopStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  int loopId;

  _ipcz1n71.LoopStatus status;

  DateTime at;

  /// Returns a shallow copy of this [MemberUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemberUpdate copyWith({
    int? loopId,
    _ipcz1n71.LoopStatus? status,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberUpdate',
      'loopId': loopId,
      'status': status.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberUpdate',
      'loopId': loopId,
      'status': status.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MemberUpdateImpl extends MemberUpdate {
  _MemberUpdateImpl({
    required int loopId,
    required _ipcz1n71.LoopStatus status,
    required DateTime at,
  }) : super._(
         loopId: loopId,
         status: status,
         at: at,
       );

  /// Returns a shallow copy of this [MemberUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemberUpdate copyWith({
    int? loopId,
    _ipcz1n71.LoopStatus? status,
    DateTime? at,
  }) {
    return MemberUpdate(
      loopId: loopId ?? this.loopId,
      status: status ?? this.status,
      at: at ?? this.at,
    );
  }
}
