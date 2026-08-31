import 'package:flutter/material.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static const Color seed = Color(0xFF7C2CFF);
  static const Color lime = Color(0xFFB7FF2A);

  static ThemeData get light => _build(
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light).copyWith(
          secondary: lime,
          onSecondary: const Color(0xFF111111),
          surface: const Color(0xFFF9F7FF),
          surfaceContainer: const Color(0xFFF1ECFA),
          surfaceContainerHighest: const Color(0xFFE7DDF7),
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
