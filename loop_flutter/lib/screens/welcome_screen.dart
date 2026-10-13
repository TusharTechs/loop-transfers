import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../main.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/loop_ring.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final hero = [
      const Expanded(flex: 6, child: _Pitch()),
      SizedBox(width: wide ? 40 : 0, height: wide ? 0 : 32),
      const Expanded(flex: 5, child: Center(child: _StoryRing())),
    ];
    return SingleChildScrollView(
      child: PageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: wide ? 64 : 24),
            if (wide)
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: hero)
            else
              Column(
                children: [
                  for (final w in hero) w is Expanded ? w.child : w,
                ],
              ),
            const SizedBox(height: 40),
            const _LiveStrip(),
            const SizedBox(height: 40),
            const _Principles(),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class _Pitch extends StatelessWidget {
  const _Pitch();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Mutual transfers for public servants'),
        const SizedBox(height: 14),
        Text(
          'Close\nthe loop.',
          style: wide ? context.text.displayLarge : context.text.displayMedium,
        ),
        const SizedBox(height: 20),
        Text(
          'Transfer portals only match pairs: you need someone where you want to '
          'go who wants to come where you are. Most people never find them.\n\n'
          'Loop finds the three- and four-way chains that pairs miss — then gets '
          'everyone to agree at once, before anyone\'s posting changes.',
          style: context.text.bodyLarge!.copyWith(height: 1.55),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => showSignIn(context),
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('Post your transfer request'),
            ),
            OutlinedButton.icon(
              onPressed: () => Shell.goTo(context, 1),
              icon: const Icon(Icons.public, size: 18),
              label: const Text('Watch the live market'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Just exploring? Pick the Sandbox — simulated colleagues answer in seconds.',
          style: context.text.bodySmall,
        ),
      ],
    );
  }
}

/// Plays the canonical story: nobody in Nagpur wants Pune, yet a loop closes.
class _StoryRing extends StatefulWidget {
  const _StoryRing();

  @override
  State<_StoryRing> createState() => _StoryRingState();
}

class _StoryRingState extends State<_StoryRing> {
  int _step = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      setState(() => _step = (_step + 1) % 7);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  RingState _state(int i) {
    if (_step == 0) return RingState.idle;
    if (_step > i + 1) return RingState.accepted;
    return RingState.pending;
  }

  @override
  Widget build(BuildContext context) {
    final done = _step >= 4;
    final size = MediaQuery.sizeOf(context).width < 600 ? 300.0 : 380.0;
    return Column(
      children: [
        LoopRing(
          size: size,
          seats: [
            RingSeat(
              place: 'Pune',
              caption: 'Priya → Nagpur',
              state: _state(0),
            ),
            RingSeat(
              place: 'Nagpur',
              caption: 'Rahul → Mumbai',
              state: _state(1),
            ),
            RingSeat(
              place: 'Mumbai',
              caption: 'Sneha → Pune',
              state: _state(2),
            ),
          ],
          centerTitle: done ? 'Loop closed' : '3-way loop',
          centerSubtitle: done ? 'Three families, one move' : 'No pair exists',
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          // Fade the new line in without overlapping the old one.
          layoutBuilder: (current, previous) => current ?? const SizedBox(),
          child: Text(
            done
                ? 'Everyone said yes — now the transfer is real.'
                : 'Nobody in Nagpur wants Pune. Loop still finds a way.',
            key: ValueKey(done),
            textAlign: TextAlign.center,
            style: context.text.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _Principles extends StatelessWidget {
  const _Principles();

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.hub_outlined,
        'Finds hidden loops',
        'A graph engine searches every 2-, 3- and 4-way chain in your cadre '
            'and picks the set that moves the most people.',
      ),
      (
        Icons.handshake_outlined,
        'All agree, or nothing changes',
        'Every seat in a loop is reserved together. One "no" releases '
            'everyone; silence expires on a deadline.',
      ),
      (
        Icons.visibility_off_outlined,
        'Private until it\'s real',
        'Partners see "Teacher · Nagpur", never names — until every person '
            'has accepted.',
      ),
    ];
    return LayoutBuilder(
      builder: (context, box) {
        final cols = box.maxWidth >= 860 ? 3 : 1;
        final w = (box.maxWidth - (cols - 1) * 16) / cols;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final (icon, title, body) in items)
              SizedBox(
                width: w,
                child: Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: context.colors.loop),
                      const SizedBox(height: 14),
                      Text(title, style: context.text.titleLarge),
                      const SizedBox(height: 6),
                      Text(
                        body,
                        style: context.text.bodyMedium!.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Email sign-in in a dialog. In development the verification code is
/// printed by the server; in production Serverpod Cloud emails it.
Future<void> showSignIn(BuildContext context) => showDialog(
  context: context,
  builder: (context) => Dialog(
    backgroundColor: context.colors.paper,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wordmark(),
            const SizedBox(height: 16),
            Text('Join or sign in', style: context.text.headlineSmall),
            const SizedBox(height: 6),
            Text(
              'New here? We email you a code to confirm your address, then you choose a password.',
              style: context.text.bodyMedium,
            ),
            const SizedBox(height: 16),
            SignInWidget(
              client: client,
              onAuthenticated: () => Navigator.of(context).maybePop(),
              onError: (error) => toast(context, 'Sign-in failed: $error'),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.colors.paperDeep,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text.rich(
                TextSpan(
                  style: context.text.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Judging or just looking? ',
                      style: context.text.labelMedium!.copyWith(
                        color: context.colors.ink,
                      ),
                    ),
                    const TextSpan(
                      text:
                          'Choose "Sign in" and use judge1@example.com '
                          '(up to judge10) with password ',
                    ),
                    TextSpan(
                      text: 'LoopDemo-2026!',
                      style: mono(context, size: 12),
                    ),
                    const TextSpan(text: ' — no email needed.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

/// Live totals across every exchange, refreshed every 20 seconds.
class _LiveStrip extends StatefulWidget {
  const _LiveStrip();

  @override
  State<_LiveStrip> createState() => _LiveStripState();
}

class _LiveStripState extends State<_LiveStrip> {
  List<ExchangeSummary>? _data;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(const Duration(seconds: 20), (_) => _load());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final data = await client.exchange.list();
      if (mounted) setState(() => _data = data);
    } catch (_) {
      // Decorative: stay quiet if the server is unreachable.
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = _data;
    if (d == null) return const SizedBox(height: 92);
    int sum(int Function(ExchangeSummary) f) => d.fold(0, (a, e) => a + f(e));
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: c.accepted,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Eyebrow('Right now, live from the engine'),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 40,
          runSpacing: 16,
          children: [
            Stat('${sum((e) => e.activeListings)}', 'requests searching'),
            Stat(
              '${sum((e) => e.peopleMatched)}',
              'people matched in confirmed loops',
              color: c.accepted,
            ),
            Stat('${sum((e) => e.confirmedLoops)}', 'loops confirmed'),
            Stat('${d.length}', 'exchanges'),
          ],
        ),
      ],
    );
  }
}
