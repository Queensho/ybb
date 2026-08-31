import 'package:flutter/material.dart';
import 'app_tokens.dart';

extension ThemeContextX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get texts => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  AppTokens get tokens => Theme.of(this).extension<AppTokens>() ?? AppTokens.light;
}
