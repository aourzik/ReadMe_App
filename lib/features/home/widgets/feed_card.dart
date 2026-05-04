import 'package:flutter/material.dart';
import '../../../core/models/book.dart';
import '../../../core/models/friend.dart';
import '../../../core/models/feed_item.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/book_cover.dart';
import '../../../widgets/rm_avatar.dart';
import '../../../widgets/star_rating.dart';

class FeedCard extends StatefulWidget {
  final FeedItem item;
  final Friend friend;
  final Book book;
  final VoidCallback onOpenBook;
  final VoidCallback onOpenFriend;
  final Friend? fromFriend;

  const FeedCard({
    super.key,
    required this.item,
    required this.friend,
    required this.book,
    required this.onOpenBook,
    required this.onOpenFriend,
    this.fromFriend,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool _liked = false;

  String get _actionLabel {
    switch (widget.item.kind) {
      case FeedItemKind.review:
        return '  ·  reviewed';
      case FeedItemKind.added:
        return '  ·  added to ${(widget.item.shelf ?? 'shelf').toLowerCase()}';
      case FeedItemKind.borrow:
        return '  ·  borrowed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    final f = widget.friend;
    final b = widget.book;

    return Container(
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: C.line, width: 0.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 2, offset: const Offset(0, 1)),
          BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 28, spreadRadius: -18),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: widget.onOpenFriend,
                    child: Row(
                      children: [
                        RmAvatar(initials: f.initials, tone: f.tone, size: 36),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: bodyStyle(C.ink, size: 14, weight: FontWeight.w600),
                                  children: [
                                    TextSpan(text: f.name),
                                    TextSpan(
                                      text: _actionLabel,
                                      style: bodyStyle(C.inkMute, size: 14, weight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${f.handle} · ${widget.item.time}',
                                style: bodyStyle(C.inkMute, size: 11.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.more_horiz, color: C.inkMute, size: 18),
              ],
            ),

            const SizedBox(height: 14),

            // Body: cover + text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onOpenBook,
                  child: BookCover(book: b, width: 84, height: 124),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.title,
                        style: editorialStyle(C.ink, size: 18, italic: false).copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.15,
                        ),
                      ),
                      Text(
                        'by ${b.author}',
                        style: editorialStyle(C.inkSoft, size: 12.5),
                      ),

                      if (widget.item.kind == FeedItemKind.review) ...[
                        const SizedBox(height: 8),
                        StarRating(
                          value: widget.item.rating ?? 0,
                          size: 14,
                          color: C.star,
                          mute: C.lineSoft,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: C.accent, width: 2),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.item.text ?? '',
                            style: editorialStyle(C.ink, size: 14.5),
                          ),
                        ),
                      ],

                      if (widget.item.kind == FeedItemKind.added) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: C.chip,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bookmark_border, size: 12, color: C.primary),
                              const SizedBox(width: 6),
                              Text(
                                widget.item.shelf ?? 'Shelf',
                                style: bodyStyle(C.primary, size: 12, weight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],

                      if (widget.item.kind == FeedItemKind.borrow) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: C.chip,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'borrowed from ${widget.fromFriend?.name.split(' ').first ?? 'friend'}',
                            style: bodyStyle(C.primary, size: 12, weight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Divider(color: C.lineSoft, thickness: 0.5, height: 1),
            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                _ActionBtn(
                  icon: _liked
                      ? Icon(Icons.favorite, size: 17, color: C.accent)
                      : Icon(Icons.favorite_border, size: 17, color: C.inkSoft),
                  label: _liked ? '13' : '12',
                  C: C,
                  onTap: () => setState(() => _liked = !_liked),
                ),
                const SizedBox(width: 18),
                _ActionBtn(
                  icon: Icon(Icons.chat_bubble_outline, size: 17, color: C.inkSoft),
                  label: '3',
                  C: C,
                ),
                const SizedBox(width: 18),
                _ActionBtn(
                  icon: Icon(Icons.bookmark_border, size: 17, color: C.inkSoft),
                  label: 'Save',
                  C: C,
                ),
                const Spacer(),
                _ActionBtn(
                  icon: Icon(Icons.ios_share, size: 17, color: C.inkSoft),
                  C: C,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final Widget icon;
  final String? label;
  final RmColors C;
  final VoidCallback? onTap;

  const _ActionBtn({required this.icon, required this.C, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          if (label != null) ...[
            const SizedBox(width: 6),
            Text(label!, style: bodyStyle(C.inkSoft, size: 12.5, weight: FontWeight.w500)),
          ],
        ],
      ),
    );
  }
}
