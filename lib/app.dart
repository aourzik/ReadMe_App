import 'package:flutter/material.dart';
import 'core/theme/rm_theme.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/shell/main_shell.dart';

class ReadMeApp extends StatefulWidget {
  const ReadMeApp({super.key});

  @override
  State<ReadMeApp> createState() => _ReadMeAppState();
}

class _ReadMeAppState extends State<ReadMeApp> {
  bool _loggedIn = false;
  final bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final colors = _isDark ? RmColors.dark() : RmColors.light();

    return MaterialApp(
      title: 'ReadMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kGreen,
          brightness: _isDark ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: colors.bg,
      ),
      home: RmTheme(
        colors: colors,
        isDark: _isDark,
        child: _loggedIn
            ? MainShell(isDark: _isDark)
            : LoginScreen(onLogin: () => setState(() => _loggedIn = true)),
      ),
    );
  }
}
