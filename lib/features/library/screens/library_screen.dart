import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/book_cover.dart';
import '../../../widgets/rm_icon_button.dart';

class LibraryScreen extends StatefulWidget {
  final void Function(String bookId) onOpenBook;

  const LibraryScreen({super.key, required this.onOpenBook});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _shelf = 'all';

  final _shelves = const [
    ('all', 'All', 9),
    ('reading', 'Reading', 3),
    ('finished', 'Finished', 41),
    ('wish', 'Wishlist', 18),
    ('lent', 'Lent out', 2),
  ];

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return CustomScrollView(
      slivers: [
        // App Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 60, 18, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YOUR LIBRARY',
                        style: eyebrowStyle(C.inkMute),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '64 volumes.',
                        style: displayStyle(C.ink, size: 38).copyWith(height: 1.0),
                      ),
                    ],
                  ),
                ),
                RmIconButton(child: const Icon(Icons.search)),
              ],
            ),
          ),
        ),

        // Shelf chips
        SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: _shelves.length,
              itemBuilder: (context, i) {
                final (id, label, n) = _shelves[i];
                final active = _shelf == id;
                return Padding(
                  padding: EdgeInsets.only(right: 8, bottom: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _shelf = id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? C.primary : C.surface,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: active ? Colors.transparent : C.line,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            label,
                            style: bodyStyle(active ? C.primaryInk : C.ink, size: 13,
                                weight: FontWeight.w500),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '$n',
                            style: bodyStyle(
                              active ? C.primaryInk.withOpacity(0.6) : C.inkMute,
                              size: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Currently reading hero
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: C.line, width: 0.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  BookCover(book: kBooks[4], width: 96, height: 140),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENTLY READING',
                          style: eyebrowStyle(C.accent),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          kBooks[4].title,
                          style: editorialStyle(C.ink, size: 22, italic: false)
                              .copyWith(height: 1.1),
                        ),
                        Text(
                          'by ${kBooks[4].author}',
                          style: editorialStyle(C.inkSoft, size: 12.5),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'page 124 of ${kBooks[4].pages}',
                              style: bodyStyle(C.inkMute, size: 11),
                            ),
                            Text('35%', style: bodyStyle(C.inkMute, size: 11)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: C.lineSoft,
                            color: C.primary,
                            minHeight: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Book grid
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 28,
              childAspectRatio: 102 / (152 + 44),
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final b = kBooks[i];
                return GestureDetector(
                  onTap: () => widget.onOpenBook(b.id),
                  child: Column(
                    children: [
                      BookCover(book: b, width: 102, height: 152),
                      const SizedBox(height: 8),
                      Text(
                        b.title,
                        style: editorialStyle(C.ink, size: 13, italic: false)
                            .copyWith(height: 1.15),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        b.author.split(' ').last,
                        style: bodyStyle(C.inkMute, size: 11),
                      ),
                    ],
                  ),
                );
              },
              childCount: kBooks.length,
            ),
          ),
        ),
      ],
    );
  }
}
