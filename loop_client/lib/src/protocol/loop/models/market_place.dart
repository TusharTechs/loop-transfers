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

abstract class MarketPlace
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MarketPlace._({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.postedHere,
  });

  factory MarketPlace({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    required int postedHere,
  }) = _MarketPlaceImpl;

  factory MarketPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketPlace(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      postedHere: jsonSerialization['postedHere'] as int,
    );
  }

  int id;

  String name;

  double latitude;

  double longitude;

  int postedHere;

  /// Returns a shallow copy of this [MarketPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MarketPlace copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    int? postedHere,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MarketPlace',
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'postedHere': postedHere,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MarketPlace',
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'postedHere': postedHere,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MarketPlaceImpl extends MarketPlace {
  _MarketPlaceImpl({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    required int postedHere,
  }) : super._(
         id: id,
         name: name,
         latitude: latitude,
         longitude: longitude,
         postedHere: postedHere,
       );

  /// Returns a shallow copy of this [MarketPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MarketPlace copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    int? postedHere,
  }) {
    return MarketPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postedHere: postedHere ?? this.postedHere,
    );
  }
}
