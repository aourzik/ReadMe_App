import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../widgets/rm_avatar.dart';
import '../../../widgets/rm_icon_button.dart';
import '../../../widgets/section_heading.dart';

class FriendsScreen extends StatelessWidget {
  final void Function(String friendId) onOpenFriend;

  const FriendsScreen({super.key, required this.onOpenFriend});

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 60, 18, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('YOUR CIRCLE', style: eyebrowStyle(C.inkMute)),
                      const SizedBox(height: 4),
                      Text('Friends.', style: displayStyle(C.ink, size: 38)),
                    ],
                  ),
                ),
                RmIconButton(child: const Icon(Icons.add)),
              ],
            ),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: Container(
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: C.line, width: 0.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: C.inkMute),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search by name or @handle',
                      style: bodyStyle(C.inkMute, size: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pending header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PENDING', style: eyebrowStyle(C.accent)),
                Text('2 requests', style: bodyStyle(C.inkMute, size: 11)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Pending requests
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: kRequests.map((r) {
                final f = findFriend(r.fromId)!;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: C.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: C.line, width: 0.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      RmAvatar(initials: f.initials, tone: f.tone, size: 42),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.name,
                              style: bodyStyle(C.ink, size: 14.5, weight: FontWeight.w600),
                            ),
                            Text(
                              '${r.mutual} mutual · ${f.books} books',
                              style: bodyStyle(C.inkMute, size: 12),
                            ),
                          ],
                        ),
                      ),
                      _PillBtn(C: C, primary: true, child: const Icon(Icons.check, size: 14)),
                      const SizedBox(width: 8),
                      _PillBtn(C: C, primary: false, child: const Icon(Icons.close, size: 14)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          SectionHeading(eyebrow: 'From your shelves', title: 'Readers you may know'),

          // Suggested
          SizedBox(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: kSuggested.length,
              itemBuilder: (context, i) {
                final s = kSuggested[i];
                return Container(
                  width: 168,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: C.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: C.line, width: 0.5),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RmAvatar(initials: s.initials, tone: s.tone, size: 56),
                      const SizedBox(height: 8),
                      Text(
                        s.name,
                        style: bodyStyle(C.ink, size: 14, weight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${s.mutual} mutual',
                        style: bodyStyle(C.inkMute, size: 11.5),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: C.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          '+ Add friend',
                          style: bodyStyle(C.primaryInk, size: 12.5, weight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SectionHeading(eyebrow: '28 in total', title: 'Your friends'),

          // Friends list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: Container(
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: C.line, width: 0.5),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: List.generate(kFriends.length, (i) {
                  final f = kFriends[i];
                  return Column(
                    children: [
                      if (i > 0) Divider(color: C.lineSoft, thickness: 0.5, height: 1),
                      GestureDetector(
                        onTap: () => onOpenFriend(f.id),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          child: Row(
                            children: [
                              RmAvatar(initials: f.initials, tone: f.tone, size: 42),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      f.name,
                                      style: bodyStyle(C.ink, size: 14.5, weight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${f.handle} · ${f.books} books · ${f.mutual} mutual',
                                      style: bodyStyle(C.inkMute, size: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 18, color: C.inkMute),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillBtn extends StatelessWidget {
  final RmColors C;
  final bool primary;
  final Widget child;

  const _PillBtn({required this.C, required this.primary, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        color: primary ? C.primary : C.surface2,
        borderRadius: BorderRadius.circular(12),
        border: primary
            ? null
            : Border.all(color: C.line, width: 0.5),
        boxShadow: primary
            ? [BoxShadow(color: Colors.white.withOpacity(0.05), blurRadius: 0)]
            : null,
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(color: primary ? C.primaryInk : C.ink, size: 14),
          child: child,
        ),
      ),
    );
  }
}
