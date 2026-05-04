import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/rm_theme.dart';

class Wordmark extends StatelessWidget {
  final double size;

  const Wordmark({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Read',
          style: GoogleFonts.fascinate(
            fontSize: size,
            fontWeight: FontWeight.w700,
            color: C.primary,
            letterSpacing: -0.01,
            height: 1.0,
          ),
        ),
        Text(
          '·',
          style: GoogleFonts.commissioner(
            fontSize: size,
            fontWeight: FontWeight.w700,
            color: C.accent,
            height: 1.0,
          ),
        ),
        Text(
          'Me',
          style: GoogleFonts.fraunces(
            fontSize: size,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: C.primary,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
