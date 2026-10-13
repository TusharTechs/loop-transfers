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
import '../../loop/models/loop_error_code.dart' as _id7kzu74;

abstract class LoopException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  LoopException._({
    required this.message,
    required this.code,
  });

  factory LoopException({
    required String message,
    required _id7kzu74.LoopErrorCode code,
  }) = _LoopExceptionImpl;

  factory LoopException.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopException(
      message: jsonSerialization['message'] as String,
      code: _id7kzu74.LoopErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _id7kzu74.LoopErrorCode code;

  /// Returns a shallow copy of this [LoopException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoopException copyWith({
    String? message,
    _id7kzu74.LoopErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'LoopException(message: $message, code: $code)';
  }
}

class _LoopExceptionImpl extends LoopException {
  _LoopExceptionImpl({
    required String message,
    required _id7kzu74.LoopErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [LoopException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoopException copyWith({
    String? message,
    _id7kzu74.LoopErrorCode? code,
  }) {
    return LoopException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
