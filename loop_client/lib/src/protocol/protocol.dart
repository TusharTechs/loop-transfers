/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:loop_client/src/protocol/loop/models/exchange_summary.dart'
    as _ifa6d7ob;
import 'package:loop_client/src/protocol/loop/models/loop_view.dart'
    as _ipmn2hyv;
import 'package:loop_client/src/protocol/loop/models/my_listing.dart'
    as _iaymrcjt;
import 'package:loop_client/src/protocol/loop/models/place.dart' as _ipz77xq0;
import 'package:loop_client/src/protocol/loop/models/wish_input.dart'
    as _iyoe216s;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'loop/models/exchange.dart' as _iw5rmx8t;
import 'loop/models/exchange_summary.dart' as _ic8hgcmq;
import 'loop/models/listing.dart' as _i2ct69t9;
import 'loop/models/listing_status.dart' as _i524jma0;
import 'loop/models/loop_error_code.dart' as _iqsizhe6;
import 'loop/models/loop_event.dart' as _icdgd785;
import 'loop/models/loop_event_kind.dart' as _iklfu2yy;
import 'loop/models/loop_exception.dart' as _i47sf5r5;
import 'loop/models/loop_seat.dart' as _ih9o9q84;
import 'loop/models/loop_status.dart' as _ix0pjlyl;
import 'loop/models/loop_trace.dart' as _i0go6mh6;
import 'loop/models/loop_view.dart' as _inakt9ip;
import 'loop/models/market_event.dart' as _i7leuqa4;
import 'loop/models/market_event_kind.dart' as _iao4iwg6;
import 'loop/models/market_flow.dart' as _iyrvngek;
import 'loop/models/market_place.dart' as _ipuaqtg1;
import 'loop/models/market_snapshot.dart' as _ioomabe5;
import 'loop/models/member.dart' as _iqcjyqz4;
import 'loop/models/member_contact.dart' as _i1bo32kc;
import 'loop/models/member_update.dart' as _i8h1xlwl;
import 'loop/models/my_listing.dart' as _ik5nzdng;
import 'loop/models/place.dart' as _ifutsqcw;
import 'loop/models/seat_response.dart' as _iyc6u9y6;
import 'loop/models/seat_view.dart' as _ilqzmqki;
import 'loop/models/solver_run.dart' as _i797ae6t;
import 'loop/models/swap_loop.dart' as _ii5itptg;
import 'loop/models/wish.dart' as _ip90o58a;
import 'loop/models/wish_input.dart' as _il23c4a1;
export 'loop/models/exchange.dart';
export 'loop/models/exchange_summary.dart';
export 'loop/models/listing.dart';
export 'loop/models/listing_status.dart';
export 'loop/models/loop_error_code.dart';
export 'loop/models/loop_event.dart';
export 'loop/models/loop_event_kind.dart';
export 'loop/models/loop_exception.dart';
export 'loop/models/loop_seat.dart';
export 'loop/models/loop_status.dart';
export 'loop/models/loop_trace.dart';
export 'loop/models/loop_view.dart';
export 'loop/models/market_event.dart';
export 'loop/models/market_event_kind.dart';
export 'loop/models/market_flow.dart';
export 'loop/models/market_place.dart';
export 'loop/models/market_snapshot.dart';
export 'loop/models/member.dart';
export 'loop/models/member_contact.dart';
export 'loop/models/member_update.dart';
export 'loop/models/my_listing.dart';
export 'loop/models/place.dart';
export 'loop/models/seat_response.dart';
export 'loop/models/seat_view.dart';
export 'loop/models/solver_run.dart';
export 'loop/models/swap_loop.dart';
export 'loop/models/wish.dart';
export 'loop/models/wish_input.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iw5rmx8t.Exchange) {
      return _iw5rmx8t.Exchange.fromJson(data) as T;
    }
    if (t == _ic8hgcmq.ExchangeSummary) {
      return _ic8hgcmq.ExchangeSummary.fromJson(data) as T;
    }
    if (t == _i2ct69t9.Listing) {
      return _i2ct69t9.Listing.fromJson(data) as T;
    }
    if (t == _i524jma0.ListingStatus) {
      return _i524jma0.ListingStatus.fromJson(data) as T;
    }
    if (t == _iqsizhe6.LoopErrorCode) {
      return _iqsizhe6.LoopErrorCode.fromJson(data) as T;
    }
    if (t == _icdgd785.LoopEvent) {
      return _icdgd785.LoopEvent.fromJson(data) as T;
    }
    if (t == _iklfu2yy.LoopEventKind) {
      return _iklfu2yy.LoopEventKind.fromJson(data) as T;
    }
    if (t == _i47sf5r5.LoopException) {
      return _i47sf5r5.LoopException.fromJson(data) as T;
    }
    if (t == _ih9o9q84.LoopSeat) {
      return _ih9o9q84.LoopSeat.fromJson(data) as T;
    }
    if (t == _ix0pjlyl.LoopStatus) {
      return _ix0pjlyl.LoopStatus.fromJson(data) as T;
    }
    if (t == _i0go6mh6.LoopTrace) {
      return _i0go6mh6.LoopTrace.fromJson(data) as T;
    }
    if (t == _inakt9ip.LoopView) {
      return _inakt9ip.LoopView.fromJson(data) as T;
    }
    if (t == _i7leuqa4.MarketEvent) {
      return _i7leuqa4.MarketEvent.fromJson(data) as T;
    }
    if (t == _iao4iwg6.MarketEventKind) {
      return _iao4iwg6.MarketEventKind.fromJson(data) as T;
    }
    if (t == _iyrvngek.MarketFlow) {
      return _iyrvngek.MarketFlow.fromJson(data) as T;
    }
    if (t == _ipuaqtg1.MarketPlace) {
      return _ipuaqtg1.MarketPlace.fromJson(data) as T;
    }
    if (t == _ioomabe5.MarketSnapshot) {
      return _ioomabe5.MarketSnapshot.fromJson(data) as T;
    }
    if (t == _iqcjyqz4.Member) {
      return _iqcjyqz4.Member.fromJson(data) as T;
    }
    if (t == _i1bo32kc.MemberContact) {
      return _i1bo32kc.MemberContact.fromJson(data) as T;
    }
    if (t == _i8h1xlwl.MemberUpdate) {
      return _i8h1xlwl.MemberUpdate.fromJson(data) as T;
    }
    if (t == _ik5nzdng.MyListing) {
      return _ik5nzdng.MyListing.fromJson(data) as T;
    }
    if (t == _ifutsqcw.Place) {
      return _ifutsqcw.Place.fromJson(data) as T;
    }
    if (t == _iyc6u9y6.SeatResponse) {
      return _iyc6u9y6.SeatResponse.fromJson(data) as T;
    }
    if (t == _ilqzmqki.SeatView) {
      return _ilqzmqki.SeatView.fromJson(data) as T;
    }
    if (t == _i797ae6t.SolverRun) {
      return _i797ae6t.SolverRun.fromJson(data) as T;
    }
    if (t == _ii5itptg.SwapLoop) {
      return _ii5itptg.SwapLoop.fromJson(data) as T;
    }
    if (t == _ip90o58a.Wish) {
      return _ip90o58a.Wish.fromJson(data) as T;
    }
    if (t == _il23c4a1.WishInput) {
      return _il23c4a1.WishInput.fromJson(data) as T;
    }
    if (t == _isc.getType<_iw5rmx8t.Exchange?>()) {
      return (data != null ? _iw5rmx8t.Exchange.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ic8hgcmq.ExchangeSummary?>()) {
      return (data != null ? _ic8hgcmq.ExchangeSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2ct69t9.Listing?>()) {
      return (data != null ? _i2ct69t9.Listing.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i524jma0.ListingStatus?>()) {
      return (data != null ? _i524jma0.ListingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqsizhe6.LoopErrorCode?>()) {
      return (data != null ? _iqsizhe6.LoopErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icdgd785.LoopEvent?>()) {
      return (data != null ? _icdgd785.LoopEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iklfu2yy.LoopEventKind?>()) {
      return (data != null ? _iklfu2yy.LoopEventKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i47sf5r5.LoopException?>()) {
      return (data != null ? _i47sf5r5.LoopException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ih9o9q84.LoopSeat?>()) {
      return (data != null ? _ih9o9q84.LoopSeat.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix0pjlyl.LoopStatus?>()) {
      return (data != null ? _ix0pjlyl.LoopStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0go6mh6.LoopTrace?>()) {
      return (data != null ? _i0go6mh6.LoopTrace.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inakt9ip.LoopView?>()) {
      return (data != null ? _inakt9ip.LoopView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7leuqa4.MarketEvent?>()) {
      return (data != null ? _i7leuqa4.MarketEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iao4iwg6.MarketEventKind?>()) {
      return (data != null ? _iao4iwg6.MarketEventKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyrvngek.MarketFlow?>()) {
      return (data != null ? _iyrvngek.MarketFlow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipuaqtg1.MarketPlace?>()) {
      return (data != null ? _ipuaqtg1.MarketPlace.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ioomabe5.MarketSnapshot?>()) {
      return (data != null ? _ioomabe5.MarketSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqcjyqz4.Member?>()) {
      return (data != null ? _iqcjyqz4.Member.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1bo32kc.MemberContact?>()) {
      return (data != null ? _i1bo32kc.MemberContact.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8h1xlwl.MemberUpdate?>()) {
      return (data != null ? _i8h1xlwl.MemberUpdate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik5nzdng.MyListing?>()) {
      return (data != null ? _ik5nzdng.MyListing.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifutsqcw.Place?>()) {
      return (data != null ? _ifutsqcw.Place.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyc6u9y6.SeatResponse?>()) {
      return (data != null ? _iyc6u9y6.SeatResponse.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilqzmqki.SeatView?>()) {
      return (data != null ? _ilqzmqki.SeatView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i797ae6t.SolverRun?>()) {
      return (data != null ? _i797ae6t.SolverRun.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ii5itptg.SwapLoop?>()) {
      return (data != null ? _ii5itptg.SwapLoop.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ip90o58a.Wish?>()) {
      return (data != null ? _ip90o58a.Wish.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_il23c4a1.WishInput?>()) {
      return (data != null ? _il23c4a1.WishInput.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ilqzmqki.SeatView>) {
      return (data as List)
              .map((e) => deserialize<_ilqzmqki.SeatView>(e))
              .toList()
          as T;
    }
    if (t == List<_icdgd785.LoopEvent>) {
      return (data as List)
              .map((e) => deserialize<_icdgd785.LoopEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ipuaqtg1.MarketPlace>) {
      return (data as List)
              .map((e) => deserialize<_ipuaqtg1.MarketPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_iyrvngek.MarketFlow>) {
      return (data as List)
              .map((e) => deserialize<_iyrvngek.MarketFlow>(e))
              .toList()
          as T;
    }
    if (t == List<_i0go6mh6.LoopTrace>) {
      return (data as List)
              .map((e) => deserialize<_i0go6mh6.LoopTrace>(e))
              .toList()
          as T;
    }
    if (t == List<_ip90o58a.Wish>) {
      return (data as List).map((e) => deserialize<_ip90o58a.Wish>(e)).toList()
          as T;
    }
    if (t == List<_iaymrcjt.MyListing>) {
      return (data as List)
              .map((e) => deserialize<_iaymrcjt.MyListing>(e))
              .toList()
          as T;
    }
    if (t == List<_iyoe216s.WishInput>) {
      return (data as List)
              .map((e) => deserialize<_iyoe216s.WishInput>(e))
              .toList()
          as T;
    }
    if (t == List<_ipmn2hyv.LoopView>) {
      return (data as List)
              .map((e) => deserialize<_ipmn2hyv.LoopView>(e))
              .toList()
          as T;
    }
    if (t == List<_ipz77xq0.Place>) {
      return (data as List).map((e) => deserialize<_ipz77xq0.Place>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ifa6d7ob.ExchangeSummary>) {
      return (data as List)
              .map((e) => deserialize<_ifa6d7ob.ExchangeSummary>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iw5rmx8t.Exchange => 'Exchange',
      _ic8hgcmq.ExchangeSummary => 'ExchangeSummary',
      _i2ct69t9.Listing => 'Listing',
      _i524jma0.ListingStatus => 'ListingStatus',
      _iqsizhe6.LoopErrorCode => 'LoopErrorCode',
      _icdgd785.LoopEvent => 'LoopEvent',
      _iklfu2yy.LoopEventKind => 'LoopEventKind',
      _i47sf5r5.LoopException => 'LoopException',
      _ih9o9q84.LoopSeat => 'LoopSeat',
      _ix0pjlyl.LoopStatus => 'LoopStatus',
      _i0go6mh6.LoopTrace => 'LoopTrace',
      _inakt9ip.LoopView => 'LoopView',
      _i7leuqa4.MarketEvent => 'MarketEvent',
      _iao4iwg6.MarketEventKind => 'MarketEventKind',
      _iyrvngek.MarketFlow => 'MarketFlow',
      _ipuaqtg1.MarketPlace => 'MarketPlace',
      _ioomabe5.MarketSnapshot => 'MarketSnapshot',
      _iqcjyqz4.Member => 'Member',
      _i1bo32kc.MemberContact => 'MemberContact',
      _i8h1xlwl.MemberUpdate => 'MemberUpdate',
      _ik5nzdng.MyListing => 'MyListing',
      _ifutsqcw.Place => 'Place',
      _iyc6u9y6.SeatResponse => 'SeatResponse',
      _ilqzmqki.SeatView => 'SeatView',
      _i797ae6t.SolverRun => 'SolverRun',
      _ii5itptg.SwapLoop => 'SwapLoop',
      _ip90o58a.Wish => 'Wish',
      _il23c4a1.WishInput => 'WishInput',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('loop.', '');
    }

    switch (data) {
      case _iw5rmx8t.Exchange():
        return 'Exchange';
      case _ic8hgcmq.ExchangeSummary():
        return 'ExchangeSummary';
      case _i2ct69t9.Listing():
        return 'Listing';
      case _i524jma0.ListingStatus():
        return 'ListingStatus';
      case _iqsizhe6.LoopErrorCode():
        return 'LoopErrorCode';
      case _icdgd785.LoopEvent():
        return 'LoopEvent';
      case _iklfu2yy.LoopEventKind():
        return 'LoopEventKind';
      case _i47sf5r5.LoopException():
        return 'LoopException';
      case _ih9o9q84.LoopSeat():
        return 'LoopSeat';
      case _ix0pjlyl.LoopStatus():
        return 'LoopStatus';
      case _i0go6mh6.LoopTrace():
        return 'LoopTrace';
      case _inakt9ip.LoopView():
        return 'LoopView';
      case _i7leuqa4.MarketEvent():
        return 'MarketEvent';
      case _iao4iwg6.MarketEventKind():
        return 'MarketEventKind';
      case _iyrvngek.MarketFlow():
        return 'MarketFlow';
      case _ipuaqtg1.MarketPlace():
        return 'MarketPlace';
      case _ioomabe5.MarketSnapshot():
        return 'MarketSnapshot';
      case _iqcjyqz4.Member():
        return 'Member';
      case _i1bo32kc.MemberContact():
        return 'MemberContact';
      case _i8h1xlwl.MemberUpdate():
        return 'MemberUpdate';
      case _ik5nzdng.MyListing():
        return 'MyListing';
      case _ifutsqcw.Place():
        return 'Place';
      case _iyc6u9y6.SeatResponse():
        return 'SeatResponse';
      case _ilqzmqki.SeatView():
        return 'SeatView';
      case _i797ae6t.SolverRun():
        return 'SolverRun';
      case _ii5itptg.SwapLoop():
        return 'SwapLoop';
      case _ip90o58a.Wish():
        return 'Wish';
      case _il23c4a1.WishInput():
        return 'WishInput';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Exchange') {
      return deserialize<_iw5rmx8t.Exchange>(data['data']);
    }
    if (dataClassName == 'ExchangeSummary') {
      return deserialize<_ic8hgcmq.ExchangeSummary>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i2ct69t9.Listing>(data['data']);
    }
    if (dataClassName == 'ListingStatus') {
      return deserialize<_i524jma0.ListingStatus>(data['data']);
    }
    if (dataClassName == 'LoopErrorCode') {
      return deserialize<_iqsizhe6.LoopErrorCode>(data['data']);
    }
    if (dataClassName == 'LoopEvent') {
      return deserialize<_icdgd785.LoopEvent>(data['data']);
    }
    if (dataClassName == 'LoopEventKind') {
      return deserialize<_iklfu2yy.LoopEventKind>(data['data']);
    }
    if (dataClassName == 'LoopException') {
      return deserialize<_i47sf5r5.LoopException>(data['data']);
    }
    if (dataClassName == 'LoopSeat') {
      return deserialize<_ih9o9q84.LoopSeat>(data['data']);
    }
    if (dataClassName == 'LoopStatus') {
      return deserialize<_ix0pjlyl.LoopStatus>(data['data']);
    }
    if (dataClassName == 'LoopTrace') {
      return deserialize<_i0go6mh6.LoopTrace>(data['data']);
    }
    if (dataClassName == 'LoopView') {
      return deserialize<_inakt9ip.LoopView>(data['data']);
    }
    if (dataClassName == 'MarketEvent') {
      return deserialize<_i7leuqa4.MarketEvent>(data['data']);
    }
    if (dataClassName == 'MarketEventKind') {
      return deserialize<_iao4iwg6.MarketEventKind>(data['data']);
    }
    if (dataClassName == 'MarketFlow') {
      return deserialize<_iyrvngek.MarketFlow>(data['data']);
    }
    if (dataClassName == 'MarketPlace') {
      return deserialize<_ipuaqtg1.MarketPlace>(data['data']);
    }
    if (dataClassName == 'MarketSnapshot') {
      return deserialize<_ioomabe5.MarketSnapshot>(data['data']);
    }
    if (dataClassName == 'Member') {
      return deserialize<_iqcjyqz4.Member>(data['data']);
    }
    if (dataClassName == 'MemberContact') {
      return deserialize<_i1bo32kc.MemberContact>(data['data']);
    }
    if (dataClassName == 'MemberUpdate') {
      return deserialize<_i8h1xlwl.MemberUpdate>(data['data']);
    }
    if (dataClassName == 'MyListing') {
      return deserialize<_ik5nzdng.MyListing>(data['data']);
    }
    if (dataClassName == 'Place') {
      return deserialize<_ifutsqcw.Place>(data['data']);
    }
    if (dataClassName == 'SeatResponse') {
      return deserialize<_iyc6u9y6.SeatResponse>(data['data']);
    }
    if (dataClassName == 'SeatView') {
      return deserialize<_ilqzmqki.SeatView>(data['data']);
    }
    if (dataClassName == 'SolverRun') {
      return deserialize<_i797ae6t.SolverRun>(data['data']);
    }
    if (dataClassName == 'SwapLoop') {
      return deserialize<_ii5itptg.SwapLoop>(data['data']);
    }
    if (dataClassName == 'Wish') {
      return deserialize<_ip90o58a.Wish>(data['data']);
    }
    if (dataClassName == 'WishInput') {
      return deserialize<_il23c4a1.WishInput>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('loop', this);
    _iacc.Protocol().registerHostProtocol('loop', this);
  }

  @override
  String getModuleName() => 'loop';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
