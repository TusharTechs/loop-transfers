import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';

import '../theme.dart';

/// The Loop mark: an open ring closing on itself.
class LoopMark extends StatelessWidget {
  final double size;
  final Color? color;
  const LoopMark({super.key, this.size = 28, this.color});

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size.square(size),
        painter: _MarkPainter(color ?? context.colors.loop, context.colors.ink),
      );
}

class _MarkPainter extends CustomPainter {
  final Color accent;
  final Color ink;
  _MarkPainter(this.accent, this.ink);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width * 0.36;
    final stroke = size.width * 0.14;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = accent;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), -math.pi / 2 + 0.5,
        2 * math.pi - 1.0, false, paint);
    final a = -math.pi / 2 - 0.5;
    final tip = c + Offset(math.cos(a), math.sin(a)) * r;
    canvas.drawCircle(tip, stroke * 0.85, Paint()..color = ink);
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.accent != accent || old.ink != ink;
}

class Wordmark extends StatelessWidget {
  final double size;
  const Wordmark({super.key, this.size = 26});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoopMark(size: size),
          const SizedBox(width: 8),
          Text('Loop',
              style: context.text.headlineMedium!.copyWith(fontSize: size * 0.95)),
        ],
      );
}

/// Small uppercase eyebrow label.
class Eyebrow extends StatelessWidget {
  final String text;
  final Color? color;
  const Eyebrow(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: context.text.labelSmall!.copyWith(color: color ?? context.colors.loop),
      );
}

/// Paper card with a hairline border.
class Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;

  const Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: color ?? c.paperDeep.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: borderColor ?? c.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class Pill extends StatelessWidget {
  final String text;
  final Color color;
  final bool filled;
  final IconData? icon;
  const Pill(this.text, {super.key, required this.color, this.filled = false, this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: filled ? color : color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: filled ? Colors.white : color),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: context.text.labelMedium!.copyWith(
                color: filled ? Colors.white : color,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
}

Pill listingPill(BuildContext context, ListingStatus status) {
  final c = context.colors;
  return switch (status) {
    ListingStatus.active => Pill('Searching', color: c.loop, icon: Icons.radar),
    ListingStatus.reserved => Pill('In a loop', color: c.marigold, icon: Icons.hourglass_top),
    ListingStatus.paused => Pill('Paused', color: c.muted, icon: Icons.pause),
    ListingStatus.matched => Pill('Matched', color: c.accepted, icon: Icons.check),
    ListingStatus.withdrawn => Pill('Withdrawn', color: c.muted),
  };
}

Pill loopPill(BuildContext context, LoopStatus status) {
  final c = context.colors;
  return switch (status) {
    LoopStatus.proposed => Pill('Waiting for answers', color: c.marigold, icon: Icons.hourglass_top),
    LoopStatus.confirmed => Pill('Confirmed', color: c.accepted, icon: Icons.check),
    LoopStatus.declined => Pill('Dissolved', color: c.muted),
    LoopStatus.expired => Pill('Expired', color: c.muted),
  };
}

class Stat extends StatelessWidget {
  final String value;
  final String label;
  final Color? color;
  final double size;
  const Stat(this.value, this.label, {super.key, this.color, this.size = 30});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: mono(context, size: size, weight: FontWeight.w600, color: color)),
          const SizedBox(height: 2),
          Text(label, style: context.text.bodySmall),
        ],
      );
}

/// Centres content with a comfortable reading width and phone gutters.
class PageBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const PageBody({super.key, required this.child, this.maxWidth = 1080});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w < 600 ? 16 : 32),
          child: child,
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String? label;
  const Loading({super.key, this.label});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: context.colors.loop),
            ),
            if (label != null) ...[
              const SizedBox(height: 14),
              Text(label!, style: context.text.bodyMedium),
            ],
          ],
        ),
      );
}

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

String ordinal(int rank) => switch (rank) {
      0 => '1st choice',
      1 => '2nd choice',
      2 => '3rd choice',
      _ => '${rank + 1}th choice',
    };

String countdown(Duration d) {
  if (d.isNegative) return 'closing…';
  if (d.inHours >= 1) return '${d.inHours}h ${d.inMinutes % 60}m left';
  if (d.inMinutes >= 1) return '${d.inMinutes}m ${d.inSeconds % 60}s left';
  return '${d.inSeconds}s left';
}
