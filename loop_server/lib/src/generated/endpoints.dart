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
import 'package:loop_server/src/generated/future_calls.dart' as _i5n8udxf;
import 'package:loop_server/src/generated/loop/models/wish_input.dart'
    as _ihs1spbq;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../loop/endpoints/lab_endpoint.dart' as _ierniwv1;
import '../loop/endpoints/member_endpoints.dart' as _id0y7m3s;
import '../loop/endpoints/public_endpoints.dart' as _iri0v6lb;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'lab': _ierniwv1.LabEndpoint()
        ..initialize(
          server,
          'lab',
          null,
        ),
      'member': _id0y7m3s.MemberEndpoint()
        ..initialize(
          server,
          'member',
          null,
        ),
      'listing': _id0y7m3s.ListingEndpoint()
        ..initialize(
          server,
          'listing',
          null,
        ),
      'loop': _id0y7m3s.LoopEndpoint()
        ..initialize(
          server,
          'loop',
          null,
        ),
      'place': _iri0v6lb.PlaceEndpoint()
        ..initialize(
          server,
          'place',
          null,
        ),
      'exchange': _iri0v6lb.ExchangeEndpoint()
        ..initialize(
          server,
          'exchange',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['lab'] = _is.EndpointConnector(
      name: 'lab',
      endpoint: endpoints['lab']!,
      methodConnectors: {
        'run': _is.MethodConnector(
          name: 'run',
          params: {
            'members': _is.ParameterDescription(
              name: 'members',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'choices': _is.ParameterDescription(
              name: 'choices',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxLoopSize': _is.ParameterDescription(
              name: 'maxLoopSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'seed': _is.ParameterDescription(
              name: 'seed',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lab'] as _ierniwv1.LabEndpoint).run(
                session,
                members: params['members'],
                choices: params['choices'],
                maxLoopSize: params['maxLoopSize'],
                seed: params['seed'],
              ),
        ),
      },
    );
    connectors['member'] = _is.EndpointConnector(
      name: 'member',
      endpoint: endpoints['member']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['member'] as _id0y7m3s.MemberEndpoint).me(session),
        ),
        'myContact': _is.MethodConnector(
          name: 'myContact',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['member'] as _id0y7m3s.MemberEndpoint)
                  .myContact(session),
        ),
        'saveProfile': _is.MethodConnector(
          name: 'saveProfile',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['member'] as _id0y7m3s.MemberEndpoint).saveProfile(
                    session,
                    params['displayName'],
                    phone: params['phone'],
                    email: params['email'],
                  ),
        ),
      },
    );
    connectors['listing'] = _is.EndpointConnector(
      name: 'listing',
      endpoint: endpoints['listing']!,
      methodConnectors: {
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['listing'] as _id0y7m3s.ListingEndpoint)
                  .mine(session),
        ),
        'save': _is.MethodConnector(
          name: 'save',
          params: {
            'exchangeId': _is.ParameterDescription(
              name: 'exchangeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'currentPlaceId': _is.ParameterDescription(
              name: 'currentPlaceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'postTitle': _is.ParameterDescription(
              name: 'postTitle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'yearsInPost': _is.ParameterDescription(
              name: 'yearsInPost',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'wishes': _is.ParameterDescription(
              name: 'wishes',
              type: _is.getType<List<_ihs1spbq.WishInput>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['listing'] as _id0y7m3s.ListingEndpoint).save(
                    session,
                    exchangeId: params['exchangeId'],
                    currentPlaceId: params['currentPlaceId'],
                    postTitle: params['postTitle'],
                    yearsInPost: params['yearsInPost'],
                    wishes: params['wishes'],
                  ),
        ),
        'setPaused': _is.MethodConnector(
          name: 'setPaused',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'paused': _is.ParameterDescription(
              name: 'paused',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['listing'] as _id0y7m3s.ListingEndpoint).setPaused(
                    session,
                    params['listingId'],
                    params['paused'],
                  ),
        ),
        'withdraw': _is.MethodConnector(
          name: 'withdraw',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['listing'] as _id0y7m3s.ListingEndpoint).withdraw(
                    session,
                    params['listingId'],
                  ),
        ),
      },
    );
    connectors['loop'] = _is.EndpointConnector(
      name: 'loop',
      endpoint: endpoints['loop']!,
      methodConnectors: {
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['loop'] as _id0y7m3s.LoopEndpoint).mine(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'loopId': _is.ParameterDescription(
              name: 'loopId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['loop'] as _id0y7m3s.LoopEndpoint).get(
                session,
                params['loopId'],
              ),
        ),
        'respond': _is.MethodConnector(
          name: 'respond',
          params: {
            'loopId': _is.ParameterDescription(
              name: 'loopId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accept': _is.ParameterDescription(
              name: 'accept',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['loop'] as _id0y7m3s.LoopEndpoint).respond(
                session,
                params['loopId'],
                params['accept'],
              ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['loop'] as _id0y7m3s.LoopEndpoint).watch(session),
        ),
      },
    );
    connectors['place'] = _is.EndpointConnector(
      name: 'place',
      endpoint: endpoints['place']!,
      methodConnectors: {
        'search': _is.MethodConnector(
          name: 'search',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'state': _is.ParameterDescription(
              name: 'state',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _iri0v6lb.PlaceEndpoint).search(
                session,
                params['query'],
                state: params['state'],
              ),
        ),
        'byIds': _is.MethodConnector(
          name: 'byIds',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _iri0v6lb.PlaceEndpoint).byIds(
                session,
                params['ids'],
              ),
        ),
      },
    );
    connectors['exchange'] = _is.EndpointConnector(
      name: 'exchange',
      endpoint: endpoints['exchange']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exchange'] as _iri0v6lb.ExchangeEndpoint)
                  .list(session),
        ),
        'snapshot': _is.MethodConnector(
          name: 'snapshot',
          params: {
            'exchangeId': _is.ParameterDescription(
              name: 'exchangeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exchange'] as _iri0v6lb.ExchangeEndpoint)
                  .snapshot(
                    session,
                    params['exchangeId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'exchangeId': _is.ParameterDescription(
              name: 'exchangeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['exchange'] as _iri0v6lb.ExchangeEndpoint).watch(
                session,
                params['exchangeId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _i5n8udxf.FutureCalls();
  }
}
