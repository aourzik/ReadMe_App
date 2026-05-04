import 'package:flutter/material.dart';
import '../core/theme/rm_theme.dart';

class RmIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool showDot;

  const RmIconButton({
    super.key,
    required this.child,
    this.onTap,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: C.line, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(child: IconTheme(data: IconThemeData(color: C.ink, size: 20), child: child)),
            if (showDot)
              Positioned(
                top: 9, right: 9,
                child: Container(
                  width: 7, height: 7,
                  decoration: BoxDecoration(
                    color: C.accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: C.surface, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
