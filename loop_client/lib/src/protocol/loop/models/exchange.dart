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

/// A pool in which swaps are legal: the same cadre, post and grade.
abstract class Exchange
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Exchange._({
    this.id,
    required this.slug,
    required this.name,
    required this.cadre,
    required this.scope,
    this.state,
    required this.description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) : maxLoopSize = maxLoopSize ?? 4,
       acceptWindowMinutes = acceptWindowMinutes ?? 2880,
       isSandbox = isSandbox ?? false,
       isSimulated = isSimulated ?? false;

  factory Exchange({
    int? id,
    required String slug,
    required String name,
    required String cadre,
    required String scope,
    String? state,
    required String description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) = _ExchangeImpl;

  factory Exchange.fromJson(Map<String, dynamic> jsonSerialization) {
    return Exchange(
      id: jsonSerialization['id'] as int?,
      slug: jsonSerialization['slug'] as String,
      name: jsonSerialization['name'] as String,
      cadre: jsonSerialization['cadre'] as String,
      scope: jsonSerialization['scope'] as String,
      state: jsonSerialization['state'] as String?,
      description: jsonSerialization['description'] as String,
      maxLoopSize: jsonSerialization['maxLoopSize'] as int?,
      acceptWindowMinutes: jsonSerialization['acceptWindowMinutes'] as int?,
      isSandbox: jsonSerialization['isSandbox'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSandbox']),
      isSimulated: jsonSerialization['isSimulated'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSimulated']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String slug;

  String name;

  /// The post people in this exchange hold, e.g. "Primary Teacher".
  String cadre;

  /// Human readable scope, e.g. "Maharashtra" or "All India".
  String scope;

  /// When set, postings and wishes must be in this state.
  String? state;

  String description;

  int maxLoopSize;

  int acceptWindowMinutes;

  /// Open playground whose simulated members answer within seconds.
  bool isSandbox;

  /// Members are simulated (demo data), not real people.
  bool isSimulated;

  /// Returns a shallow copy of this [Exchange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Exchange copyWith({
    int? id,
    String? slug,
    String? name,
    String? cadre,
    String? scope,
    String? state,
    String? description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Exchange',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'cadre': cadre,
      'scope': scope,
      if (state != null) 'state': state,
      'description': description,
      'maxLoopSize': maxLoopSize,
      'acceptWindowMinutes': acceptWindowMinutes,
      'isSandbox': isSandbox,
      'isSimulated': isSimulated,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Exchange',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'cadre': cadre,
      'scope': scope,
      if (state != null) 'state': state,
      'description': description,
      'maxLoopSize': maxLoopSize,
      'acceptWindowMinutes': acceptWindowMinutes,
      'isSandbox': isSandbox,
      'isSimulated': isSimulated,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExchangeImpl extends Exchange {
  _ExchangeImpl({
    int? id,
    required String slug,
    required String name,
    required String cadre,
    required String scope,
    String? state,
    required String description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) : super._(
         id: id,
         slug: slug,
         name: name,
         cadre: cadre,
         scope: scope,
         state: state,
         description: description,
         maxLoopSize: maxLoopSize,
         acceptWindowMinutes: acceptWindowMinutes,
         isSandbox: isSandbox,
         isSimulated: isSimulated,
       );

  /// Returns a shallow copy of this [Exchange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Exchange copyWith({
    Object? id = _Undefined,
    String? slug,
    String? name,
    String? cadre,
    String? scope,
    Object? state = _Undefined,
    String? description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) {
    return Exchange(
      id: id is int? ? id : this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      cadre: cadre ?? this.cadre,
      scope: scope ?? this.scope,
      state: state is String? ? state : this.state,
      description: description ?? this.description,
      maxLoopSize: maxLoopSize ?? this.maxLoopSize,
      acceptWindowMinutes: acceptWindowMinutes ?? this.acceptWindowMinutes,
      isSandbox: isSandbox ?? this.isSandbox,
      isSimulated: isSimulated ?? this.isSimulated,
    );
  }
}
