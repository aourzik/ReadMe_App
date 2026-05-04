import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Brand tokens
const kCream = Color(0xFFFCFEEC);
const kGreen = Color(0xFF062A04);
const kGold = Color(0xFF9A8B0A);
const kBlack = Color(0xFF242321);

Color _mix(Color a, Color b, double t) {
  return Color.fromARGB(
    255,
    (a.red + (b.red - a.red) * t).round(),
    (a.green + (b.green - a.green) * t).round(),
    (a.blue + (b.blue - a.blue) * t).round(),
  );
}

class RmColors {
  final Color bg;
  final Color surface;
  final Color surface2;
  final Color ink;
  final Color inkSoft;
  final Color inkMute;
  final Color primary;
  final Color primaryInk;
  final Color accent;
  final Color line;
  final Color lineSoft;
  final Color chip;
  final Color overlay;
  final Color star;
  final Color tabBg;
  final Color glassBorder;

  const RmColors({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.ink,
    required this.inkSoft,
    required this.inkMute,
    required this.primary,
    required this.primaryInk,
    required this.accent,
    required this.line,
    required this.lineSoft,
    required this.chip,
    required this.overlay,
    required this.star,
    required this.tabBg,
    required this.glassBorder,
  });

  static RmColors light() {
    final cream = kCream;
    final green = kGreen;
    final gold = kGold;
    final black = kBlack;
    final white = const Color(0xFFFFFFFF);

    return RmColors(
      bg: cream,
      surface: _mix(cream, white, 0.35),
      surface2: _mix(cream, green, 0.06),
      ink: black,
      inkSoft: _mix(black, cream, 0.30),
      inkMute: _mix(black, cream, 0.55),
      primary: green,
      primaryInk: cream,
      accent: gold,
      line: black.withOpacity(0.10),
      lineSoft: black.withOpacity(0.06),
      chip: green.withOpacity(0.08),
      overlay: black.withOpacity(0.55),
      star: gold,
      tabBg: cream.withOpacity(0.78),
      glassBorder: black.withOpacity(0.08),
    );
  }

  static RmColors dark() {
    final cream = kCream;
    final green = kGreen;
    final gold = kGold;
    final black = const Color(0xFF000000);

    final deepBg = _mix(green, black, 0.55);
    final surf = _mix(green, black, 0.40);
    final surf2 = _mix(green, black, 0.50);

    return RmColors(
      bg: deepBg,
      surface: surf,
      surface2: surf2,
      ink: cream,
      inkSoft: _mix(cream, green, 0.30),
      inkMute: _mix(cream, green, 0.55),
      primary: cream,
      primaryInk: green,
      accent: _mix(gold, cream, 0.25),
      line: cream.withOpacity(0.10),
      lineSoft: cream.withOpacity(0.06),
      chip: cream.withOpacity(0.08),
      overlay: const Color(0xFF000000).withOpacity(0.6),
      star: _mix(gold, cream, 0.25),
      tabBg: deepBg.withOpacity(0.78),
      glassBorder: cream.withOpacity(0.10),
    );
  }
}

class RmTextStyles {
  final TextStyle display;
  final TextStyle editorial;
  final TextStyle body;
  final TextStyle label;
  final TextStyle eyebrow;

  const RmTextStyles({
    required this.display,
    required this.editorial,
    required this.body,
    required this.label,
    required this.eyebrow,
  });

  static RmTextStyles build(Color ink) {
    return RmTextStyles(
      display: GoogleFonts.commissioner(
        fontSize: 28, fontWeight: FontWeight.w700, color: ink, height: 1.0,
      ),
      editorial: GoogleFonts.fraunces(
        fontSize: 16, fontStyle: FontStyle.italic, color: ink, height: 1.45,
      ),
      body: GoogleFonts.commissioner(
        fontSize: 14, fontWeight: FontWeight.w400, color: ink,
      ),
      label: GoogleFonts.commissioner(
        fontSize: 12, fontWeight: FontWeight.w600, color: ink, letterSpacing: 0.04,
      ),
      eyebrow: GoogleFonts.commissioner(
        fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 2.2,
        color: ink,
      ),
    );
  }
}

// Convenience theme extension
class RmTheme extends InheritedWidget {
  final RmColors colors;
  final bool isDark;

  const RmTheme({
    super.key,
    required this.colors,
    required this.isDark,
    required super.child,
  });

  static RmColors of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RmTheme>()!.colors;
  }

  static bool darkOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RmTheme>()!.isDark;
  }

  @override
  bool updateShouldNotify(RmTheme old) =>
      colors != old.colors || isDark != old.isDark;
}

TextStyle displayStyle(Color color, {double size = 28}) =>
    GoogleFonts.fascinate(
      fontSize: size, fontWeight: FontWeight.w700, color: color, height: 1.0,
    );

TextStyle editorialStyle(Color color, {double size = 16, bool italic = true}) =>
    GoogleFonts.fraunces(
      fontSize: size,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.45,
    );

TextStyle bodyStyle(Color color, {double size = 14, FontWeight weight = FontWeight.w400}) =>
    GoogleFonts.commissioner(
      fontSize: size, fontWeight: weight, color: color,
    );

TextStyle eyebrowStyle(Color color) =>
    GoogleFonts.commissioner(
      fontSize: 10.5, fontWeight: FontWeight.w700,
      letterSpacing: 2.2, color: color,
    ).copyWith(decoration: TextDecoration.none);
