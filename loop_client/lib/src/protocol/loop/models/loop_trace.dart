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
import '../../loop/models/loop_status.dart' as _ipcz1n71;

abstract class LoopTrace
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LoopTrace._({
    required this.loopId,
    required this.status,
    required this.placeIds,
    required this.at,
  });

  factory LoopTrace({
    required int loopId,
    required _ipcz1n71.LoopStatus status,
    required List<int> placeIds,
    required DateTime at,
  }) = _LoopTraceImpl;

  factory LoopTrace.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopTrace(
      loopId: jsonSerialization['loopId'] as int,
      status: _ipcz1n71.LoopStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      placeIds: _iunif0pu.Protocol().deserialize<List<int>>(
        jsonSerialization['placeIds'],
      ),
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  int loopId;

  _ipcz1n71.LoopStatus status;

  List<int> placeIds;

  DateTime at;

  /// Returns a shallow copy of this [LoopTrace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoopTrace copyWith({
    int? loopId,
    _ipcz1n71.LoopStatus? status,
    List<int>? placeIds,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopTrace',
      'loopId': loopId,
      'status': status.toJson(),
      'placeIds': placeIds.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopTrace',
      'loopId': loopId,
      'status': status.toJson(),
      'placeIds': placeIds.toJson(),
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LoopTraceImpl extends LoopTrace {
  _LoopTraceImpl({
    required int loopId,
    required _ipcz1n71.LoopStatus status,
    required List<int> placeIds,
    required DateTime at,
  }) : super._(
         loopId: loopId,
         status: status,
         placeIds: placeIds,
         at: at,
       );

  /// Returns a shallow copy of this [LoopTrace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoopTrace copyWith({
    int? loopId,
    _ipcz1n71.LoopStatus? status,
    List<int>? placeIds,
    DateTime? at,
  }) {
    return LoopTrace(
      loopId: loopId ?? this.loopId,
      status: status ?? this.status,
      placeIds: placeIds ?? this.placeIds.map((e0) => e0).toList(),
      at: at ?? this.at,
    );
  }
}
