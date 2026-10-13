import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:loop_client/loop_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// When you are running the app on a physical device, you need to set the
// server URL to the IP address of your computer. You can find the IP
// address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
//
// You can set the variable when running or building your app like this:
// E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
//
// Otherwise, the server URL is fetched from the assets/config.json file or
// defaults to http://$localhost:8080/ if not found.
final serverUrl = _resolveServerUrl();

/// On Serverpod Cloud the web app is served from `<id>.serverpod.space` and
/// the API lives at `<id>.api.serverpod.space`, so the URL can be derived
/// without fetching `config.json` first (faster start, no fallback to
/// localhost if that request is slow).
Future<String> _resolveServerUrl() async {
  const fromDefine = String.fromEnvironment('SERVER_URL');
  if (fromDefine.isNotEmpty) return fromDefine;
  if (kIsWeb) {
    final host = Uri.base.host;
    if (host.endsWith('.serverpod.space') && !host.contains('.api.')) {
      final api = host.replaceFirst('.serverpod.space', '.api.serverpod.space');
      return 'https://$api/';
    }
  }
  return getServerUrl();
}

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

Future<void> initializeClient() async {
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  unawaited(client.auth.initialize());
}

/// Base URL of the public website (landing and verification pages), which is
/// served by the Serverpod web server next to the API.
Future<String> verificationBase() async {
  if (kIsWeb) return Uri.base.origin;
  final api = Uri.parse(await serverUrl);
  if (api.host.endsWith('.api.serverpod.space')) {
    return 'https://${api.host.replaceFirst('.api.serverpod.space', '.serverpod.space')}';
  }
  return api
      .replace(port: api.port == 8080 ? 8082 : api.port, path: '')
      .toString()
      .replaceAll(RegExp(r'/$'), '');
}
