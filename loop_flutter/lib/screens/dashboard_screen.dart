import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/loop_ring.dart';
import 'loop_screen.dart';
import 'request_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: AppState.instance,
        builder: (context, _) => _build(context),
      );

  Widget _build(BuildContext context) {
    final state = AppState.instance;
    final live = state.liveLoop;
    final history = state.loops.where((l) => l.id != live?.id).toList();
    return RefreshIndicator(
      onRefresh: state.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hello, ${state.member!.displayName.split(' ').first}.',
                      style: context.text.displaySmall,
                    ),
                  ),
                  _LiveDot(live: state.live),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                live != null
                    ? 'A loop found you. Everyone in it has to say yes.'
                    : 'Loop keeps searching while you get on with your day.',
                style: context.text.bodyLarge,
              ),
              const SizedBox(height: 28),
              if (live != null) ...[
                _LiveLoopCard(loop: live),
                const SizedBox(height: 28),
              ],
              const Eyebrow('Your requests'),
              const SizedBox(height: 12),
              for (final l in state.listings) ...[
                _ListingCard(listing: l),
                const SizedBox(height: 14),
              ],
              TextButton.icon(
                onPressed: () => RequestScreen.open(context),
                icon: const Icon(Icons.add),
                label: const Text('Request in another exchange'),
              ),
              if (history.isNotEmpty) ...[
                const SizedBox(height: 28),
                const Eyebrow('Loop history'),
                const SizedBox(height: 12),
                for (final loop in history) _HistoryRow(loop: loop),
              ],
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveDot extends StatelessWidget {
  final bool live;
  const _LiveDot({required this.live});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: live ? 'Live: updates arrive instantly' : 'Reconnecting…',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: live ? context.colors.accepted : context.colors.muted,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(live ? 'LIVE' : 'OFFLINE', style: context.text.labelSmall),
          ],
        ),
      );
}

List<RingSeat> ringSeats(LoopView loop) => [
      for (final s in loop.seats)
        RingSeat(
          place: s.fromPlace.name,
          caption: s.isMe ? 'You → ${s.toPlace.name}' : (s.name ?? '→ ${s.toPlace.name}'),
          isMe: s.isMe,
          state: switch (s.response) {
            SeatResponse.accepted => RingState.accepted,
            SeatResponse.declined => RingState.declined,
            SeatResponse.timedOut => RingState.declined,
            SeatResponse.pending =>
              loop.status == LoopStatus.proposed ? RingState.pending : RingState.idle,
          },
        ),
    ];

class _LiveLoopCard extends StatefulWidget {
  final LoopView loop;
  const _LiveLoopCard({required this.loop});

  @override
  State<_LiveLoopCard> createState() => _LiveLoopCardState();
}

class _LiveLoopCardState extends State<_LiveLoopCard> {
  late final Timer _tick = Timer.periodic(
    const Duration(seconds: 1),
    (_) => setState(() {}),
  );

  @override
  void initState() {
    super.initState();
    _tick;
  }

  @override
  void dispose() {
    _tick.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loop = widget.loop;
    final c = context.colors;
    final me = loop.seats.firstWhere((s) => s.isMe);
    final accepted = loop.seats.where((s) => s.response == SeatResponse.accepted).length;
    final wide = MediaQuery.sizeOf(context).width >= 700;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Pill('${loop.size}-way loop found', color: c.loop, filled: true, icon: Icons.all_inclusive),
        const SizedBox(height: 14),
        Text('${me.fromPlace.name} → ${me.toPlace.name}', style: context.text.headlineMedium),
        const SizedBox(height: 4),
        Text(
          '${ordinal(me.wishRank)} · $accepted of ${loop.size} have accepted · '
          '${countdown(loop.deadline.difference(DateTime.now().toUtc()))}',
          style: context.text.bodyMedium,
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: c.loop, foregroundColor: Colors.white),
          onPressed: () => LoopScreen.open(context, loop.id),
          icon: const Icon(Icons.arrow_forward, size: 18),
          label: Text(me.response == SeatResponse.pending ? 'Review and answer' : 'Follow live'),
        ),
      ],
    );
    return Panel(
      color: c.loopSoft.withValues(alpha: 0.6),
      borderColor: c.loop.withValues(alpha: 0.5),
      onTap: () => LoopScreen.open(context, loop.id),
      child: wide
          ? Row(children: [
              LoopRing(seats: ringSeats(loop), size: 230),
              const SizedBox(width: 24),
              Expanded(child: details),
            ])
          : Column(children: [
              LoopRing(seats: ringSeats(loop), size: 250),
              details,
            ]),
    );
  }
}

