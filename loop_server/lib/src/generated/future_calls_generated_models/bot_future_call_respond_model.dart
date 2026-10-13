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
import 'package:serverpod/serverpod.dart' as _is;

abstract class BotFutureCallRespondModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BotFutureCallRespondModel._({
    required this.loopId,
    required this.seatPosition,
  });

  factory BotFutureCallRespondModel({
    required int loopId,
    required int seatPosition,
  }) = _BotFutureCallRespondModelImpl;

  factory BotFutureCallRespondModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BotFutureCallRespondModel(
      loopId: jsonSerialization['loopId'] as int,
      seatPosition: jsonSerialization['seatPosition'] as int,
    );
  }

  int loopId;

  int seatPosition;

  /// Returns a shallow copy of this [BotFutureCallRespondModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BotFutureCallRespondModel copyWith({
    int? loopId,
    int? seatPosition,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BotFutureCallRespondModel',
      'loopId': loopId,
      'seatPosition': seatPosition,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _BotFutureCallRespondModelImpl extends BotFutureCallRespondModel {
  _BotFutureCallRespondModelImpl({
    required int loopId,
    required int seatPosition,
  }) : super._(
         loopId: loopId,
         seatPosition: seatPosition,
       );

  /// Returns a shallow copy of this [BotFutureCallRespondModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BotFutureCallRespondModel copyWith({
    int? loopId,
    int? seatPosition,
  }) {
    return BotFutureCallRespondModel(
      loopId: loopId ?? this.loopId,
      seatPosition: seatPosition ?? this.seatPosition,
    );
  }
}
