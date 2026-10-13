import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:loop_client/loop_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';

/// Everything the signed-in member sees, kept fresh by a live stream of
/// [MemberUpdate]s from the server (with automatic reconnect).
class AppState extends ChangeNotifier {
  AppState._();
  static final instance = AppState._();

  Member? member;
  List<MyListing> listings = [];
  List<LoopView> loops = [];
  bool loaded = false;
  bool live = false;
  Object? error;

  /// Fires with the loop id whenever a loop changes live.
  final updates = StreamController<MemberUpdate>.broadcast();

  StreamSubscription<MemberUpdate>? _sub;
  Timer? _retry;
  int _attempt = 0;

  bool get signedIn => client.auth.isAuthenticated;

  LoopView? get liveLoop =>
      loops.where((l) => l.status == LoopStatus.proposed).firstOrNull;

  void start() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  void _onAuthChanged() {
    if (signedIn) {
      refresh();
    } else {
      _stopLive();
      member = null;
      listings = [];
      loops = [];
      loaded = true;
      notifyListeners();
    }
  }

  Future<void> refresh({bool profile = true}) async {
    if (!signedIn) return;
    try {
      // Live pushes only change loops and requests: skip the profile round
      // trip so updates land on screen faster.
      if (profile || member == null) member = await client.member.me();
      if (member != null) {
        final results = await Future.wait([
          client.listing.mine(),
          client.loop.mine(),
        ]);
        listings = results[0] as List<MyListing>;
        loops = results[1] as List<LoopView>;
        _startLive();
      }
      error = null;
    } catch (e) {
      error = e;
      // Server unreachable (e.g. restarting): keep retrying with backoff.
      if (_sub == null) _scheduleRetry();
    }
    loaded = true;
    notifyListeners();
  }

  void _startLive() {
    if (_sub != null) return;
    _sub = client.loop.watch().listen(
      (update) {
        _attempt = 0;
        updates.add(update);
        refresh(profile: false);
      },
      onError: (_) => _reconnect(),
      onDone: _reconnect,
      cancelOnError: true,
    );
    live = true;
  }

  void _reconnect() {
    _sub = null;
    live = false;
    notifyListeners();
    _scheduleRetry();
  }

  void _scheduleRetry() {
    if (!signedIn) return;
    _retry?.cancel();
    final delay = Duration(seconds: [1, 2, 5, 10, 20][_attempt.clamp(0, 4)]);
    _attempt++;
    _retry = Timer(delay, () {
      if (signedIn && member != null) {
        refresh(); // Also catches up on anything missed while offline.
      }
    });
  }

  void _stopLive() {
    _retry?.cancel();
    _sub?.cancel();
    _sub = null;
    live = false;
  }

  void setMember(Member m) {
    member = m;
    notifyListeners();
    refresh();
  }

  void replaceListing(MyListing updated) {
    final i = listings.indexWhere((l) => l.listing.id == updated.listing.id);
    if (updated.listing.status == ListingStatus.withdrawn) {
      if (i >= 0) listings.removeAt(i);
    } else if (i >= 0) {
      listings[i] = updated;
    } else {
      listings.add(updated);
    }
    notifyListeners();
  }

  void replaceLoop(LoopView updated) {
    final i = loops.indexWhere((l) => l.id == updated.id);
    if (i >= 0) {
      loops[i] = updated;
    } else {
      loops.insert(0, updated);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await client.auth.signOutDevice();
  }
}

/// Human readable message for any error thrown by the client.
String describeError(Object e) {
  if (e is LoopException) return e.message;
  final s = e.toString();
  if (s.contains('SocketException') || s.contains('XMLHttpRequest')) {
    return 'Cannot reach the Loop server. Check your connection.';
  }
  return 'Something went wrong. Please try again.';
}
