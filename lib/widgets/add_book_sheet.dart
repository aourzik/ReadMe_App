import 'package:flutter/material.dart';
import '../core/data/mock_data.dart';
import '../core/models/book.dart';
import '../core/theme/rm_theme.dart';
import 'book_cover.dart';
import 'star_rating.dart';

class AddBookSheet extends StatefulWidget {
  const AddBookSheet({super.key});

  @override
  State<AddBookSheet> createState() => _AddBookSheetState();
}

class _AddBookSheetState extends State<AddBookSheet> {
  final _titleCtrl = TextEditingController(text: 'A Quiet Architecture');
  final _authorCtrl = TextEditingController(text: 'Ines Vidal');
  int _rating = 5;
  final _reviewCtrl = TextEditingController();
  String _selectedShelf = 'Finished';

  final _shelves = ['Currently reading', 'Finished', 'Wishlist', 'Lent out'];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    _reviewCtrl.dispose();
    super.dispose();
  }

  Book get _previewBook => Book(
    id: 'new',
    title: _titleCtrl.text.isEmpty ? 'New Book' : _titleCtrl.text,
    author: _authorCtrl.text.isEmpty ? 'Author' : _authorCtrl.text,
    palette: const [Color(0xFF0E330A), Color(0xFFF6FADD)],
    coverStyle: BookCoverStyle.serif,
    rating: _rating.toDouble(),
    year: 2024,
    pages: 0,
  );

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 6),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text('Cancel', style: bodyStyle(C.inkSoft, size: 14)),
                ),
                const Spacer(),
                Text('Add a book', style: displayStyle(C.ink, size: 22)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text('Save', style: bodyStyle(C.primary, size: 14, weight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover preview
                  Container(
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: C.line, width: 0.5),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        BookCover(book: _previewBook, width: 80, height: 120),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('COVER', style: eyebrowStyle(C.accent)),
                              const SizedBox(height: 4),
                              Text(
                                'Auto-fetched from the catalog. Tap to upload your own.',
                                style: bodyStyle(C.inkSoft, size: 13).copyWith(height: 1.4),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _MiniBtn(C: C, label: 'Find', icon: Icons.search, primary: true),
                                  const SizedBox(width: 6),
                                  _MiniBtn(C: C, label: 'Upload', icon: Icons.camera_alt_outlined),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  _FieldLabel(C: C, label: 'Title'),
                  _InputField(controller: _titleCtrl, C: C),
                  _FieldLabel(C: C, label: 'Author'),
                  _InputField(controller: _authorCtrl, C: C),

                  _FieldLabel(C: C, label: 'Your rating'),
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        final n = i + 1;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = n),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: Icon(
                              n <= _rating ? Icons.star : Icons.star_border,
                              size: 32,
                              color: n <= _rating ? C.star : C.line,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        ['', 'Pass', 'Mixed', 'Good', 'Great', 'Loved it'][_rating],
                        style: editorialStyle(C.inkSoft, size: 14),
                      ),
                    ],
                  ),

                  _FieldLabel(C: C, label: 'Review'),
                  Container(
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: C.line, width: 0.5),
                    ),
                    child: TextField(
                      controller: _reviewCtrl,
                      maxLines: 4,
                      style: editorialStyle(C.ink, size: 14.5),
                      decoration: InputDecoration(
                        hintText: 'A few honest sentences…',
                        hintStyle: editorialStyle(C.inkMute, size: 14.5),
                        contentPadding: const EdgeInsets.all(14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  _FieldLabel(C: C, label: 'Shelf'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _shelves.map((s) {
                      final active = s == _selectedShelf;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedShelf = s),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: active ? C.primary : C.surface,
                            borderRadius: BorderRadius.circular(100),
                            border: active ? null : Border.all(color: C.line, width: 0.5),
                          ),
                          child: Text(
                            s,
                            style: bodyStyle(
                              active ? C.primaryInk : C.ink,
                              size: 13, weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final RmColors C;
  final String label;
  const _FieldLabel({required this.C, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(label.toUpperCase(), style: eyebrowStyle(C.inkMute)),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final RmColors C;
  const _InputField({required this.controller, required this.C});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.line, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        style: bodyStyle(C.ink, size: 14.5),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _MiniBtn extends StatelessWidget {
  final RmColors C;
  final String label;
  final IconData icon;
  final bool primary;
  const _MiniBtn({required this.C, required this.label, required this.icon, this.primary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: primary ? C.primary : C.surface2,
        borderRadius: BorderRadius.circular(100),
        border: primary ? null : Border.all(color: C.line, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: primary ? C.primaryInk : C.ink),
          const SizedBox(width: 5),
          Text(label, style: bodyStyle(primary ? C.primaryInk : C.ink, size: 12, weight: FontWeight.w500)),
        ],
      ),
    );
  }
}
