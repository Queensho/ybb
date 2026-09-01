import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'mockups/login/login_screen.dart';

void main() {
  runApp(const YbbMockupApp());
}

class YbbMockupApp extends StatelessWidget {
  const YbbMockupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YBB UX Mockup',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.mode,
        home: const LoginScreen(),
      ),
    );
  }
}