class _ListingCard extends StatefulWidget {
  final MyListing listing;
  const _ListingCard({required this.listing});

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard> {
  bool _busy = false;

  Future<void> _run(Future<MyListing> Function() action) async {
    setState(() => _busy = true);
    try {
      AppState.instance.replaceListing(await action());
    } catch (e) {
      if (mounted) toast(context, describeError(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = widget.listing;
    final status = l.listing.status;
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(l.exchange.name, style: context.text.titleMedium)),
              listingPill(context, status),
            ],
          ),
          const SizedBox(height: 14),
          Text(l.listing.currentPlace?.name ?? '', style: context.text.headlineMedium),
          Text('${l.listing.postTitle} · ${l.listing.yearsInPost} yrs', style: context.text.bodySmall),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.east, size: 16, color: c.muted),
              for (final w in l.wishes)
                Chip(
                  label: Text(w.radiusKm == 0
                      ? w.place?.name ?? ''
                      : '${w.place?.name} ±${w.radiusKm} km'),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 32,
            runSpacing: 12,
            children: [
              Stat('${l.wantMyPlace}', 'colleagues want your district', size: 24),
              Stat('${l.atMyWishes}', 'are posted where you want to go', size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: c.line),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            children: [
              if (status == ListingStatus.active || status == ListingStatus.paused)
                TextButton.icon(
                  onPressed: _busy ? null : () => RequestScreen.open(context, editing: l),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                ),
              if (status == ListingStatus.active)
                TextButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(() => client.listing.setPaused(l.listing.id!, true)),
                  icon: const Icon(Icons.pause, size: 18),
                  label: const Text('Pause'),
                ),
              if (status == ListingStatus.paused)
                TextButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(() => client.listing.setPaused(l.listing.id!, false)),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Resume searching'),
                ),
              if (status == ListingStatus.active || status == ListingStatus.paused)
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: c.muted),
                  onPressed: _busy ? null : () => _confirmWithdraw(context, l),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('Withdraw'),
                ),
              if (status == ListingStatus.reserved && l.activeLoopId != null)
                TextButton.icon(
                  onPressed: () => LoopScreen.open(context, l.activeLoopId!),
                  icon: const Icon(Icons.all_inclusive, size: 18),
                  label: const Text('Open your loop'),
                ),
            ],
          ),
          if (status == ListingStatus.paused)
            Text(
              'Paused requests are left out of matching. A request is paused '
              'automatically if a loop deadline passes without your answer.',
              style: context.text.bodySmall,
            ),
        ],
      ),
    );
  }

  Future<void> _confirmWithdraw(BuildContext context, MyListing l) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw this request?'),
        content: const Text('You will stop being matched in this exchange.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Keep')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Withdraw')),
        ],
      ),
    );
    if (ok == true) await _run(() => client.listing.withdraw(l.listing.id!));
  }
}

class _HistoryRow extends StatelessWidget {
  final LoopView loop;
  const _HistoryRow({required this.loop});

  @override
  Widget build(BuildContext context) {
    final route = [for (final s in loop.seats) s.fromPlace.name].join(' → ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Panel(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        onTap: () => LoopScreen.open(context, loop.id),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$route → ${loop.seats.first.fromPlace.name}',
                      style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(loop.exchangeName, style: context.text.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 12),
            loopPill(context, loop.status),
          ],
        ),
      ),
    );
  }
}
