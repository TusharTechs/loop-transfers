import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/loop_ring.dart';
import 'dashboard_screen.dart' show ringSeats;

/// One loop: who moves where, live answers, the deadline, and — once everyone
/// has accepted — the people and the verification code.
class LoopScreen extends StatefulWidget {
  final int loopId;
  const LoopScreen({super.key, required this.loopId});

  static Future<void> open(BuildContext context, int loopId) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoopScreen(loopId: loopId)));

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  LoopView? _loop;
  Object? _error;
  bool _busy = false;
  StreamSubscription<MemberUpdate>? _sub;
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _load();
    _sub = AppState.instance.updates.stream
        .where((u) => u.loopId == widget.loopId)
        .listen((_) => _load());
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_loop?.status == LoopStatus.proposed) setState(() {});
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final loop = await client.loop.get(widget.loopId);
      if (!mounted) return;
      setState(() {
        _loop = loop;
        _error = null;
      });
      AppState.instance.replaceLoop(loop);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _answer(bool accept) async {
    if (!accept) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Decline this loop?'),
          content: const Text(
            'The loop dissolves and everyone goes back into the market. Loop will '
            'never propose this exact move to you again. Nobody is told who declined.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Go back')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Decline')),
          ],
        ),
      );
      if (ok != true) return;
    }
    setState(() => _busy = true);
    try {
      final loop = await client.loop.respond(widget.loopId, accept);
      setState(() => _loop = loop);
      AppState.instance.replaceLoop(loop);
      unawaited(AppState.instance.refresh());
    } catch (e) {
      if (mounted) toast(context, describeError(e));
      await _load();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loop = _loop;
    return Scaffold(
      appBar: AppBar(title: Text(loop == null ? 'Loop' : '${loop.size}-way loop')),
      body: loop == null
          ? (_error != null
              ? Center(child: Text(describeError(_error!)))
              : const Loading())
          : SingleChildScrollView(
              child: PageBody(child: _body(context, loop)),
            ),
    );
  }

  Widget _body(BuildContext context, LoopView loop) {
    final me = loop.seats.firstWhere((s) => s.isMe);
    final accepted = loop.seats.where((s) => s.response == SeatResponse.accepted).length;
    final wide = MediaQuery.sizeOf(context).width >= 900;

    final ring = LoopRing(
      seats: ringSeats(loop),
      size: wide ? 420 : 320,
      centerTitle: switch (loop.status) {
        LoopStatus.proposed => '$accepted of ${loop.size}',
        LoopStatus.confirmed => 'Loop closed',
        _ => 'Dissolved',
      },
      centerSubtitle: switch (loop.status) {
        LoopStatus.proposed => 'have accepted',
        LoopStatus.confirmed => 'everyone said yes',
        _ => 'back in the market',
      },
    );

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          loopPill(context, loop.status),
          const SizedBox(width: 10),
          Expanded(child: Text(loop.exchangeName, style: context.text.bodySmall, overflow: TextOverflow.ellipsis)),
        ]),
        const SizedBox(height: 16),
        const Eyebrow('Your move'),
        const SizedBox(height: 6),
        Text('${me.fromPlace.name} → ${me.toPlace.name}', style: context.text.displaySmall),
        const SizedBox(height: 6),
        Text(
          '${ordinal(me.wishRank)}'
          '${me.km > 1 ? ' · ${me.km.toStringAsFixed(0)} km from the place you named' : ''}',
          style: context.text.bodyMedium,
        ),
        const SizedBox(height: 24),
        ..._statusBlock(context, loop, me),
        const SizedBox(height: 28),
        const Eyebrow('Everyone in this loop'),
        const SizedBox(height: 10),
        for (final s in loop.seats) _SeatRow(seat: s, revealed: loop.status == LoopStatus.confirmed),
        const SizedBox(height: 24),
        const Eyebrow('Timeline'),
        const SizedBox(height: 10),
        for (final e in loop.events) _EventRow(event: e, loop: loop),
        const SizedBox(height: 48),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ring,
                const SizedBox(width: 40),
                Expanded(child: details),
              ],
            )
          : Column(children: [Center(child: ring), details]),
    );
  }

  List<Widget> _statusBlock(BuildContext context, LoopView loop, SeatView me) {
    final c = context.colors;
    switch (loop.status) {
      case LoopStatus.proposed:
        final left = loop.deadline.difference(DateTime.now().toUtc());
        return [
          Row(children: [
            Icon(Icons.timer_outlined, size: 18, color: c.marigold),
            const SizedBox(width: 6),
            Text(countdown(left), style: mono(context, size: 15, color: c.marigold)),
          ]),
          const SizedBox(height: 14),
          if (me.response == SeatResponse.pending) ...[
            Text(
              'Accepting reserves your seat. Nothing is final until every person '
              'accepts — then you all see each other\'s contact details.',
              style: context.text.bodyMedium!.copyWith(height: 1.5),
            ),
            const SizedBox(height: 16),
            Wrap(spacing: 12, runSpacing: 12, children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: c.accepted, foregroundColor: Colors.white),
                onPressed: _busy ? null : () => _answer(true),
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Accept this move'),
              ),
              OutlinedButton(
                onPressed: _busy ? null : () => _answer(false),
                child: const Text('Decline'),
              ),
            ]),
          ] else
            Panel(
              color: c.accepted.withValues(alpha: 0.1),
              borderColor: c.accepted.withValues(alpha: 0.4),
              child: Text(
                'You accepted. Waiting for '
                '${loop.seats.where((s) => s.response == SeatResponse.pending).length} more — '
                'this page updates live.',
                style: context.text.bodyMedium,
              ),
            ),
        ];
      case LoopStatus.confirmed:
        return [
          Panel(
            color: c.accepted.withValues(alpha: 0.12),
            borderColor: c.accepted.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Everyone said yes.', style: context.text.headlineSmall),
                const SizedBox(height: 6),
                Text(
                  'File the mutual transfer application together. Share this '
                  'verification code with the transfer office — they can check '
                  'it on the Loop website.',
                  style: context.text.bodyMedium!.copyWith(height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(children: [
                  Text(loop.publicCode ?? '', style: mono(context, size: 24, weight: FontWeight.w700)),
                  IconButton(
                    tooltip: 'Copy verification link',
                    icon: const Icon(Icons.copy, size: 18),
                    onPressed: () async {
                      final base = await verificationBase();
                      await Clipboard.setData(ClipboardData(text: '$base/v/${loop.publicCode}'));
                      if (context.mounted) toast(context, 'Verification link copied');
                    },
                  ),
                ]),
              ],
            ),
          ),
        ];
      case LoopStatus.declined:
      case LoopStatus.expired:
        return [
          Panel(
            child: Text(
              loop.status == LoopStatus.expired
                  ? 'Not everyone answered in time, so this loop dissolved. Those '
                      'who answered are back in the market; silent requests were paused.'
                  : 'Someone could not take this move, so the loop dissolved. You are '
                      'back in the market and Loop is already searching again.',
              style: context.text.bodyMedium!.copyWith(height: 1.5),
            ),
          ),
        ];
    }
  }
}

