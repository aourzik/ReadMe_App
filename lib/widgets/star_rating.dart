import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double value;
  final double size;
  final Color color;
  final Color mute;
  final bool interactive;
  final ValueChanged<int>? onRate;

  const StarRating({
    super.key,
    required this.value,
    required this.color,
    required this.mute,
    this.size = 12,
    this.interactive = false,
    this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    final full = value.floor();
    final hasHalf = value - full >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final isFilled = i < full || (i == full && hasHalf);
        final isHalf = i == full && hasHalf;

        Widget star;
        if (isHalf) {
          star = ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: [color, mute],
              stops: const [0.5, 0.5],
            ).createShader(bounds),
            child: Icon(Icons.star, size: size, color: Colors.white),
          );
        } else {
          star = Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: isFilled ? color : mute,
          );
        }

        if (interactive && onRate != null) {
          return GestureDetector(
            onTap: () => onRate!(i + 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: star,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(right: 1),
          child: star,
        );
      }),
    );
  }
}
