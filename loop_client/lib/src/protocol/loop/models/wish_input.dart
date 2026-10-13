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

abstract class WishInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WishInput._({
    required this.placeId,
    int? radiusKm,
  }) : radiusKm = radiusKm ?? 0;

  factory WishInput({
    required int placeId,
    int? radiusKm,
  }) = _WishInputImpl;

  factory WishInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return WishInput(
      placeId: jsonSerialization['placeId'] as int,
      radiusKm: jsonSerialization['radiusKm'] as int?,
    );
  }

  int placeId;

  int radiusKm;

  /// Returns a shallow copy of this [WishInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WishInput copyWith({
    int? placeId,
    int? radiusKm,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WishInput',
      'placeId': placeId,
      'radiusKm': radiusKm,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WishInput',
      'placeId': placeId,
      'radiusKm': radiusKm,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _WishInputImpl extends WishInput {
  _WishInputImpl({
    required int placeId,
    int? radiusKm,
  }) : super._(
         placeId: placeId,
         radiusKm: radiusKm,
       );

  /// Returns a shallow copy of this [WishInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WishInput copyWith({
    int? placeId,
    int? radiusKm,
  }) {
    return WishInput(
      placeId: placeId ?? this.placeId,
      radiusKm: radiusKm ?? this.radiusKm,
    );
  }
}
