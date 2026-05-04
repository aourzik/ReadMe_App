import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/book.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/book_cover.dart';
import '../../../widgets/rm_avatar.dart';
import '../../../widgets/section_heading.dart';
import '../../../widgets/star_rating.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final VoidCallback onBack;
  final VoidCallback onRequest;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.onBack,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    final heroColor = book.palette[0];
    const cream = Color(0xFFF6FADD);

    final reviews = [
      (kFriends[0], 5.0, 'A patient, almost monastic novel. Vidal builds rooms you don\'t want to leave.'),
      (kFriends[2], 4.0, 'Earns its quiet ending. I loved the second half.'),
      (kFriends[4], 5.0, 'I underlined more than I should have.'),
    ];

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.7, 1.0],
                    colors: [heroColor, heroColor, C.bg],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(22, 54, 22, 38),
                child: Column(
                  children: [
                    // Nav row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HeroBtn(onTap: onBack, child: const Icon(Icons.arrow_back_ios_new, size: 16)),
                        Row(
                          children: [
                            _HeroBtn(onTap: () {}, child: const Icon(Icons.bookmark_border, size: 18)),
                            const SizedBox(width: 6),
                            _HeroBtn(onTap: () {}, child: const Icon(Icons.ios_share, size: 18)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Cover
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 30,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: BookCover(book: book, width: 170, height: 252, radius: 6),
                    ),
                  ],
                ),
              ),

              // Meta
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Column(
                  children: [
                    const SizedBox(height: -10),
                    Text(
                      book.title,
                      style: displayStyle(C.ink, size: 30).copyWith(height: 1.05),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'by ${book.author} · ${book.year}',
                      style: editorialStyle(C.inkSoft, size: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      decoration: BoxDecoration(
                        color: C.surface,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: C.line, width: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StarRating(value: book.rating, size: 14, color: C.star, mute: C.line),
                          const SizedBox(width: 8),
                          Text(
                            book.rating.toStringAsFixed(1),
                            style: bodyStyle(C.ink, size: 12.5, weight: FontWeight.w600),
                          ),
                          const SizedBox(width: 6),
                          Text('· 4 friends', style: bodyStyle(C.inkMute, size: 11.5)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'A patient novel about inheritance, weather, and the small architectures we build to wait out the long winter. Three hundred pages of restraint and one final, exhilarating door.',
                      style: editorialStyle(C.inkSoft, size: 15).copyWith(height: 1.55),
                      textAlign: TextAlign.left,
                    ),

                    // Meta strip
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: C.line, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          _MetaCell(C: C, value: '${book.pages}', label: 'Pages', first: true),
                          _MetaCell(C: C, value: 'Fiction', label: 'Genre'),
                          _MetaCell(C: C, value: 'EN', label: 'Language'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // On shelves of
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ON THE SHELVES OF', style: eyebrowStyle(C.accent)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ...List.generate(4, (i) => Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 0 : -10),
                          child: RmAvatar(
                            initials: kFriends[i].initials,
                            tone: kFriends[i].tone,
                            size: 36,
                            ring: C.bg,
                          ),
                        )),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            style: bodyStyle(C.inkSoft, size: 13),
                            children: [
                              TextSpan(
                                text: '4 friends',
                                style: bodyStyle(C.ink, size: 13, weight: FontWeight.w600),
                              ),
                              const TextSpan(text: ' own this book'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SectionHeading(eyebrow: 'What they said', title: 'Friend reviews'),

              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
                child: Column(
                  children: reviews.map((r) {
                    final (f, rating, text) = r;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: C.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: C.line, width: 0.5),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RmAvatar(initials: f.initials, tone: f.tone, size: 32),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      f.name,
                                      style: bodyStyle(C.ink, size: 13.5, weight: FontWeight.w600),
                                    ),
                                    StarRating(
                                      value: rating,
                                      size: 11,
                                      color: C.star,
                                      mute: C.lineSoft,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: C.accent, width: 2),
                              ),
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              text,
                              style: editorialStyle(C.ink, size: 14).copyWith(height: 1.45),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Sticky CTA
        Positioned(
          left: 0, right: 0, bottom: 96,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: C.line, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                    spreadRadius: -10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onRequest,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: C.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send, size: 15, color: C.primaryInk),
                            const SizedBox(width: 8),
                            Text(
                              'Request from a friend',
                              style: bodyStyle(C.primaryInk, size: 14, weight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: C.surface2,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: C.line, width: 0.5),
                    ),
                    child: Center(
                      child: Icon(Icons.add, size: 18, color: C.ink),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _HeroBtn({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: const Color(0xF6FADD).withOpacity(0.16),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: IconTheme(
            data: const IconThemeData(color: Color(0xFFF6FADD), size: 18),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _MetaCell extends StatelessWidget {
  final RmColors C;
  final String value;
  final String label;
  final bool first;

  const _MetaCell({
    required this.C,
    required this.value,
    required this.label,
    this.first = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: first
                ? BorderSide.none
                : BorderSide(color: C.lineSoft, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            Text(value, style: editorialStyle(C.ink, size: 16, italic: false)),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: eyebrowStyle(C.inkMute),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
