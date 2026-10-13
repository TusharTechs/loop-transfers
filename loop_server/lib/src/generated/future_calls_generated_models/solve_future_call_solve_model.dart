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

abstract class SolveFutureCallSolveModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SolveFutureCallSolveModel._({required this.exchangeId});

  factory SolveFutureCallSolveModel({required int exchangeId}) =
      _SolveFutureCallSolveModelImpl;

  factory SolveFutureCallSolveModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SolveFutureCallSolveModel(
      exchangeId: jsonSerialization['exchangeId'] as int,
    );
  }

  int exchangeId;

  /// Returns a shallow copy of this [SolveFutureCallSolveModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SolveFutureCallSolveModel copyWith({int? exchangeId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SolveFutureCallSolveModel',
      'exchangeId': exchangeId,
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

class _SolveFutureCallSolveModelImpl extends SolveFutureCallSolveModel {
  _SolveFutureCallSolveModelImpl({required int exchangeId})
    : super._(exchangeId: exchangeId);

  /// Returns a shallow copy of this [SolveFutureCallSolveModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SolveFutureCallSolveModel copyWith({int? exchangeId}) {
    return SolveFutureCallSolveModel(exchangeId: exchangeId ?? this.exchangeId);
  }
}
