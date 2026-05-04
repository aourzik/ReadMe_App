import 'package:flutter/material.dart';
import '../core/data/mock_data.dart';
import '../core/models/book.dart';
import '../core/theme/rm_theme.dart';
import 'book_cover.dart';
import 'rm_avatar.dart';

class RequestSheet extends StatefulWidget {
  final Book book;

  const RequestSheet({super.key, required this.book});

  @override
  State<RequestSheet> createState() => _RequestSheetState();
}

class _RequestSheetState extends State<RequestSheet> {
  String _picked = 'f1';
  final _noteCtrl = TextEditingController(
    text: 'Hey — could I borrow your copy for a couple of weeks?',
  );
  bool _sent = false;

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 44, height: 5,
              decoration: BoxDecoration(
                color: C.line,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          if (!_sent) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 0),
              child: Column(
                children: [
                  Text('Borrow this book', style: displayStyle(C.ink, size: 24)),
                  const SizedBox(height: 4),
                  Text('3 friends own a copy', style: bodyStyle(C.inkMute, size: 12.5)),
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book preview
                    Container(
                      decoration: BoxDecoration(
                        color: C.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: C.line, width: 0.5),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          BookCover(book: widget.book, width: 48, height: 70),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: editorialStyle(C.ink, size: 15, italic: false),
                                ),
                                Text(
                                  widget.book.author,
                                  style: editorialStyle(C.inkMute, size: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text('ASK', style: eyebrowStyle(C.inkMute)),
                    ),
                    Column(
                      children: kFriends.take(3).map((f) {
                        final picked = _picked == f.id;
                        return GestureDetector(
                          onTap: () => setState(() => _picked = f.id),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: picked ? C.surface : C.surface2,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: picked ? C.primary : C.line,
                                width: 0.5,
                              ),
                              boxShadow: picked
                                  ? [BoxShadow(color: C.primary.withOpacity(0.13), blurRadius: 0, spreadRadius: 2)]
                                  : null,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Row(
                              children: [
                                RmAvatar(initials: f.initials, tone: f.tone, size: 36),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f.name,
                                        style: bodyStyle(C.ink, size: 14, weight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Last lent · 3 weeks ago',
                                        style: bodyStyle(C.inkMute, size: 11.5),
                                      ),
                                    ],
                                  ),
                                ),
                                if (picked)
                                  Icon(Icons.check, size: 18, color: C.primary),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text('MESSAGE', style: eyebrowStyle(C.inkMute)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: C.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: C.line, width: 0.5),
                      ),
                      child: TextField(
                        controller: _noteCtrl,
                        maxLines: 3,
                        style: editorialStyle(C.ink, size: 14),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: GestureDetector(
                onTap: () => setState(() => _sent = true),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: C.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send, size: 16, color: C.primaryInk),
                      const SizedBox(width: 8),
                      Text(
                        'Send request',
                        style: bodyStyle(C.primaryInk, size: 14.5, weight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
              child: Column(
                children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      color: C.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.check, size: 30, color: C.primaryInk),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Request sent.',
                    style: displayStyle(C.ink, size: 26).copyWith(height: 1.05),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ll let you know the moment ${findFriend(_picked)?.name.split(' ').first ?? 'your friend'} responds.',
                    style: editorialStyle(C.inkSoft, size: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      decoration: BoxDecoration(
                        color: C.surface2,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: C.line, width: 0.5),
                      ),
                      child: Text(
                        'Done',
                        style: bodyStyle(C.ink, size: 14, weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
