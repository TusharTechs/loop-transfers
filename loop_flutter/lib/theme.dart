import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Loop's palette: warm paper, deep ink, and a vermilion "loop" accent.
/// Every colour is defined for light and dark so screens never hard-code.
@immutable
class LoopColors extends ThemeExtension<LoopColors> {
  final Color paper;
  final Color paperDeep;
  final Color ink;
  final Color inkSoft;
  final Color muted;
  final Color line;
  final Color loop;
  final Color loopSoft;
  final Color marigold;
  final Color accepted;
  final Color declined;
  final Color mapLand;
  final Color mapBorder;

  const LoopColors({
    required this.paper,
    required this.paperDeep,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.line,
    required this.loop,
    required this.loopSoft,
    required this.marigold,
    required this.accepted,
    required this.declined,
    required this.mapLand,
    required this.mapBorder,
  });

  static const light = LoopColors(
    paper: Color(0xFFF4EFE6),
    paperDeep: Color(0xFFEAE2D3),
    ink: Color(0xFF13233A),
    inkSoft: Color(0xFF3D4B61),
    muted: Color(0xFF7A8496),
    line: Color(0xFFD9CFBE),
    loop: Color(0xFFE2552D),
    loopSoft: Color(0xFFF7D9CC),
    marigold: Color(0xFFE9A23B),
    accepted: Color(0xFF2F8F5B),
    declined: Color(0xFFB3412E),
    mapLand: Color(0xFFE9E1D1),
    mapBorder: Color(0xFFC9BDA8),
  );

  static const dark = LoopColors(
    paper: Color(0xFF0E1726),
    paperDeep: Color(0xFF16223A),
    ink: Color(0xFFF1EBDF),
    inkSoft: Color(0xFFC9C2B5),
    muted: Color(0xFF8D96A8),
    line: Color(0xFF263552),
    loop: Color(0xFFFF6B3D),
    loopSoft: Color(0xFF4A2418),
    marigold: Color(0xFFF2B24E),
    accepted: Color(0xFF4CC184),
    declined: Color(0xFFE0654F),
    mapLand: Color(0xFF17243B),
    mapBorder: Color(0xFF2C3D5C),
  );

  @override
  LoopColors copyWith() => this;

  @override
  LoopColors lerp(LoopColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return LoopColors(
      paper: l(paper, other.paper),
      paperDeep: l(paperDeep, other.paperDeep),
      ink: l(ink, other.ink),
      inkSoft: l(inkSoft, other.inkSoft),
      muted: l(muted, other.muted),
      line: l(line, other.line),
      loop: l(loop, other.loop),
      loopSoft: l(loopSoft, other.loopSoft),
      marigold: l(marigold, other.marigold),
      accepted: l(accepted, other.accepted),
      declined: l(declined, other.declined),
      mapLand: l(mapLand, other.mapLand),
      mapBorder: l(mapBorder, other.mapBorder),
    );
  }
}

extension LoopTheme on BuildContext {
  LoopColors get colors => Theme.of(this).extension<LoopColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
}

/// Numbers and codes.
TextStyle mono(
  BuildContext context, {
  double size = 14,
  FontWeight? weight,
  Color? color,
}) => GoogleFonts.jetBrainsMono(
  fontSize: size,
  fontWeight: weight ?? FontWeight.w500,
  color: color ?? context.colors.ink,
);

ThemeData buildTheme(Brightness brightness) {
  final c = brightness == Brightness.light ? LoopColors.light : LoopColors.dark;
  final display = GoogleFonts.frauncesTextTheme();
  final body = GoogleFonts.instrumentSansTextTheme();

  TextStyle d(TextStyle? s, double size, FontWeight w, {double? height}) =>
      s!.copyWith(
        fontSize: size,
        fontWeight: w,
        color: c.ink,
        height: height,
        letterSpacing: -0.5,
      );
  TextStyle b(TextStyle? s, double size, FontWeight w, {Color? color}) =>
      s!.copyWith(fontSize: size, fontWeight: w, color: color ?? c.ink);

  final textTheme = TextTheme(
    displayLarge: d(display.displayLarge, 64, FontWeight.w600, height: 1.0),
    displayMedium: d(display.displayMedium, 46, FontWeight.w600, height: 1.05),
    displaySmall: d(display.displaySmall, 34, FontWeight.w600, height: 1.1),
    headlineMedium: d(
      display.headlineMedium,
      26,
      FontWeight.w600,
      height: 1.15,
    ),
    headlineSmall: d(display.headlineSmall, 21, FontWeight.w600, height: 1.2),
    titleLarge: b(body.titleLarge, 18, FontWeight.w600),
    titleMedium: b(body.titleMedium, 15, FontWeight.w600),
    titleSmall: b(body.titleSmall, 13, FontWeight.w600),
    bodyLarge: b(body.bodyLarge, 16, FontWeight.w400, color: c.inkSoft),
    bodyMedium: b(body.bodyMedium, 14, FontWeight.w400, color: c.inkSoft),
    bodySmall: b(body.bodySmall, 12, FontWeight.w400, color: c.muted),
    labelLarge: b(body.labelLarge, 14, FontWeight.w600),
    labelMedium: b(body.labelMedium, 12, FontWeight.w600, color: c.muted),
    labelSmall: b(
      body.labelSmall,
      11,
      FontWeight.w600,
      color: c.muted,
    ).copyWith(letterSpacing: 1.2),
  );

  final scheme =
      ColorScheme.fromSeed(
        seedColor: c.loop,
        brightness: brightness,
      ).copyWith(
        primary: c.loop,
        onPrimary: Colors.white,
        secondary: c.ink,
        surface: c.paper,
        onSurface: c.ink,
        error: c.declined,
        outline: c.line,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: c.paper,
    textTheme: textTheme,
    extensions: [c],
    dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: c.paper,
      foregroundColor: c.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: textTheme.headlineSmall,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: c.ink,
        foregroundColor: c.paper,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: const StadiumBorder(),
        textStyle: textTheme.labelLarge?.copyWith(fontSize: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: c.ink,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        side: BorderSide(color: c.ink.withValues(alpha: 0.25), width: 1.5),
        shape: const StadiumBorder(),
        textStyle: textTheme.labelLarge?.copyWith(fontSize: 15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: c.loop,
        textStyle: textTheme.labelLarge,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: c.paperDeep.withValues(alpha: 0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      labelStyle: textTheme.bodyMedium,
      floatingLabelStyle: textTheme.labelMedium?.copyWith(color: c.loop),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c.loop, width: 1.6),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: c.paperDeep,
      selectedColor: c.ink,
      labelStyle: textTheme.labelMedium?.copyWith(color: c.ink),
      secondaryLabelStyle: textTheme.labelMedium?.copyWith(color: c.paper),
      side: BorderSide(color: c.line),
      shape: const StadiumBorder(),
      showCheckmark: false,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: c.ink,
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: c.paper),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: c.paper,
      indicatorColor: c.loopSoft,
      labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      height: 68,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: c.paper,
      indicatorColor: c.loopSoft,
      selectedLabelTextStyle: textTheme.labelMedium?.copyWith(color: c.ink),
      unselectedLabelTextStyle: textTheme.labelMedium,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: c.loop,
      thumbColor: c.loop,
      inactiveTrackColor: c.line,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
      },
    ),
  );
}