class _SeatRow extends StatelessWidget {
  final SeatView seat;
  final bool revealed;
  const _SeatRow({required this.seat, required this.revealed});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final title = seat.isMe ? 'You' : (seat.name ?? seat.label);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Panel(
        padding: const EdgeInsets.all(16),
        borderColor: seat.isMe ? c.ink.withValues(alpha: 0.4) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(child: Text(title, style: context.text.titleMedium)),
              switch (seat.response) {
                SeatResponse.accepted => Pill('Accepted', color: c.accepted, icon: Icons.check),
                SeatResponse.declined => Pill('Declined', color: c.declined),
                SeatResponse.timedOut => Pill('No answer', color: c.muted),
                SeatResponse.pending => Pill('Deciding…', color: c.marigold),
              },
            ]),
            const SizedBox(height: 4),
            Text(
              '${seat.fromPlace.name} → ${seat.toPlace.name} · ${seat.yearsInPost} yrs in post',
              style: context.text.bodySmall,
            ),
            if (revealed && !seat.isMe) ...[
              const SizedBox(height: 10),
              if (seat.postTitle != null) Text(seat.postTitle!, style: context.text.bodyMedium),
              if (seat.phone != null)
                SelectableText('☎  ${seat.phone}', style: mono(context, size: 14)),
              if (seat.email != null)
                SelectableText('✉  ${seat.email}', style: mono(context, size: 14)),
            ],
          ],
        ),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final LoopEvent event;
  final LoopView loop;
  const _EventRow({required this.event, required this.loop});

  @override
  Widget build(BuildContext context) {
    final who = event.seatPosition == null
        ? null
        : loop.seats.where((s) => s.position == event.seatPosition).firstOrNull;
    final name = who == null ? '' : (who.isMe ? 'You' : who.label);
    final text = switch (event.kind) {
      LoopEventKind.proposed => 'Loop proposed by the engine',
      LoopEventKind.accepted => '$name accepted',
      LoopEventKind.declined => who == null ? 'Loop dissolved' : 'Loop dissolved — a seat declined',
      LoopEventKind.confirmed => 'Everyone accepted — loop confirmed',
      LoopEventKind.expired => 'Deadline passed — loop expired',
    };
    final t = event.at.toLocal();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Text(
          '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:'
          '${t.second.toString().padLeft(2, '0')}',
          style: mono(context, size: 12, color: context.colors.muted),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: context.text.bodyMedium)),
      ]),
    );
  }
}
