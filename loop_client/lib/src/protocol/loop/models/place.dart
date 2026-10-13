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

/// A district (or city) where people are posted.
abstract class Place
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Place._({
    this.id,
    required this.code,
    required this.name,
    required this.state,
    required this.point,
    int? population,
  }) : population = population ?? 0;

  factory Place({
    int? id,
    required String code,
    required String name,
    required String state,
    required _isc.GeographyPoint point,
    int? population,
  }) = _PlaceImpl;

  factory Place.fromJson(Map<String, dynamic> jsonSerialization) {
    return Place(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      state: jsonSerialization['state'] as String,
      point: _isc.GeographyPointJsonExtension.fromJson(
        jsonSerialization['point'],
      ),
      population: jsonSerialization['population'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Stable external id (GeoNames based).
  String code;

  String name;

  String state;

  _isc.GeographyPoint point;

  int population;

  /// Returns a shallow copy of this [Place]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Place copyWith({
    int? id,
    String? code,
    String? name,
    String? state,
    _isc.GeographyPoint? point,
    int? population,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Place',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'state': state,
      'point': point.toJson(),
      'population': population,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Place',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'state': state,
      'point': point.toJson(),
      'population': population,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaceImpl extends Place {
  _PlaceImpl({
    int? id,
    required String code,
    required String name,
    required String state,
    required _isc.GeographyPoint point,
    int? population,
  }) : super._(
         id: id,
         code: code,
         name: name,
         state: state,
         point: point,
         population: population,
       );

  /// Returns a shallow copy of this [Place]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Place copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    String? state,
    _isc.GeographyPoint? point,
    int? population,
  }) {
    return Place(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      state: state ?? this.state,
      point: point ?? this.point,
      population: population ?? this.population,
    );
  }
}
