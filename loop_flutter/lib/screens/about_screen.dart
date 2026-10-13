import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/loop_lab.dart';
import '../widgets/loop_ring.dart';

/// How Loop works, for members and for the curious.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return SingleChildScrollView(
      child: PageBody(
        maxWidth: 860,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            const Eyebrow('How it works'),
            const SizedBox(height: 10),
            Text(
              'Pairs are rare.\nLoops are everywhere.',
              style: context.text.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              'A mutual transfer needs a perfect pair: someone where you want to go '
              'who wants exactly your place. In a cadre of a few hundred people '
              'spread over dozens of districts, that pair usually does not exist. '
              'But chains do — and kidney exchanges have used the same idea to '
              'save thousands of lives.',
              style: context.text.bodyLarge!.copyWith(height: 1.6),
            ),
            const SizedBox(height: 32),
            const LoopLab(),
            const SizedBox(height: 36),
            Center(
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _Figure(
                    title: 'A pair',
                    caption: 'Both must want each other. Rare.',
                    seats: const [
                      RingSeat(place: 'Pune', state: RingState.idle),
                      RingSeat(place: 'Nagpur', state: RingState.idle),
                    ],
                  ),
                  _Figure(
                    title: 'A 3-way loop',
                    caption: 'Each wants the next. Common.',
                    seats: const [
                      RingSeat(place: 'Pune', state: RingState.idle),
                      RingSeat(place: 'Nagpur', state: RingState.idle),
                      RingSeat(place: 'Mumbai', state: RingState.idle),
                    ],
                  ),
                  _Figure(
                    title: 'A 4-way loop',
                    caption: 'Found automatically.',
                    seats: const [
                      RingSeat(place: 'Pune', state: RingState.idle),
                      RingSeat(place: 'Nagpur', state: RingState.idle),
                      RingSeat(place: 'Nashik', state: RingState.idle),
                      RingSeat(place: 'Thane', state: RingState.idle),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 44),
            for (final (n, title, body) in _steps)
              Padding(
                padding: const EdgeInsets.only(bottom: 26),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: wide ? 72 : 48,
                      child: Text(
                        n,
                        style: mono(
                          context,
                          size: wide ? 34 : 26,
                          color: c.loop,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: context.text.headlineSmall),
                          const SizedBox(height: 6),
                          Text(
                            body,
                            style: context.text.bodyLarge!.copyWith(
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('Under the hood'),
                  const SizedBox(height: 10),
                  Text(
                    'One Dart codebase on Serverpod',
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  for (final line in _tech)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Container(
                              width: 6,
                              height: 6,
                              color: c.loop,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              line,
                              style: context.text.bodyMedium!.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'District data © GeoNames (geonames.org), CC BY 4.0. '
              'Map outlines: Natural Earth (public domain), India point of view.',
              style: context.text.bodySmall,
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  static const _steps = [
    (
      '01',
      'Tell Loop where you are and where you would go',
      'Pick your exchange (same cadre and post), your current district, and up '
          'to five places in order of preference — exact districts or "anywhere '
          'within 50 km".',
    ),
    (
      '02',
      'The engine searches every loop',
      'Requests become a graph: an arrow from you to everyone posted where you '
          'want to go. Loop prunes dead ends, splits the graph into strongly '
          'connected parts, and enumerates every 2-, 3- and 4-way cycle. It then '
          'chooses non-overlapping loops that maximise the expected number of '
          'people moved — a long loop only happens if everyone says yes.',
    ),
    (
      '03',
      'Everyone commits together',
      'All seats in a proposed loop are reserved at once, so nobody can be in '
          'two loops. Each person sees their move and a deadline. One decline '
          'releases everyone (and that move is never proposed again); silence '
          'expires and pauses the silent request.',
    ),
    (
      '04',
      'Then you meet',
      'Only when every person has accepted are names and contacts revealed — '
          'with a verification code the transfer office can check online.',
    ),
  ];

  static const _tech = [
    'PostGIS builds the "who would accept whom" graph in one spatial query (ST_DWithin on geography).',
    'A pure Dart engine (Tarjan SCC, bounded cycle enumeration, expected-value packing) runs in milliseconds.',
    'Proposals, answers and expiry are Postgres transactions with row locks and an advisory lock per exchange.',
    'Deadlines, debounced re-solves and the market sweep are durable Serverpod future calls.',
    'Every change is pushed live over typed streaming endpoints and server events.',
    'The landing and verification pages are rendered by Serverpod\'s web server.',
  ];
}

class _Figure extends StatelessWidget {
  final String title;
  final String caption;
  final List<RingSeat> seats;
  const _Figure({
    required this.title,
    required this.caption,
    required this.seats,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 230,
    child: Column(
      children: [
        LoopRing(seats: seats, size: 220),
        const SizedBox(height: 22),
        Text(title, style: context.text.titleMedium),
        Text(
          caption,
          style: context.text.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
