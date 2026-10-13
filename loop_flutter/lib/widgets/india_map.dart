import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

/// India's outline and state shapes (Natural Earth, India point of view).
class IndiaGeo {
  final List<List<Offset>> outline; // (lon, lat)
  final Map<String, List<List<Offset>>> states;

  IndiaGeo(this.outline, this.states);

  static IndiaGeo? _cached;
  static Future<IndiaGeo> load() async {
    if (_cached != null) return _cached!;
    final raw = jsonDecode(await rootBundle.loadString('assets/geo/india_states.json'))
        as Map<String, dynamic>;
    List<List<Offset>> rings(List<dynamic> rs) => [
          for (final r in rs)
            [
              for (final p in (r as List))
                Offset((p[0] as num).toDouble(), (p[1] as num).toDouble()),
            ],
        ];
    return _cached = IndiaGeo(
      rings(raw['outline'] as List),
      {
        for (final s in raw['states'] as List)
          (s['name'] as String): rings(s['rings'] as List),
      },
    );
  }
}

class MapPoint {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final int weight;
  const MapPoint(this.id, this.name, this.lat, this.lon, this.weight);
}

class MapFlow {
  final int from;
  final int to;
  final int count;
  const MapFlow(this.from, this.to, this.count);
}

class MapLoop {
  final List<int> placeIds;
  final bool confirmed;
  final bool dissolved;

  /// 1 when it just happened, fading to 0.
  final double glow;
  const MapLoop(this.placeIds, {this.confirmed = false, this.dissolved = false, this.glow = 0});
}

/// A stylised, tile-free map: fast, offline and the same on every platform.
class IndiaMap extends StatelessWidget {
  final IndiaGeo geo;
  final Map<int, MapPoint> points;
  final List<MapFlow> flows;
  final List<MapLoop> loops;
  final String? focusState;
  final Set<int> highlight;

  const IndiaMap({
    super.key,
    required this.geo,
    required this.points,
    this.flows = const [],
    this.loops = const [],
    this.focusState,
    this.highlight = const {},
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MapPainter(
        geo: geo,
        points: points,
        flows: flows,
        loops: loops,
        focusState: focusState,
        highlight: highlight,
        colors: context.colors,
        labelStyle: context.text.labelSmall!.copyWith(letterSpacing: 0.2),
      ),
      size: Size.infinite,
    );
  }
}

class _MapPainter extends CustomPainter {
  final IndiaGeo geo;
  final Map<int, MapPoint> points;
  final List<MapFlow> flows;
  final List<MapLoop> loops;
  final String? focusState;
  final Set<int> highlight;
  final LoopColors colors;
  final TextStyle labelStyle;

