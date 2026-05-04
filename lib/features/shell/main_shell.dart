import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/data/mock_data.dart';
import '../../core/theme/rm_theme.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/library/screens/library_screen.dart';
import '../../features/friends/screens/friends_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/book_detail/screens/book_detail_screen.dart';
import '../../widgets/add_book_sheet.dart';
import '../../widgets/request_sheet.dart';

enum _Nav { home, library, friends, profile }

class _AppView {
  final String? bookId;
  final String? friendId;
  const _AppView({this.bookId, this.friendId});
  bool get isBook => bookId != null;
  bool get isFriend => friendId != null;
}

class MainShell extends StatefulWidget {
  final bool isDark;

  const MainShell({super.key, this.isDark = false});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  _Nav _tab = _Nav.home;
  _AppView? _view;
  String? _requestBookId;

  void _openBook(String id) => setState(() {
        _view = _AppView(bookId: id);
        _requestBookId = id;
      });
  void _openFriend(String id) => setState(() => _view = _AppView(friendId: id));
  void _back() => setState(() => _view = null);

  void _showAddBook() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RmTheme(
        colors: RmTheme.of(context),
        isDark: widget.isDark,
        child: const AddBookSheet(),
      ),
    );
  }

  void _showRequest() {
    final book = _requestBookId != null
        ? findBook(_requestBookId!)
        : kBooks[2];
    if (book == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RmTheme(
        colors: RmTheme.of(context),
        isDark: widget.isDark,
        child: RequestSheet(book: book),
      ),
    );
  }

  Widget _buildScreen() {
    if (_view != null) {
      if (_view!.isBook) {
        final book = findBook(_view!.bookId!);
        if (book != null) {
          return BookDetailScreen(
            book: book,
            onBack: _back,
            onRequest: _showRequest,
          );
        }
      }
      if (_view!.isFriend) {
        final friend = findFriend(_view!.friendId!);
        if (friend != null) {
          return ProfileScreen(
            friend: friend,
            isFriend: true,
            onBack: _back,
            onOpenBook: _openBook,
            onRequest: _showRequest,
          );
        }
      }
    }
    switch (_tab) {
      case _Nav.home:
        return HomeScreen(onOpenBook: _openBook, onOpenFriend: _openFriend);
      case _Nav.library:
        return LibraryScreen(onOpenBook: _openBook);
      case _Nav.friends:
        return FriendsScreen(onOpenFriend: _openFriend);
      case _Nav.profile:
        return ProfileScreen(onOpenBook: _openBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: widget.isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: C.bg,
        body: Stack(
          children: [
            _buildScreen(),
            // Tab bar
            if (_view == null) _buildTabBar(C),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(RmColors C) {
    return Positioned(
      left: 12,
      right: 12,
      bottom: 22,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: C.tabBg,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: C.glassBorder, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 30,
              spreadRadius: -12,
              offset: Offset(0, 12),
            ),
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Row(
              children: [
                const SizedBox(width: 6),
                _TabItem(C: C, icon: Icons.rss_feed_rounded, label: 'Feed',
                    active: _tab == _Nav.home, onTap: () => _setTab(_Nav.home)),
                _TabItem(C: C, icon: Icons.library_books_outlined, label: 'Library',
                    active: _tab == _Nav.library, onTap: () => _setTab(_Nav.library)),
                // Plus button
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: _showAddBook,
                      child: Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: C.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: C.primary.withValues(alpha: 0.67),
                              blurRadius: 18,
                              spreadRadius: -6,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.add, size: 22, color: C.primaryInk),
                        ),
                      ),
                    ),
                  ),
                ),
                _TabItem(C: C, icon: Icons.people_outline, label: 'Friends',
                    active: _tab == _Nav.friends, onTap: () => _setTab(_Nav.friends)),
                _TabItem(C: C, icon: Icons.person_outline, label: 'You',
                    active: _tab == _Nav.profile, onTap: () => _setTab(_Nav.profile)),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setTab(_Nav t) => setState(() {
        _view = null;
        _tab = t;
      });
}


class _TabItem extends StatelessWidget {
  final RmColors C;
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({
    required this.C,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: active ? C.primary : C.inkMute,
            ),
            const SizedBox(height: 3),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: active ? C.primary : C.inkMute,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
