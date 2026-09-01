import 'package:flutter/material.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static const Color seed = Color(0xFF7C2CFF);
  static const Color lime = Color(0xFFB7FF2A);

  static ThemeData get light => _build(
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light).copyWith(
          primary: const Color(0xFF7438F5),
          onPrimary: Colors.white,
          secondary: lime,
          onSecondary: const Color(0xFF17131F),
          surface: const Color(0xFFFDFCFF),
          onSurface: const Color(0xFF17131F),
          surfaceContainer: const Color(0xFFFFFFFF),
          surfaceContainerHighest: const Color(0xFFF4F0FA),
          outline: const Color(0xFFD9D2E3),
          outlineVariant: const Color(0xFFE9E3F0),
        ),
        AppTokens.light,
      );

  static ThemeData get dark => _build(
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark).copyWith(
          primary: const Color(0xFF9D66FF),
          secondary: lime,
          onSecondary: const Color(0xFF111111),
          surface: const Color(0xFF100B1E),
          surfaceContainer: const Color(0xFF191127),
          surfaceContainerHighest: const Color(0xFF281A3D),
        ),
        AppTokens.dark,
      );

  static ThemeData _build(ColorScheme scheme, AppTokens tokens) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      extensions: <ThemeExtension<dynamic>>[tokens],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(58),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
    );
  }
}
