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
import '../../loop/models/place.dart' as _it93en99;

/// "Exactly this district" (radiusKm = 0) or "anywhere within radiusKm of it".
abstract class Wish
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Wish._({
    this.id,
    required this.listingId,
    required this.placeId,
    this.place,
    int? radiusKm,
    required this.rank,
  }) : radiusKm = radiusKm ?? 0;

  factory Wish({
    int? id,
    required int listingId,
    required int placeId,
    _it93en99.Place? place,
    int? radiusKm,
    required int rank,
  }) = _WishImpl;

  factory Wish.fromJson(Map<String, dynamic> jsonSerialization) {
    return Wish(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      placeId: jsonSerialization['placeId'] as int,
      place: jsonSerialization['place'] == null
          ? null
          : _iunif0pu.Protocol().deserialize<_it93en99.Place>(
              jsonSerialization['place'],
            ),
      radiusKm: jsonSerialization['radiusKm'] as int?,
      rank: jsonSerialization['rank'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int listingId;

  int placeId;

  _it93en99.Place? place;

  int radiusKm;

  /// 0 = first choice.
  int rank;

  /// Returns a shallow copy of this [Wish]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Wish copyWith({
    int? id,
    int? listingId,
    int? placeId,
    _it93en99.Place? place,
    int? radiusKm,
    int? rank,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Wish',
      if (id != null) 'id': id,
      'listingId': listingId,
      'placeId': placeId,
      if (place != null) 'place': place?.toJson(),
      'radiusKm': radiusKm,
      'rank': rank,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Wish',
      if (id != null) 'id': id,
      'listingId': listingId,
      'placeId': placeId,
      if (place != null) 'place': place?.toJsonForProtocol(),
      'radiusKm': radiusKm,
      'rank': rank,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WishImpl extends Wish {
  _WishImpl({
    int? id,
    required int listingId,
    required int placeId,
    _it93en99.Place? place,
    int? radiusKm,
    required int rank,
  }) : super._(
         id: id,
         listingId: listingId,
         placeId: placeId,
         place: place,
         radiusKm: radiusKm,
         rank: rank,
       );

  /// Returns a shallow copy of this [Wish]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Wish copyWith({
    Object? id = _Undefined,
    int? listingId,
    int? placeId,
    Object? place = _Undefined,
    int? radiusKm,
    int? rank,
  }) {
    return Wish(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      placeId: placeId ?? this.placeId,
      place: place is _it93en99.Place? ? place : this.place?.copyWith(),
      radiusKm: radiusKm ?? this.radiusKm,
      rank: rank ?? this.rank,
    );
  }
}
