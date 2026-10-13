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
import '../../loop/models/exchange.dart' as _if8hwbkr;
import '../../loop/models/listing.dart' as _i3oqy8k6;
import '../../loop/models/wish.dart' as _ibpk09v2;

/// A member's listing, as shown on their dashboard.
abstract class MyListing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MyListing._({
    required this.listing,
    required this.exchange,
    required this.wishes,
    this.activeLoopId,
    required this.wantMyPlace,
    required this.atMyWishes,
  });

  factory MyListing({
    required _i3oqy8k6.Listing listing,
    required _if8hwbkr.Exchange exchange,
    required List<_ibpk09v2.Wish> wishes,
    int? activeLoopId,
    required int wantMyPlace,
    required int atMyWishes,
  }) = _MyListingImpl;

  factory MyListing.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyListing(
      listing: _iunif0pu.Protocol().deserialize<_i3oqy8k6.Listing>(
        jsonSerialization['listing'],
      ),
      exchange: _iunif0pu.Protocol().deserialize<_if8hwbkr.Exchange>(
        jsonSerialization['exchange'],
      ),
      wishes: _iunif0pu.Protocol().deserialize<List<_ibpk09v2.Wish>>(
        jsonSerialization['wishes'],
      ),
      activeLoopId: jsonSerialization['activeLoopId'] as int?,
      wantMyPlace: jsonSerialization['wantMyPlace'] as int,
      atMyWishes: jsonSerialization['atMyWishes'] as int,
    );
  }

  _i3oqy8k6.Listing listing;

  _if8hwbkr.Exchange exchange;

  List<_ibpk09v2.Wish> wishes;

  /// Live loop this listing is reserved in, if any.
  int? activeLoopId;

  /// Members in this exchange whose wishes cover my posting.
  int wantMyPlace;

  /// Members in this exchange posted where I want to go.
  int atMyWishes;

  /// Returns a shallow copy of this [MyListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MyListing copyWith({
    _i3oqy8k6.Listing? listing,
    _if8hwbkr.Exchange? exchange,
    List<_ibpk09v2.Wish>? wishes,
    int? activeLoopId,
    int? wantMyPlace,
    int? atMyWishes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyListing',
      'listing': listing.toJson(),
      'exchange': exchange.toJson(),
      'wishes': wishes.toJson(valueToJson: (v) => v.toJson()),
      if (activeLoopId != null) 'activeLoopId': activeLoopId,
      'wantMyPlace': wantMyPlace,
      'atMyWishes': atMyWishes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyListing',
      'listing': listing.toJsonForProtocol(),
      'exchange': exchange.toJsonForProtocol(),
      'wishes': wishes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (activeLoopId != null) 'activeLoopId': activeLoopId,
      'wantMyPlace': wantMyPlace,
      'atMyWishes': atMyWishes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MyListingImpl extends MyListing {
  _MyListingImpl({
    required _i3oqy8k6.Listing listing,
    required _if8hwbkr.Exchange exchange,
    required List<_ibpk09v2.Wish> wishes,
    int? activeLoopId,
    required int wantMyPlace,
    required int atMyWishes,
  }) : super._(
         listing: listing,
         exchange: exchange,
         wishes: wishes,
         activeLoopId: activeLoopId,
         wantMyPlace: wantMyPlace,
         atMyWishes: atMyWishes,
       );

  /// Returns a shallow copy of this [MyListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MyListing copyWith({
    _i3oqy8k6.Listing? listing,
    _if8hwbkr.Exchange? exchange,
    List<_ibpk09v2.Wish>? wishes,
    Object? activeLoopId = _Undefined,
    int? wantMyPlace,
    int? atMyWishes,
  }) {
    return MyListing(
      listing: listing ?? this.listing.copyWith(),
      exchange: exchange ?? this.exchange.copyWith(),
      wishes: wishes ?? this.wishes.map((e0) => e0.copyWith()).toList(),
      activeLoopId: activeLoopId is int? ? activeLoopId : this.activeLoopId,
      wantMyPlace: wantMyPlace ?? this.wantMyPlace,
      atMyWishes: atMyWishes ?? this.atMyWishes,
    );
  }
}
