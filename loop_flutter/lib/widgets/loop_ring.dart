import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

enum RingState { pending, accepted, declined, idle }

class RingSeat {
  final String place;
  final String caption;
  final RingState state;
  final bool isMe;

  const RingSeat({
    required this.place,
    this.caption = '',
    this.state = RingState.idle,
    this.isMe = false,
  });
}

/// A loop drawn as a ring: every seat is a node, every arrow means "moves to
/// the next seat's posting". Pending seats pulse; answers animate in.
class LoopRing extends StatefulWidget {
  final List<RingSeat> seats;
  final String? centerTitle;
  final String? centerSubtitle;
  final double size;

  const LoopRing({
    super.key,
    required this.seats,
    this.centerTitle,
    this.centerSubtitle,
    this.size = 320,
  });

  @override
  State<LoopRing> createState() => _LoopRingState();
}

class _LoopRingState extends State<LoopRing> with TickerProviderStateMixin {
  late final AnimationController _draw = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..forward();
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void didUpdateWidget(LoopRing old) {
    super.didUpdateWidget(old);
    if (old.seats.length != widget.seats.length) _draw.forward(from: 0);
  }

  @override
  void dispose() {
    _draw.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_draw, _pulse]),
        builder: (context, _) => CustomPaint(
          painter: _RingPainter(
            seats: widget.seats,
            draw: Curves.easeInOutCubic.transform(_draw.value),
            pulse: _pulse.value,
            colors: c,
            labelStyle: context.text.labelLarge!.copyWith(fontSize: 13),
            captionStyle: context.text.bodySmall!,
            nodeStyle: mono(context, size: 13, weight: FontWeight.w700),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(widget.size * 0.3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.centerTitle != null)
                    Text(
                      widget.centerTitle!,
                      textAlign: TextAlign.center,
                      style: context.text.headlineSmall,
                    ),
                  if (widget.centerSubtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.centerSubtitle!,
                      textAlign: TextAlign.center,
                      style: context.text.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final List<RingSeat> seats;
  final double draw;
  final double pulse;
  final LoopColors colors;
  final TextStyle labelStyle;
  final TextStyle captionStyle;
  final TextStyle nodeStyle;

  _RingPainter({
    required this.seats,
    required this.draw,
    required this.pulse,
    required this.colors,
    required this.labelStyle,
    required this.captionStyle,
    required this.nodeStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final n = seats.length;
    if (n == 0) return;
    final center = size.center(Offset.zero);
    final radius = size.width * 0.33;
    final node = size.width * 0.075;

    Offset at(int i) {
      final a = -math.pi / 2 + 2 * math.pi * i / n;
      return center + Offset(math.cos(a), math.sin(a)) * radius;
    }

    // Faint full ring.
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = colors.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Arcs i → i+1, drawn progressively.
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final sweepEach = 2 * math.pi / n;
    final gap = (node * 1.35) / radius; // radians kept clear around nodes
    for (var i = 0; i < n; i++) {
      final local = ((draw * n) - i).clamp(0.0, 1.0);
      if (local <= 0) continue;
      final start = -math.pi / 2 + sweepEach * i + gap;
      final sweep = (sweepEach - 2 * gap) * local;
      final settled =
          seats[i].state == RingState.accepted &&
          seats[(i + 1) % n].state == RingState.accepted;
      arcPaint.color = seats.any((s) => s.state == RingState.declined)
          ? colors.muted.withValues(alpha: 0.5)
          : settled
          ? colors.accepted
          : colors.loop;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep,
        false,
        arcPaint,
      );
      if (local >= 1) {
        // Arrow head at the end of the arc.
        final endAngle = start + sweep;
        final tip =
            center + Offset(math.cos(endAngle), math.sin(endAngle)) * radius;
        final dir = endAngle + math.pi / 2;
        final back = Offset(math.cos(dir), math.sin(dir)) * -11;
        final side =
            Offset(math.cos(dir + math.pi / 2), math.sin(dir + math.pi / 2)) *
            6;
        final path = Path()
          ..moveTo(tip.dx, tip.dy)
          ..lineTo(tip.dx + back.dx + side.dx, tip.dy + back.dy + side.dy)
          ..lineTo(tip.dx + back.dx - side.dx, tip.dy + back.dy - side.dy)
          ..close();
        canvas.drawPath(path, Paint()..color = arcPaint.color);
      }
    }

    // Nodes.
    for (var i = 0; i < n; i++) {
      final seat = seats[i];
      final p = at(i);
      final appear = ((draw * (n + 1)) - i).clamp(0.0, 1.0);
      if (appear <= 0) continue;
      final r = node * Curves.easeOutBack.transform(appear);

      if (seat.state == RingState.pending) {
        final halo = r + 4 + 10 * pulse;
        canvas.drawCircle(
          p,
          halo,
          Paint()
            ..color = colors.marigold.withValues(alpha: 0.35 * (1 - pulse)),
        );
      }
      final fill = switch (seat.state) {
        RingState.accepted => colors.accepted,
        RingState.declined => colors.declined,
        RingState.pending => colors.paper,
        RingState.idle => colors.paper,
      };
      canvas.drawCircle(p, r, Paint()..color = fill);
      canvas.drawCircle(
        p,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = seat.isMe ? 3.5 : 2
          ..color = seat.isMe
              ? colors.ink
              : seat.state == RingState.pending
              ? colors.marigold
              : seat.state == RingState.idle
              ? colors.loop
              : fill,
      );

      final glyph = switch (seat.state) {
        RingState.accepted => '✓',
        RingState.declined => '✕',
        _ => seat.isMe ? 'YOU' : _initials(seat.place),
      };
      final onFill =
          seat.state == RingState.accepted || seat.state == RingState.declined;
      _text(
        canvas,
        glyph,
        p,
        nodeStyle.copyWith(
          color: onFill ? Colors.white : colors.ink,
          fontSize: glyph.length > 2 ? 11 : (onFill ? 18 : 13),
        ),
      );

      // Label outside the ring.
      final dir = (p - center) / (p - center).distance;
      final labelAnchor = p + dir * (r + 22);
      _text(
        canvas,
        seat.place,
        labelAnchor,
        labelStyle.copyWith(color: colors.ink),
        maxWidth: math.max(100, size.width * 0.36),
      );
      if (seat.caption.isNotEmpty) {
        _text(
          canvas,
          seat.caption,
          labelAnchor + const Offset(0, 17),
          captionStyle,
          maxWidth: math.max(100, size.width * 0.36),
        );
      }
    }
  }

  static String _initials(String place) {
    final words = place
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.length > 1) return (words[0][0] + words[1][0]).toUpperCase();
    return place.substring(0, math.min(3, place.length)).toUpperCase();
  }

  void _text(
    Canvas canvas,
    String s,
    Offset center,
    TextStyle style, {
    double? maxWidth,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: s, style: style),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth ?? double.infinity);
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_RingPainter old) => true;
}
