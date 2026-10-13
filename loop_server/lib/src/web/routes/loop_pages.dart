import 'package:serverpod/serverpod.dart';

import '../../cache_busting.dart';
import '../../generated/protocol.dart';
import '../../loop/services/market.dart';

/// Public landing page, rendered on the server with live numbers.
class LandingRoute extends WidgetRoute {
  LandingRoute() : super(cacheBustingConfig: cacheBustingConfig);

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    final t = await Market.totals(session);
    final factor = t.pairPeople == 0 ? null : t.loopPeople / t.pairPeople;
    return _Page('landing', {
      'people': _fmt(t.people),
      'loops': _fmt(t.loops),
      'listings': _fmt(t.listings),
      'loopPeople': _fmt(t.loopPeople),
      'pairPeople': _fmt(t.pairPeople),
      'factor': factor?.toStringAsFixed(1),
      'year': DateTime.now().year,
    });
  }
}

/// `/v/<code>`: lets a transfer office confirm that a loop is genuine and
/// that every member agreed, without exposing contact details.
class VerifyRoute extends WidgetRoute {
  VerifyRoute() : super(cacheBustingConfig: cacheBustingConfig);

  static const _code = PathParam<String>(#code, _identity);
  static String _identity(String s) => s;

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    final code = request.pathParameters.get(_code).toUpperCase().trim();
    final loop = await SwapLoop.db.findFirstRow(
      session,
      where: (t) =>
          t.publicCode.equals(code) & t.status.equals(LoopStatus.confirmed),
    );
    if (loop == null) {
      return _Page('verify', {'found': false, 'code': code});
    }
    final exchange = await Exchange.db.findById(session, loop.exchangeId);
    final seats = await LoopSeat.db.find(
      session,
      where: (t) => t.loopId.equals(loop.id!),
      orderBy: (t) => t.position,
    );
    final places = {
      for (final p in await Place.db.find(
        session,
        where: (t) => t.id.inSet(<int>{
          for (final s in seats) ...[s.fromPlaceId, s.toPlaceId],
        }),
      ))
        p.id!: p,
    };
    final listings = {
      for (final l in await Listing.db.find(
        session,
        where: (t) => t.id.inSet(<int>{for (final s in seats) s.listingId}),
      ))
        l.id!: l,
    };
    final members = {
      for (final m in await Member.db.find(
        session,
        where: (t) => t.id.inSet(<int>{for (final s in seats) s.memberId}),
      ))
        m.id!: m,
    };
    return _Page('verify', {
      'found': true,
      'code': code,
      'exchange': exchange?.name,
      'simulated': exchange?.isSimulated ?? false,
      'size': loop.size,
      'confirmedAt': _date(loop.resolvedAt ?? loop.createdAt),
      'seats': [
        for (final s in seats)
          {
            'n': s.position + 1,
            'name': _initialled(members[s.memberId]?.displayName ?? 'Member'),
            'post': listings[s.listingId]?.postTitle ?? '',
            'from': places[s.fromPlaceId]?.name,
            'to': places[s.toPlaceId]?.name,
            'acceptedAt': _date(s.respondedAt),
          },
      ],
    });
  }

  /// "Priya Kulkarni" → "Priya K." — enough to match an application form.
  static String _initialled(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return parts.first;
    return '${parts.first} ${parts.last[0]}.';
  }
}

/// `/v/<code>/application`: a printable joint mutual-transfer application
/// for a confirmed loop, ready to sign and file with the transfer office.
class ApplicationRoute extends WidgetRoute {
  ApplicationRoute() : super(cacheBustingConfig: cacheBustingConfig);

  static const _code = PathParam<String>(#code, _identity);
  static String _identity(String s) => s;

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    final code = request.pathParameters.get(_code).toUpperCase().trim();
    final loop = await SwapLoop.db.findFirstRow(
      session,
      where: (t) =>
          t.publicCode.equals(code) & t.status.equals(LoopStatus.confirmed),
    );
    if (loop == null) return _Page('verify', {'found': false, 'code': code});
    final exchange = await Exchange.db.findById(session, loop.exchangeId);
    final seats = await LoopSeat.db.find(
      session,
      where: (t) => t.loopId.equals(loop.id!),
      orderBy: (t) => t.position,
    );
    final places = {
      for (final p in await Place.db.find(
        session,
        where: (t) => t.id.inSet(<int>{
          for (final s in seats) ...[s.fromPlaceId, s.toPlaceId],
        }),
      ))
        p.id!: p,
    };
    final listings = {
      for (final l in await Listing.db.find(
        session,
        where: (t) => t.id.inSet(<int>{for (final s in seats) s.listingId}),
      ))
        l.id!: l,
    };
    final members = {
      for (final m in await Member.db.find(
        session,
        where: (t) => t.id.inSet(<int>{for (final s in seats) s.memberId}),
      ))
        m.id!: m,
    };
    final host = request.url.host;
    return _Page('application', {
      'code': code,
      'size': loop.size,
      'exchange': exchange?.name,
      'cadre': exchange?.cadre,
      'scope': exchange?.scope,
      'simulated': exchange?.isSimulated ?? false,
      'confirmedAt': _date(loop.resolvedAt ?? loop.createdAt),
      'verifyUrl': 'https://$host/v/$code',
      'seats': [
        for (final s in seats)
          {
            'n': s.position + 1,
            'name': members[s.memberId]?.displayName ?? 'Member',
            'post': listings[s.listingId]?.postTitle ?? '',
            'years': listings[s.listingId]?.yearsInPost ?? 0,
            'from': places[s.fromPlaceId]?.name,
            'fromState': places[s.fromPlaceId]?.state,
            'to': places[s.toPlaceId]?.name,
          },
      ],
    });
  }
}

class _Page extends TemplateWidget {
  _Page(String name, Map<String, dynamic> data) : super(name: name) {
    values = data;
  }
}

String _fmt(int n) {
  final s = n.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
    out.write(s[i]);
  }
  return out.toString();
}

String? _date(DateTime? d) {
  if (d == null) return null;
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final u = d.toUtc();
  return '${u.day} ${months[u.month - 1]} ${u.year}, '
      '${u.hour.toString().padLeft(2, '0')}:${u.minute.toString().padLeft(2, '0')} UTC';
}
