import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/rm_theme.dart';
import '../../../core/data/mock_data.dart';
import '../../../widgets/book_cover.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'eleanor@example.com');
  final _passwordController = TextEditingController(text: '••••••••');
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) widget.onLogin();
  }

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    return Scaffold(
      backgroundColor: C.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero top
            Container(
              height: 340,
              color: C.primary,
              padding: const EdgeInsets.fromLTRB(28, 80, 28, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wordmark in primary
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Read',
                        style: GoogleFonts.commissioner(
                          fontSize: 32, fontWeight: FontWeight.w700,
                          color: C.primaryInk, height: 1.0,
                        ),
                      ),
                      Text(
                        '·',
                        style: GoogleFonts.commissioner(
                          fontSize: 32, fontWeight: FontWeight.w700,
                          color: C.accent, height: 1.0,
                        ),
                      ),
                      Text(
                        'Me',
                        style: GoogleFonts.fraunces(
                          fontSize: 32, fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500, color: C.primaryInk, height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Your library, your\nfriends, your shelf.',
                    style: GoogleFonts.fraunces(
                      fontSize: 26, fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400, color: C.primaryInk.withOpacity(0.8),
                      height: 1.2,
                    ),
                  ),
                  const Spacer(),
                  // Stacked book covers
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        for (var i = 0; i < 5; i++)
                          Transform(
                            transform: Matrix4.identity()
                              ..rotateZ(((i - 2) * 0.05)),
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: i == 0 ? 0 : 4,
                                bottom: (2 - i).abs() * 4.0,
                              ),
                              child: BookCover(
                                book: kBooks[[2, 4, 0, 6, 1][i]],
                                width: 52, height: 76,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Sign in',
                    style: displayStyle(C.ink, size: 30),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Welcome back, Eleanor.',
                    style: editorialStyle(C.inkSoft, size: 15),
                  ),
                  const SizedBox(height: 28),

                  _Field(
                    label: 'Email',
                    child: _Input(controller: _emailController, C: C),
                  ),
                  const SizedBox(height: 16),
                  _Field(
                    label: 'Password',
                    child: _Input(
                      controller: _passwordController,
                      C: C,
                      obscure: true,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: bodyStyle(C.accent, size: 13, weight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: _loading ? null : _handleLogin,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: C.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: _loading
                            ? SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, color: C.primaryInk,
                                ),
                              )
                            : Text(
                                'Sign in',
                                style: bodyStyle(C.primaryInk, size: 15,
                                    weight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: bodyStyle(C.inkMute, size: 13),
                        children: [
                          const TextSpan(text: 'No account? '),
                          TextSpan(
                            text: 'Join ReadMe',
                            style: bodyStyle(C.primary, size: 13,
                                weight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
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

class _Field extends StatelessWidget {
  final String label;
  final Widget child;

  const _Field({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final C = RmTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: eyebrowStyle(C.inkMute),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final RmColors C;
  final bool obscure;

  const _Input({
    required this.controller,
    required this.C,
    this.obscure = false,
  });

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
        obscureText: obscure,
        style: bodyStyle(C.ink, size: 14.5),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