  _MapPainter({
    required this.geo,
    required this.points,
    required this.flows,
    required this.loops,
    required this.focusState,
    required this.highlight,
    required this.colors,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Frame: the focus state (or all India), with padding.
    final frameRings = focusState != null && geo.states[focusState] != null
        ? geo.states[focusState]!
        : geo.outline;
    var minLon = 999.0, maxLon = -999.0, minLat = 999.0, maxLat = -999.0;
    for (final ring in frameRings) {
      for (final p in ring) {
        minLon = math.min(minLon, p.dx);
        maxLon = math.max(maxLon, p.dx);
        minLat = math.min(minLat, p.dy);
        maxLat = math.max(maxLat, p.dy);
      }
    }
    final midLat = (minLat + maxLat) / 2 * math.pi / 180;
    final kx = math.cos(midLat);
    final w = (maxLon - minLon) * kx;
    final h = maxLat - minLat;
    const pad = 28.0;
    final scale = math.min((size.width - 2 * pad) / w, (size.height - 2 * pad) / h);
    final ox = (size.width - w * scale) / 2;
    final oy = (size.height - h * scale) / 2;
    Offset project(double lon, double lat) =>
        Offset(ox + (lon - minLon) * kx * scale, oy + (maxLat - lat) * scale);

    Path pathOf(List<List<Offset>> rings) {
      final path = Path();
      for (final ring in rings) {
        if (ring.isEmpty) continue;
        final first = project(ring.first.dx, ring.first.dy);
        path.moveTo(first.dx, first.dy);
        for (final p in ring.skip(1)) {
          final q = project(p.dx, p.dy);
          path.lineTo(q.dx, q.dy);
        }
        path.close();
      }
      return path;
    }

    canvas.save();
    canvas.clipRect(Offset.zero & size);

    // Land.
    final outline = pathOf(geo.outline);
    canvas.drawShadow(outline, colors.ink.withValues(alpha: 0.25), 6, false);
    canvas.drawPath(outline, Paint()..color = colors.mapLand);
    if (focusState != null && geo.states[focusState] != null) {
      canvas.drawPath(
        pathOf(geo.states[focusState]!),
        Paint()..color = colors.paperDeep,
      );
    }
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = colors.mapBorder;
    for (final rings in geo.states.values) {
      canvas.drawPath(pathOf(rings), border);
    }
    canvas.drawPath(
      outline,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = colors.mapBorder,
    );

    Offset? pos(int id) {
      final p = points[id];
      return p == null ? null : project(p.lon, p.lat);
    }

    // Demand flows: faint curved arcs.
    final maxCount = flows.fold<int>(1, (m, f) => math.max(m, f.count));
    for (final f in flows) {
      final a = pos(f.from), b = pos(f.to);
      if (a == null || b == null) continue;
      final t = f.count / maxCount;
      _arc(
        canvas,
        a,
        b,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.6 + 1.6 * t
          ..color = colors.inkSoft.withValues(alpha: 0.08 + 0.22 * t),
        bend: 0.18,
      );
    }

    // Loops: closed curved polylines.
    for (final loop in loops) {
      final pts = [for (final id in loop.placeIds) pos(id)].whereType<Offset>().toList();
      if (pts.length < 2) continue;
      final color = loop.dissolved
          ? colors.muted
          : loop.confirmed
              ? colors.accepted
              : colors.loop;
      final alpha = loop.dissolved ? 0.25 : 0.45 + 0.55 * loop.glow;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.6 + 2.4 * loop.glow
        ..color = color.withValues(alpha: alpha);
      if (loop.glow > 0) {
        final glowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10 * loop.glow
          ..color = color.withValues(alpha: 0.25 * loop.glow)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
        for (var i = 0; i < pts.length; i++) {
          _arc(canvas, pts[i], pts[(i + 1) % pts.length], glowPaint, bend: 0.25, arrow: false);
        }
      }
      for (var i = 0; i < pts.length; i++) {
        _arc(canvas, pts[i], pts[(i + 1) % pts.length], paint, bend: 0.25, arrow: loop.glow > 0.2);
      }
    }

    // Districts.
    final maxWeight = points.values.fold<int>(1, (m, p) => math.max(m, p.weight));
    final labelled = <Rect>[];
    final sorted = points.values.toList()..sort((a, b) => b.weight.compareTo(a.weight));
    for (final p in sorted) {
      final o = project(p.lon, p.lat);
      final r = 2.2 + 5.5 * math.sqrt(p.weight / maxWeight);
      final hot = highlight.contains(p.id);
      canvas.drawCircle(o, r + 1.5, Paint()..color = colors.paper);
      canvas.drawCircle(o, r, Paint()..color = hot ? colors.loop : colors.ink.withValues(alpha: 0.75));
    }
    // Labels for the largest districts, avoiding overlaps.
    for (final p in sorted.take(14)) {
      final o = project(p.lon, p.lat);
      final tp = TextPainter(
        text: TextSpan(text: p.name, style: labelStyle.copyWith(color: colors.inkSoft)),
        textDirection: TextDirection.ltr,
      )..layout();
      final rect = Rect.fromLTWH(o.dx + 7, o.dy - tp.height / 2, tp.width, tp.height);
      if (labelled.any((r) => r.overlaps(rect.inflate(2)))) continue;
      if (!(Offset.zero & size).contains(rect.bottomRight)) continue;
      labelled.add(rect);
      tp.paint(canvas, rect.topLeft);
    }
    canvas.restore();
  }

  void _arc(Canvas canvas, Offset a, Offset b, Paint paint, {double bend = 0.2, bool arrow = false}) {
    final mid = (a + b) / 2;
    final d = b - a;
    final normal = Offset(-d.dy, d.dx) * bend;
    final ctrl = mid + normal;
    final path = Path()
      ..moveTo(a.dx, a.dy)
      ..quadraticBezierTo(ctrl.dx, ctrl.dy, b.dx, b.dy);
    canvas.drawPath(path, paint);
    if (arrow && d.distance > 16) {
      final metric = path.computeMetrics().first;
      final t = metric.getTangentForOffset(metric.length * 0.55);
      if (t != null) {
        final dir = t.vector;
        final side = Offset(-dir.dy, dir.dx);
        final tip = t.position + dir * 5;
        final head = ui.Path()
          ..moveTo(tip.dx, tip.dy)
          ..lineTo(tip.dx - dir.dx * 9 + side.dx * 5, tip.dy - dir.dy * 9 + side.dy * 5)
          ..lineTo(tip.dx - dir.dx * 9 - side.dx * 5, tip.dy - dir.dy * 9 - side.dy * 5)
          ..close();
        canvas.drawPath(head, Paint()..color = paint.color.withValues(alpha: 1));
      }
    }
  }

  @override
  bool shouldRepaint(_MapPainter old) => true;
}
