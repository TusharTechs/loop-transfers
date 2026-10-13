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
import '../../loop/models/listing_status.dart' as _i1kb3nit;
import '../../loop/models/place.dart' as _it93en99;

/// One member's request to move, within one exchange.
abstract class Listing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Listing._({
    this.id,
    required this.memberId,
    required this.exchangeId,
    required this.currentPlaceId,
    this.currentPlace,
    required this.postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : yearsInPost = yearsInPost ?? 0,
       status = status ?? _i1kb3nit.ListingStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Listing({
    int? id,
    required int memberId,
    required int exchangeId,
    required int currentPlaceId,
    _it93en99.Place? currentPlace,
    required String postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ListingImpl;

  factory Listing.fromJson(Map<String, dynamic> jsonSerialization) {
    return Listing(
      id: jsonSerialization['id'] as int?,
      memberId: jsonSerialization['memberId'] as int,
      exchangeId: jsonSerialization['exchangeId'] as int,
      currentPlaceId: jsonSerialization['currentPlaceId'] as int,
      currentPlace: jsonSerialization['currentPlace'] == null
          ? null
          : _iunif0pu.Protocol().deserialize<_it93en99.Place>(
              jsonSerialization['currentPlace'],
            ),
      postTitle: jsonSerialization['postTitle'] as String,
      yearsInPost: jsonSerialization['yearsInPost'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i1kb3nit.ListingStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int memberId;

  int exchangeId;

  int currentPlaceId;

  _it93en99.Place? currentPlace;

  /// e.g. "Primary Teacher, ZP School Kharadi".
  String postTitle;

  int yearsInPost;

  _i1kb3nit.ListingStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Listing copyWith({
    int? id,
    int? memberId,
    int? exchangeId,
    int? currentPlaceId,
    _it93en99.Place? currentPlace,
    String? postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Listing',
      if (id != null) 'id': id,
      'memberId': memberId,
      'exchangeId': exchangeId,
      'currentPlaceId': currentPlaceId,
      if (currentPlace != null) 'currentPlace': currentPlace?.toJson(),
      'postTitle': postTitle,
      'yearsInPost': yearsInPost,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Listing',
      if (id != null) 'id': id,
      'memberId': memberId,
      'exchangeId': exchangeId,
      'currentPlaceId': currentPlaceId,
      if (currentPlace != null)
        'currentPlace': currentPlace?.toJsonForProtocol(),
      'postTitle': postTitle,
      'yearsInPost': yearsInPost,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListingImpl extends Listing {
  _ListingImpl({
    int? id,
    required int memberId,
    required int exchangeId,
    required int currentPlaceId,
    _it93en99.Place? currentPlace,
    required String postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         memberId: memberId,
         exchangeId: exchangeId,
         currentPlaceId: currentPlaceId,
         currentPlace: currentPlace,
         postTitle: postTitle,
         yearsInPost: yearsInPost,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Listing copyWith({
    Object? id = _Undefined,
    int? memberId,
    int? exchangeId,
    int? currentPlaceId,
    Object? currentPlace = _Undefined,
    String? postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Listing(
      id: id is int? ? id : this.id,
      memberId: memberId ?? this.memberId,
      exchangeId: exchangeId ?? this.exchangeId,
      currentPlaceId: currentPlaceId ?? this.currentPlaceId,
      currentPlace: currentPlace is _it93en99.Place?
          ? currentPlace
          : this.currentPlace?.copyWith(),
      postTitle: postTitle ?? this.postTitle,
      yearsInPost: yearsInPost ?? this.yearsInPost,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
