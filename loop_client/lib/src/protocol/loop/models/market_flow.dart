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

abstract class MarketFlow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MarketFlow._({
    required this.fromPlaceId,
    required this.toPlaceId,
    required this.count,
  });

  factory MarketFlow({
    required int fromPlaceId,
    required int toPlaceId,
    required int count,
  }) = _MarketFlowImpl;

  factory MarketFlow.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketFlow(
      fromPlaceId: jsonSerialization['fromPlaceId'] as int,
      toPlaceId: jsonSerialization['toPlaceId'] as int,
      count: jsonSerialization['count'] as int,
    );
  }

  int fromPlaceId;

  int toPlaceId;

  int count;

  /// Returns a shallow copy of this [MarketFlow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MarketFlow copyWith({
    int? fromPlaceId,
    int? toPlaceId,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MarketFlow',
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MarketFlow',
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'count': count,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MarketFlowImpl extends MarketFlow {
  _MarketFlowImpl({
    required int fromPlaceId,
    required int toPlaceId,
    required int count,
  }) : super._(
         fromPlaceId: fromPlaceId,
         toPlaceId: toPlaceId,
         count: count,
       );

  /// Returns a shallow copy of this [MarketFlow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MarketFlow copyWith({
    int? fromPlaceId,
    int? toPlaceId,
    int? count,
  }) {
    return MarketFlow(
      fromPlaceId: fromPlaceId ?? this.fromPlaceId,
      toPlaceId: toPlaceId ?? this.toPlaceId,
      count: count ?? this.count,
    );
  }
}
