import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RmAvatar extends StatelessWidget {
  final String initials;
  final Color tone;
  final double size;
  final Color? ring;

  const RmAvatar({
    super.key,
    required this.initials,
    required this.tone,
    this.size = 38,
    this.ring,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tone,
        boxShadow: ring != null
            ? [
                BoxShadow(color: ring!, blurRadius: 0, spreadRadius: 2),
                BoxShadow(color: tone.withOpacity(0.2), blurRadius: 0, spreadRadius: 3),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.commissioner(
            fontSize: size * 0.36,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF6FADD),
            letterSpacing: 0.04,
          ),
        ),
      ),
    );
  }
}
