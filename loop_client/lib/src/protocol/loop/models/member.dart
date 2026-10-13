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

abstract class Member
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Member._({
    this.id,
    required this.displayName,
    bool? isBot,
    DateTime? createdAt,
  }) : isBot = isBot ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Member({
    int? id,
    required String displayName,
    bool? isBot,
    DateTime? createdAt,
  }) = _MemberImpl;

  factory Member.fromJson(Map<String, dynamic> jsonSerialization) {
    return Member(
      id: jsonSerialization['id'] as int?,
      displayName: jsonSerialization['displayName'] as String,
      isBot: jsonSerialization['isBot'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isBot']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String displayName;

  bool isBot;

  DateTime createdAt;

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Member copyWith({
    int? id,
    String? displayName,
    bool? isBot,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Member',
      if (id != null) 'id': id,
      'displayName': displayName,
      'isBot': isBot,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Member',
      if (id != null) 'id': id,
      'displayName': displayName,
      'isBot': isBot,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberImpl extends Member {
  _MemberImpl({
    int? id,
    required String displayName,
    bool? isBot,
    DateTime? createdAt,
  }) : super._(
         id: id,
         displayName: displayName,
         isBot: isBot,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Member copyWith({
    Object? id = _Undefined,
    String? displayName,
    bool? isBot,
    DateTime? createdAt,
  }) {
    return Member(
      id: id is int? ? id : this.id,
      displayName: displayName ?? this.displayName,
      isBot: isBot ?? this.isBot,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
