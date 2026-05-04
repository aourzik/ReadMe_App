import 'package:flutter/material.dart';
import '../core/theme/rm_theme.dart';

class SectionHeading extends StatelessWidget {
  final String eyebrow;
  final String title;
  final Widget? action;

  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow.toUpperCase(),
                  style: eyebrowStyle(C.accent),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: displayStyle(C.ink, size: 22),
                ),
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
