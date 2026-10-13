// End-to-end smoke test against a running Loop server (local or Cloud):
//
//   dart run tool/smoke.dart https://loop-transfers.api.serverpod.space/ judge2@example.com
//
// Signs in with a demo account, posts a Sandbox request, waits for the
// engine to propose a loop, watches the simulated colleagues accept, accepts,
// and checks the public verification page.
// ignore_for_file: avoid_print
import 'dart:io';

import 'package:loop_client/loop_client.dart';

class _Bearer implements ClientAuthKeyProvider {
  String? token;
  @override
  Future<String?> get authHeaderValue async =>
      token == null ? null : 'Bearer $token';
}

Future<void> main(List<String> args) async {
  final url = args.isNotEmpty ? args[0] : 'http://localhost:8080/';
  final email = args.length > 1 ? args[1] : 'judge2@example.com';
  final password = Platform.environment['LOOP_DEMO_PASSWORD'] ?? 'LoopDemo-2026!';
  final auth = _Bearer();
  final client = Client(url)..authKeyProvider = auth;
  final watch = Stopwatch()..start();
  void step(String s) => print('[${(watch.elapsedMilliseconds / 1000).toStringAsFixed(1)}s] $s');

  final session = await client.emailIdp.login(email: email, password: password);
  auth.token = session.token;
  step('signed in as $email');

  final sandbox = (await client.exchange.list())
      .firstWhere((s) => s.exchange.isSandbox)
      .exchange;
  final pune = (await client.place.search('Pune', state: sandbox.state)).first;
  final nagpur = (await client.place.search('Nagpur', state: sandbox.state)).first;

  final mine = await client.listing.mine();
  final existing = mine.where((l) => l.exchange.id == sandbox.id).firstOrNull;
  if (existing?.listing.status == ListingStatus.reserved && existing?.activeLoopId != null) {
    await client.loop.respond(existing!.activeLoopId!, false);
    step('declined a leftover loop from an earlier run');
  }
  await client.listing.save(
    exchangeId: sandbox.id!,
    currentPlaceId: pune.id!,
    postTitle: 'Primary Teacher, smoke test',
    yearsInPost: 4,
    wishes: [WishInput(placeId: nagpur.id!, radiusKm: 0)],
  );
  step('posted Pune → Nagpur in "${sandbox.name}"');

  LoopView? loop;
  for (var i = 0; i < 60 && loop == null; i++) {
    await Future<void>.delayed(const Duration(seconds: 2));
    loop = (await client.loop.mine())
        .where((l) => l.status == LoopStatus.proposed)
        .firstOrNull;
  }
  if (loop == null) throw StateError('No loop proposed within 2 minutes');
  final route = [for (final s in loop.seats) s.fromPlace.name].join(' → ');
  step('engine proposed a ${loop.size}-way loop: $route → ${loop.seats.first.fromPlace.name}');

  for (var i = 0; i < 40; i++) {
    final others = loop!.seats.where((s) => !s.isMe);
    if (others.every((s) => s.response == SeatResponse.accepted)) break;
    await Future<void>.delayed(const Duration(seconds: 2));
    loop = await client.loop.get(loop.id);
  }
  step('simulated colleagues: ${loop!.seats.where((s) => !s.isMe).map((s) => s.response.name).join(', ')}');

  final done = await client.loop.respond(loop.id, true);
  step('accepted → ${done.status.name}, code ${done.publicCode}');
  if (done.status != LoopStatus.confirmed) throw StateError('Loop not confirmed');
  if (done.seats.any((s) => s.name == null)) throw StateError('Identities not revealed');

  final web = Uri.parse(url.replaceFirst('.api.', '.').replaceFirst(':8080', ':8082'));
  final http = HttpClient();
  final page = await http
      .getUrl(web.replace(path: '/v/${done.publicCode}'))
      .then((r) => r.close());
  step('verification page: HTTP ${page.statusCode}');
  http.close(force: true);
  client.close();
  if (page.statusCode != 200) exit(1);
  print('SMOKE TEST PASSED');
  exit(0);
}
