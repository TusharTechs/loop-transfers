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
import 'package:loop_server/src/generated/protocol.dart' as _iq3hot10;
import 'package:serverpod/serverpod.dart' as _is;
import '../../loop/models/place.dart' as _it93en99;
import '../../loop/models/seat_response.dart' as _ih6s460s;

/// A seat in a loop, as one member sees it. Identity fields are filled only
/// once every seat has accepted.
abstract class SeatView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SeatView._({
    required this.position,
    required this.label,
    required this.fromPlace,
    required this.toPlace,
    required this.isMe,
    required this.response,
    required this.wishRank,
    required this.km,
    required this.yearsInPost,
    this.name,
    this.phone,
    this.email,
    this.postTitle,
  });

  factory SeatView({
    required int position,
    required String label,
    required _it93en99.Place fromPlace,
    required _it93en99.Place toPlace,
    required bool isMe,
    required _ih6s460s.SeatResponse response,
    required int wishRank,
    required double km,
    required int yearsInPost,
    String? name,
    String? phone,
    String? email,
    String? postTitle,
  }) = _SeatViewImpl;

  factory SeatView.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeatView(
      position: jsonSerialization['position'] as int,
      label: jsonSerialization['label'] as String,
      fromPlace: _iq3hot10.Protocol().deserialize<_it93en99.Place>(
        jsonSerialization['fromPlace'],
      ),
      toPlace: _iq3hot10.Protocol().deserialize<_it93en99.Place>(
        jsonSerialization['toPlace'],
      ),
      isMe: _is.BoolJsonExtension.fromJson(jsonSerialization['isMe']),
      response: _ih6s460s.SeatResponse.fromJson(
        (jsonSerialization['response'] as String),
      ),
      wishRank: jsonSerialization['wishRank'] as int,
      km: (jsonSerialization['km'] as num).toDouble(),
      yearsInPost: jsonSerialization['yearsInPost'] as int,
      name: jsonSerialization['name'] as String?,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      postTitle: jsonSerialization['postTitle'] as String?,
    );
  }

  int position;

  /// Anonymous label, e.g. "Primary Teacher · Nagpur".
  String label;

  _it93en99.Place fromPlace;

  _it93en99.Place toPlace;

  bool isMe;

  _ih6s460s.SeatResponse response;

  int wishRank;

  double km;

  int yearsInPost;

  String? name;

  String? phone;

  String? email;

  String? postTitle;

  /// Returns a shallow copy of this [SeatView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SeatView copyWith({
    int? position,
    String? label,
    _it93en99.Place? fromPlace,
    _it93en99.Place? toPlace,
    bool? isMe,
    _ih6s460s.SeatResponse? response,
    int? wishRank,
    double? km,
    int? yearsInPost,
    String? name,
    String? phone,
    String? email,
    String? postTitle,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeatView',
      'position': position,
      'label': label,
      'fromPlace': fromPlace.toJson(),
      'toPlace': toPlace.toJson(),
      'isMe': isMe,
      'response': response.toJson(),
      'wishRank': wishRank,
      'km': km,
      'yearsInPost': yearsInPost,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (postTitle != null) 'postTitle': postTitle,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeatView',
      'position': position,
      'label': label,
      'fromPlace': fromPlace.toJsonForProtocol(),
      'toPlace': toPlace.toJsonForProtocol(),
      'isMe': isMe,
      'response': response.toJson(),
      'wishRank': wishRank,
      'km': km,
      'yearsInPost': yearsInPost,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (postTitle != null) 'postTitle': postTitle,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeatViewImpl extends SeatView {
  _SeatViewImpl({
    required int position,
    required String label,
    required _it93en99.Place fromPlace,
    required _it93en99.Place toPlace,
    required bool isMe,
    required _ih6s460s.SeatResponse response,
    required int wishRank,
    required double km,
    required int yearsInPost,
    String? name,
    String? phone,
    String? email,
    String? postTitle,
  }) : super._(
         position: position,
         label: label,
         fromPlace: fromPlace,
         toPlace: toPlace,
         isMe: isMe,
         response: response,
         wishRank: wishRank,
         km: km,
         yearsInPost: yearsInPost,
         name: name,
         phone: phone,
         email: email,
         postTitle: postTitle,
       );

  /// Returns a shallow copy of this [SeatView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SeatView copyWith({
    int? position,
    String? label,
    _it93en99.Place? fromPlace,
    _it93en99.Place? toPlace,
    bool? isMe,
    _ih6s460s.SeatResponse? response,
    int? wishRank,
    double? km,
    int? yearsInPost,
    Object? name = _Undefined,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? postTitle = _Undefined,
  }) {
    return SeatView(
      position: position ?? this.position,
      label: label ?? this.label,
      fromPlace: fromPlace ?? this.fromPlace.copyWith(),
      toPlace: toPlace ?? this.toPlace.copyWith(),
      isMe: isMe ?? this.isMe,
      response: response ?? this.response,
      wishRank: wishRank ?? this.wishRank,
      km: km ?? this.km,
      yearsInPost: yearsInPost ?? this.yearsInPost,
      name: name is String? ? name : this.name,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      postTitle: postTitle is String? ? postTitle : this.postTitle,
    );
  }
}
