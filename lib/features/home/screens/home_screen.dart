import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/book_cover.dart';
import '../../../widgets/rm_avatar.dart';
import '../../../widgets/rm_icon_button.dart';
import '../../../widgets/section_heading.dart';
import '../../../widgets/wordmark.dart';
import '../widgets/feed_card.dart';

class HomeScreen extends StatelessWidget {
  final void Function(String bookId) onOpenBook;
  final void Function(String friendId) onOpenFriend;

  const HomeScreen({
    super.key,
    required this.onOpenBook,
    required this.onOpenFriend,
  });

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 14),
            child: Row(
              children: [
                const Wordmark(size: 26),
                const Spacer(),
                RmIconButton(child: const Icon(Icons.search)),
                const SizedBox(width: 6),
                RmIconButton(child: const Icon(Icons.notifications_none), showDot: true),
              ],
            ),
          ),

          // Editorial banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: C.primary,
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'THIS WEEK ON THE SHELF',
                        style: bodyStyle(C.primaryInk.withOpacity(0.7), size: 11,
                            weight: FontWeight.w700).copyWith(letterSpacing: 2.2),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 44 - 90 - 44,
                        child: Text(
                          'Slow novels for the long evenings.',
                          style: displayStyle(C.primaryInk, size: 28).copyWith(height: 1.05),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: C.accent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Read the list',
                                  style: bodyStyle(const Color(0xFF1a1a14), size: 12,
                                      weight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF1a1a14)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '· 8 titles · ~5 min',
                            style: bodyStyle(C.primaryInk.withOpacity(0.7), size: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Peeking covers
                  Positioned(
                    right: -14, top: 0,
                    child: Transform.rotate(
                      angle: 0.14,
                      child: BookCover(book: kBooks[2], width: 72, height: 108),
                    ),
                  ),
                  Positioned(
                    right: 30, bottom: -14,
                    child: Transform.rotate(
                      angle: -0.1,
                      child: BookCover(book: kBooks[6], width: 62, height: 92),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SectionHeading(eyebrow: 'Among friends', title: 'Recent activity'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: kFeed.map((item) {
                final friend = findFriend(item.friendId)!;
                final book = findBook(item.bookId)!;
                final fromFriend = item.fromId != null ? findFriend(item.fromId!) : null;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: FeedCard(
                    item: item,
                    friend: friend,
                    book: book,
                    fromFriend: fromFriend,
                    onOpenBook: () => onOpenBook(book.id),
                    onOpenFriend: () => onOpenFriend(friend.id),
                  ),
                );
              }).toList(),
            ),
          ),

          SectionHeading(eyebrow: 'Currently', title: 'On their nightstands'),

          SizedBox(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: kFriends.length > 5 ? 5 : kFriends.length,
              itemBuilder: (context, i) {
                final f = kFriends[i];
                final b = kBooks[(i + 2) % kBooks.length];
                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: GestureDetector(
                    onTap: () => onOpenBook(b.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            BookCover(book: b, width: 108, height: 158),
                            Positioned(
                              top: -6, left: -6,
                              child: RmAvatar(
                                initials: f.initials,
                                tone: f.tone,
                                size: 28,
                                ring: C.bg,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 108,
                          child: Text(
                            '${f.name.split(' ').first} · pg ${(b.pages * 0.35).floor()}',
                            style: bodyStyle(C.inkMute, size: 11),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 108,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (0.30 + i * 0.09).clamp(0.0, 1.0),
                              backgroundColor: C.lineSoft,
                              color: C.accent,
                              minHeight: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
