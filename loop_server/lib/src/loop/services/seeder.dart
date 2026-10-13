import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'bots.dart';
import 'jobs.dart';
import 'loop_service.dart';

/// Idempotent start-up data: districts, the exchanges, simulated members for
/// the demo markets, and the recurring sweep.
abstract final class Seeder {
  static final exchanges = [
    Exchange(
      slug: 'sandbox',
      name: 'Sandbox · try Loop yourself',
      cadre: 'Primary Teacher',
      scope: 'Maharashtra',
      state: 'Maharashtra',
      description:
          'A playground with simulated colleagues who answer within '
          'seconds. Post a request and watch a loop form and close.',
      maxLoopSize: 4,
      acceptWindowMinutes: 30,
      isSandbox: true,
      isSimulated: true,
    ),
    Exchange(
      slug: 'mh-zp-primary-teachers',
      name: 'Maharashtra · ZP Primary Teachers',
      cadre: 'Primary Teacher (ZP)',
      scope: 'Maharashtra',
      state: 'Maharashtra',
      description:
          'Inter-district mutual transfers for Zilla Parishad primary '
          'teachers.',
      isSimulated: true,
    ),
    Exchange(
      slug: 'ka-staff-nurses',
      name: 'Karnataka · Staff Nurses',
      cadre: 'Staff Nurse',
      scope: 'Karnataka',
      state: 'Karnataka',
      description: 'Mutual transfers for Health & Family Welfare staff nurses.',
      isSimulated: true,
    ),
    Exchange(
      slug: 'up-police-constables',
      name: 'Uttar Pradesh · Police Constables',
      cadre: 'Constable',
      scope: 'Uttar Pradesh',
      state: 'Uttar Pradesh',
      description:
          'Inter-district mutual transfers for civil police '
          'constables.',
      isSimulated: true,
    ),
    Exchange(
      slug: 'india-post-postal-assistants',
      name: 'India Post · Postal Assistants',
      cadre: 'Postal Assistant',
      scope: 'All India',
      description: 'Inter-circle Rule 38 transfers for postal assistants.',
      isSimulated: true,
    ),
  ];

  static Future<void> run(Session session) async {
    await _places(session);
    final saved = await _exchanges(session);
    for (final e in saved.where((e) => e.isSimulated)) {
      await Bots.replenish(session, e, max: Bots.targetSize(e));
    }
    await Jobs.startSweep(const Duration(minutes: 3));
    for (final e in saved) {
      await LoopService.scheduleSolve(
        session,
        e.id!,
        delay: const Duration(seconds: 3),
      );
    }
  }

  static Future<void> _places(Session session) async {
    if (await Place.db.count(session) > 0) return;
    final file = File('data/india_districts.json');
    final rows = (jsonDecode(await file.readAsString()) as List)
        .cast<Map<String, dynamic>>();
    await Place.db.insert(session, [
      for (final r in rows)
        Place(
          code: r['code'] as String,
          name: r['name'] as String,
          state: r['state'] as String,
          point: GeographyPoint(
            longitude: (r['lon'] as num).toDouble(),
            latitude: (r['lat'] as num).toDouble(),
          ),
          population: (r['population'] as num?)?.toInt() ?? 0,
        ),
    ]);
    session.log('Seeded ${rows.length} places.');
  }

  static Future<List<Exchange>> _exchanges(Session session) async {
    final out = <Exchange>[];
    for (final e in exchanges) {
      final existing = await Exchange.db.findFirstRow(
        session,
        where: (t) => t.slug.equals(e.slug),
      );
      out.add(
        existing == null
            ? await Exchange.db.insertRow(session, e)
            : await Exchange.db.updateRow(
                session,
                e.copyWith(id: existing.id),
              ),
      );
    }
    return out;
  }
}
