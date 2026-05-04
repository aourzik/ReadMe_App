import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/friend.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/book_cover.dart';
import '../../../widgets/rm_avatar.dart';
import '../../../widgets/star_rating.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(String bookId) onOpenBook;
  final Friend? friend;
  final bool isFriend;
  final VoidCallback? onBack;
  final VoidCallback? onRequest;

  const ProfileScreen({
    super.key,
    required this.onOpenBook,
    this.friend,
    this.isFriend = false,
    this.onBack,
    this.onRequest,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _tab = 'books';

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    final person = widget.friend;
    final name = person?.name ?? kMe.name;
    final handle = person?.handle ?? kMe.handle;
    final initials = person?.initials ?? kMe.initials;
    final tone = person?.tone ?? kMe.tone;

    final stats = widget.isFriend && person != null
        ? [
            (person.books, 'Books'),
            (person.mutual, 'Mutual'),
            (4, 'Avg ★'),
          ]
        : [
            (kMe.books, 'Books'),
            (kMe.friends, 'Friends'),
            (kMe.reviews, 'Reviews'),
          ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Accent top
          Container(
            height: 132,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [C.surface2, C.bg],
              ),
            ),
            child: Stack(
              children: [
                if (widget.isFriend && widget.onBack != null)
                  Positioned(
                    left: 14, top: 54,
                    child: _NavBtn(C: C, onTap: widget.onBack!, child: const Icon(Icons.arrow_back_ios_new, size: 16)),
                  ),
                Positioned(
                  right: 14, top: 54,
                  child: _NavBtn(
                    C: C,
                    onTap: () {},
                    child: Icon(widget.isFriend ? Icons.more_horiz : Icons.settings, size: 18),
                  ),
                ),
              ],
            ),
          ),

          // Profile card
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Transform.translate(
              offset: const Offset(0, -56),
              child: Container(
                decoration: BoxDecoration(
                  color: C.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: C.line, width: 0.5),
                ),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                child: Column(
                  children: [
                    RmAvatar(initials: initials, tone: tone, size: 88, ring: C.surface),
                    const SizedBox(height: 10),
                    Text(name, style: displayStyle(C.ink, size: 26)),
                    const SizedBox(height: 4),
                    Text(
                      '$handle · Joined Apr 2024',
                      style: bodyStyle(C.inkMute, size: 12),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '"Reading slowly, mostly fiction. Always lending — sometimes returning."',
                      style: editorialStyle(C.inkSoft, size: 14.5),
                      textAlign: TextAlign.center,
                    ),

                    // Stats
                    const SizedBox(height: 16),
                    Divider(color: C.lineSoft, thickness: 0.5, height: 1),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: stats.map((s) => Column(
                        children: [
                          Text('${s.$1}', style: displayStyle(C.ink, size: 22)),
                          const SizedBox(height: 6),
                          Text(
                            s.$2.toUpperCase(),
                            style: eyebrowStyle(C.inkMute),
                          ),
                        ],
                      )).toList(),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.isFriend ? widget.onRequest : () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                    widget.isFriend ? 'Request a book' : 'Edit profile',
                                    style: bodyStyle(C.primaryInk, size: 14, weight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _GhostBtn(C: C, child: const Icon(Icons.ios_share, size: 16)),
                        if (widget.isFriend) ...[
                          const SizedBox(width: 8),
                          _GhostBtn(C: C, child: const Icon(Icons.notifications_none, size: 16)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab offset
          Transform.translate(
            offset: const Offset(0, -42),
            child: Column(
              children: [
                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: ['books', 'reviews', 'shelves'].map((t) {
                      final active = _tab == t;
                      final label = t[0].toUpperCase() + t.substring(1);
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _tab = t),
                          child: Container(
                            margin: EdgeInsets.only(right: t != 'shelves' ? 6 : 0),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: active ? C.ink : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              label,
                              style: bodyStyle(
                                active ? C.bg : C.inkSoft,
                                size: 13,
                                weight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                if (_tab == 'books')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24,
                        childAspectRatio: 100 / (148 + 30),
                      ),
                      itemCount: 6,
                      itemBuilder: (context, i) {
                        final b = kBooks[i];
                        return GestureDetector(
                          onTap: () => widget.onOpenBook(b.id),
                          child: Column(
                            children: [
                              BookCover(book: b, width: 100, height: 148),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, size: 11, color: C.star),
                                  const SizedBox(width: 4),
                                  Text(
                                    b.rating.toStringAsFixed(1),
                                    style: bodyStyle(C.star, size: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                if (_tab == 'reviews')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: kMyReviews.map((r) {
                        final b = findBook(r.bookId)!;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: C.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: C.line, width: 0.5),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BookCover(book: b, width: 64, height: 94),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      b.title,
                                      style: editorialStyle(C.ink, size: 16, italic: false)
                                          .copyWith(height: 1.15),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        StarRating(
                                          value: r.rating,
                                          size: 12,
                                          color: C.star,
                                          mute: C.lineSoft,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${r.rating.toStringAsFixed(0)}.0',
                                          style: bodyStyle(C.inkMute, size: 11),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '"${r.text}"',
                                      style: editorialStyle(C.inkSoft, size: 13.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                if (_tab == 'shelves')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        _ShelfCard(
                          C: C,
                          name: 'Currently reading',
                          count: 3,
                          books: [kBooks[4], kBooks[2]],
                        ),
                        _ShelfCard(
                          C: C,
                          name: 'Slow novels',
                          count: 12,
                          books: [kBooks[0], kBooks[6]],
                        ),
                        _ShelfCard(
                          C: C,
                          name: 'Lent out',
                          count: 2,
                          books: [kBooks[1]],
                        ),
                        _ShelfCard(
                          C: C,
                          name: 'Wishlist',
                          count: 18,
                          books: [kBooks[7], kBooks[3]],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelfCard extends StatelessWidget {
  final RmColors C;
  final String name;
  final int count;
  final List books;

  const _ShelfCard({
    required this.C,
    required this.name,
    required this.count,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.line, width: 0.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 78,
            child: Stack(
              children: List.generate(books.length, (i) {
                return Positioned(
                  left: i * 28.0,
                  child: Transform.rotate(
                    angle: (i * 4 - 2) * 0.0175,
                    child: BookCover(book: books[i], width: 50, height: 74),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: editorialStyle(C.ink, size: 14.5, italic: false)),
          Text('$count books', style: bodyStyle(C.inkMute, size: 11)),
        ],
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final RmColors C;
  final VoidCallback onTap;
  final Widget child;

  const _NavBtn({required this.C, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: C.line, width: 0.5),
        ),
        child: Center(
          child: IconTheme(data: IconThemeData(color: C.ink, size: 18), child: child),
        ),
      ),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  final RmColors C;
  final Widget child;

  const _GhostBtn({required this.C, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46, height: 46,
      decoration: BoxDecoration(
        color: C.surface2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: C.line, width: 0.5),
      ),
      child: Center(
        child: IconTheme(data: IconThemeData(color: C.ink, size: 16), child: child),
      ),
    );
  }
}
