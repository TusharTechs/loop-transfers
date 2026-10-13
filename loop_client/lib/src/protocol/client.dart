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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:loop_client/src/protocol/loop/models/exchange_summary.dart'
    as _ifa6d7ob;
import 'package:loop_client/src/protocol/loop/models/loop_view.dart'
    as _ipmn2hyv;
import 'package:loop_client/src/protocol/loop/models/market_event.dart'
    as _i9bp1266;
import 'package:loop_client/src/protocol/loop/models/market_snapshot.dart'
    as _ivr2pg16;
import 'package:loop_client/src/protocol/loop/models/member.dart' as _ium4nvbm;
import 'package:loop_client/src/protocol/loop/models/member_contact.dart'
    as _iwlfvuqq;
import 'package:loop_client/src/protocol/loop/models/member_update.dart'
    as _i7nsc6ab;
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
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The signed-in member's profile. Contact details are stored server side and
/// only ever shown to partners in a confirmed loop.
/// {@category Endpoint}
class EndpointMember extends _isc.EndpointRef {
  EndpointMember(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'member';

  _ida.Future<_ium4nvbm.Member?> me() =>
      caller.callServerEndpoint<_ium4nvbm.Member?>(
        'member',
        'me',
        {},
      );

  _ida.Future<_iwlfvuqq.MemberContact> myContact() =>
      caller.callServerEndpoint<_iwlfvuqq.MemberContact>(
        'member',
        'myContact',
        {},
      );

  _ida.Future<_ium4nvbm.Member> saveProfile(
    String displayName, {
    String? phone,
    String? email,
  }) => caller.callServerEndpoint<_ium4nvbm.Member>(
    'member',
    'saveProfile',
    {
      'displayName': displayName,
      'phone': phone,
      'email': email,
    },
  );
}

/// Creating and managing transfer requests.
/// {@category Endpoint}
class EndpointListing extends _isc.EndpointRef {
  EndpointListing(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listing';

  _ida.Future<List<_iaymrcjt.MyListing>> mine() =>
      caller.callServerEndpoint<List<_iaymrcjt.MyListing>>(
        'listing',
        'mine',
        {},
      );

  /// Creates or replaces the member's listing in [exchangeId].
  _ida.Future<_iaymrcjt.MyListing> save({
    required int exchangeId,
    required int currentPlaceId,
    required String postTitle,
    required int yearsInPost,
    required List<_iyoe216s.WishInput> wishes,
  }) => caller.callServerEndpoint<_iaymrcjt.MyListing>(
    'listing',
    'save',
    {
      'exchangeId': exchangeId,
      'currentPlaceId': currentPlaceId,
      'postTitle': postTitle,
      'yearsInPost': yearsInPost,
      'wishes': wishes,
    },
  );

  /// Pauses (stop matching) or resumes a listing.
  _ida.Future<_iaymrcjt.MyListing> setPaused(
    int listingId,
    bool paused,
  ) => caller.callServerEndpoint<_iaymrcjt.MyListing>(
    'listing',
    'setPaused',
    {
      'listingId': listingId,
      'paused': paused,
    },
  );

  _ida.Future<_iaymrcjt.MyListing> withdraw(int listingId) =>
      caller.callServerEndpoint<_iaymrcjt.MyListing>(
        'listing',
        'withdraw',
        {'listingId': listingId},
      );
}

/// Loop proposals: view, answer, and follow live.
/// {@category Endpoint}
class EndpointLoop extends _isc.EndpointRef {
  EndpointLoop(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'loop';

  _ida.Future<List<_ipmn2hyv.LoopView>> mine() =>
      caller.callServerEndpoint<List<_ipmn2hyv.LoopView>>(
        'loop',
        'mine',
        {},
      );

  _ida.Future<_ipmn2hyv.LoopView> get(int loopId) =>
      caller.callServerEndpoint<_ipmn2hyv.LoopView>(
        'loop',
        'get',
        {'loopId': loopId},
      );

  _ida.Future<_ipmn2hyv.LoopView> respond(
    int loopId,
    bool accept,
  ) => caller.callServerEndpoint<_ipmn2hyv.LoopView>(
    'loop',
    'respond',
    {
      'loopId': loopId,
      'accept': accept,
    },
  );

  /// Live updates for every loop the signed-in member is part of.
  _ida.Stream<_i7nsc6ab.MemberUpdate> watch() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i7nsc6ab.MemberUpdate>,
        _i7nsc6ab.MemberUpdate
      >(
        'loop',
        'watch',
        {},
        {},
      );
}

/// District search for postings and wishes. Public.
/// {@category Endpoint}
class EndpointPlace extends _isc.EndpointRef {
  EndpointPlace(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'place';

  _ida.Future<List<_ipz77xq0.Place>> search(
    String query, {
    String? state,
  }) => caller.callServerEndpoint<List<_ipz77xq0.Place>>(
    'place',
    'search',
    {
      'query': query,
      'state': state,
    },
  );

  _ida.Future<List<_ipz77xq0.Place>> byIds(List<int> ids) =>
      caller.callServerEndpoint<List<_ipz77xq0.Place>>(
        'place',
        'byIds',
        {'ids': ids},
      );
}

/// Exchanges and their live, anonymised market. Public, so anyone can watch
/// loops form before signing up.
/// {@category Endpoint}
class EndpointExchange extends _isc.EndpointRef {
  EndpointExchange(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exchange';

  _ida.Future<List<_ifa6d7ob.ExchangeSummary>> list() =>
      caller.callServerEndpoint<List<_ifa6d7ob.ExchangeSummary>>(
        'exchange',
        'list',
        {},
      );

  _ida.Future<_ivr2pg16.MarketSnapshot> snapshot(int exchangeId) =>
      caller.callServerEndpoint<_ivr2pg16.MarketSnapshot>(
        'exchange',
        'snapshot',
        {'exchangeId': exchangeId},
      );

  /// Live market events for one exchange.
  _ida.Stream<_i9bp1266.MarketEvent> watch(int exchangeId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i9bp1266.MarketEvent>,
        _i9bp1266.MarketEvent
      >(
        'exchange',
        'watch',
        {'exchangeId': exchangeId},
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    member = EndpointMember(this);
    listing = EndpointListing(this);
    loop = EndpointLoop(this);
    place = EndpointPlace(this);
    exchange = EndpointExchange(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointMember member;

  late final EndpointListing listing;

  late final EndpointLoop loop;

  late final EndpointPlace place;

  late final EndpointExchange exchange;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'member': member,
    'listing': listing,
    'loop': loop,
    'place': place,
    'exchange': exchange,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
