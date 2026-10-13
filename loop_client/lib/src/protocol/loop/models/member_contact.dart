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

abstract class MemberContact
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemberContact._({
    this.phone,
    this.email,
  });

  factory MemberContact({
    String? phone,
    String? email,
  }) = _MemberContactImpl;

  factory MemberContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberContact(
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
    );
  }

  String? phone;

  String? email;

  /// Returns a shallow copy of this [MemberContact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemberContact copyWith({
    String? phone,
    String? email,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberContact',
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberContact',
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberContactImpl extends MemberContact {
  _MemberContactImpl({
    String? phone,
    String? email,
  }) : super._(
         phone: phone,
         email: email,
       );

  /// Returns a shallow copy of this [MemberContact]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemberContact copyWith({
    Object? phone = _Undefined,
    Object? email = _Undefined,
  }) {
    return MemberContact(
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
    );
  }
}
