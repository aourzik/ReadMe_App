import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/models/book.dart';

class BookCover extends StatelessWidget {
  final Book book;
  final double width;
  final double height;
  final double radius;

  const BookCover({
    super.key,
    required this.book,
    required this.width,
    required this.height,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    final bg = book.palette[0];
    final fg = book.palette[1];
    final inset = (width * 0.07).clamp(5.0, double.infinity);
    final titleSize = (width * 0.13).clamp(11.0, double.infinity);
    final authorSize = (width * 0.062).clamp(7.0, double.infinity);

    final words = book.title.split(' ');
    final lines = <String>[];
    var buf = <String>[];
    for (final wd in words) {
      buf.add(wd);
      if (buf.join(' ').length > (width * 0.12).clamp(10, double.infinity)) {
        lines.add(buf.join(' '));
        buf = [];
      }
    }
    if (buf.isNotEmpty) lines.add(buf.join(' '));

    final isModern = book.coverStyle == BookCoverStyle.modern;
    final isClassic = book.coverStyle == BookCoverStyle.classic;

    TextStyle titleFont() {
      if (isModern) {
        return GoogleFonts.commissioner(
          fontSize: titleSize * 0.88, fontWeight: FontWeight.w700,
          letterSpacing: -0.02 * titleSize, color: fg,
          height: 1.05,
        );
      }
      return GoogleFonts.fraunces(
        fontSize: titleSize, fontWeight: FontWeight.w500,
        fontStyle: isClassic ? FontStyle.italic : FontStyle.normal,
        letterSpacing: -0.01 * titleSize, color: fg,
        height: 1.02,
      );
    }

    TextStyle authorFont() => GoogleFonts.commissioner(
      fontSize: authorSize, letterSpacing: 0.16 * authorSize,
      color: fg.withOpacity(0.75), fontWeight: FontWeight.w500,
    );

    TextStyle authorModernFont() => GoogleFonts.commissioner(
      fontSize: authorSize, letterSpacing: 0.18 * authorSize,
      color: fg.withOpacity(0.7), fontWeight: FontWeight.w800,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(color: const Color(0xFF242321).withOpacity(0.18), blurRadius: 2, offset: const Offset(0, 1)),
            BoxShadow(color: const Color(0xFF242321).withOpacity(0.35), blurRadius: 22, offset: const Offset(0, 8), spreadRadius: -10),
          ],
        ),
        child: Stack(
          children: [
            // Spine shadow
            Positioned(
              left: 0, top: 0, bottom: 0,
              width: (width * 0.04).clamp(3.0, double.infinity),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0x38000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),
            // Page edge
            Positioned(
              right: 0, top: 1, bottom: 1, width: 2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0x14FFFFFF), Color(0x40000000)],
                  ),
                ),
              ),
            ),
            // Classic border
            if (isClassic)
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(inset * 0.6),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: fg.withOpacity(0.35), width: 1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            // Text content
            Padding(
              padding: EdgeInsets.all(inset),
              child: isModern
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.author.toUpperCase(),
                          style: authorModernFont(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: lines
                              .map((l) => Text(l.toUpperCase(), style: titleFont()))
                              .toList(),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: lines
                              .map((l) => Text(l, style: titleFont()))
                              .toList(),
                        ),
                        SizedBox(height: inset * 0.6),
                        Text(
                          book.author.toUpperCase(),
                          style: authorFont(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
