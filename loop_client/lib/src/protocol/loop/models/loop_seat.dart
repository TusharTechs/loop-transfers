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
import '../../loop/models/seat_response.dart' as _ih6s460s;

/// One member's position in a loop: they move from their posting to the
/// posting of the next seat.
abstract class LoopSeat
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LoopSeat._({
    this.id,
    required this.loopId,
    required this.listingId,
    required this.memberId,
    required this.position,
    required this.fromPlaceId,
    required this.toPlaceId,
    required this.wishRank,
    required this.km,
    _ih6s460s.SeatResponse? response,
    this.respondedAt,
  }) : response = response ?? _ih6s460s.SeatResponse.pending;

  factory LoopSeat({
    int? id,
    required int loopId,
    required int listingId,
    required int memberId,
    required int position,
    required int fromPlaceId,
    required int toPlaceId,
    required int wishRank,
    required double km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  }) = _LoopSeatImpl;

  factory LoopSeat.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopSeat(
      id: jsonSerialization['id'] as int?,
      loopId: jsonSerialization['loopId'] as int,
      listingId: jsonSerialization['listingId'] as int,
      memberId: jsonSerialization['memberId'] as int,
      position: jsonSerialization['position'] as int,
      fromPlaceId: jsonSerialization['fromPlaceId'] as int,
      toPlaceId: jsonSerialization['toPlaceId'] as int,
      wishRank: jsonSerialization['wishRank'] as int,
      km: (jsonSerialization['km'] as num).toDouble(),
      response: jsonSerialization['response'] == null
          ? null
          : _ih6s460s.SeatResponse.fromJson(
              (jsonSerialization['response'] as String),
            ),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int loopId;

  int listingId;

  int memberId;

  int position;

  int fromPlaceId;

  int toPlaceId;

  int wishRank;

  double km;

  _ih6s460s.SeatResponse response;

  DateTime? respondedAt;

  /// Returns a shallow copy of this [LoopSeat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoopSeat copyWith({
    int? id,
    int? loopId,
    int? listingId,
    int? memberId,
    int? position,
    int? fromPlaceId,
    int? toPlaceId,
    int? wishRank,
    double? km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopSeat',
      if (id != null) 'id': id,
      'loopId': loopId,
      'listingId': listingId,
      'memberId': memberId,
      'position': position,
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'wishRank': wishRank,
      'km': km,
      'response': response.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopSeat',
      if (id != null) 'id': id,
      'loopId': loopId,
      'listingId': listingId,
      'memberId': memberId,
      'position': position,
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'wishRank': wishRank,
      'km': km,
      'response': response.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoopSeatImpl extends LoopSeat {
  _LoopSeatImpl({
    int? id,
    required int loopId,
    required int listingId,
    required int memberId,
    required int position,
    required int fromPlaceId,
    required int toPlaceId,
    required int wishRank,
    required double km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  }) : super._(
         id: id,
         loopId: loopId,
         listingId: listingId,
         memberId: memberId,
         position: position,
         fromPlaceId: fromPlaceId,
         toPlaceId: toPlaceId,
         wishRank: wishRank,
         km: km,
         response: response,
         respondedAt: respondedAt,
       );

  /// Returns a shallow copy of this [LoopSeat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoopSeat copyWith({
    Object? id = _Undefined,
    int? loopId,
    int? listingId,
    int? memberId,
    int? position,
    int? fromPlaceId,
    int? toPlaceId,
    int? wishRank,
    double? km,
    _ih6s460s.SeatResponse? response,
    Object? respondedAt = _Undefined,
  }) {
    return LoopSeat(
      id: id is int? ? id : this.id,
      loopId: loopId ?? this.loopId,
      listingId: listingId ?? this.listingId,
      memberId: memberId ?? this.memberId,
      position: position ?? this.position,
      fromPlaceId: fromPlaceId ?? this.fromPlaceId,
      toPlaceId: toPlaceId ?? this.toPlaceId,
      wishRank: wishRank ?? this.wishRank,
      km: km ?? this.km,
      response: response ?? this.response,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
    );
  }
}
