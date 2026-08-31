import 'package:flutter/material.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.spaceXs,
    required this.spaceSm,
    required this.spaceMd,
    required this.spaceLg,
    required this.spaceXl,
    required this.radius,
    required this.radiusLg,
    required this.success,
    required this.warning,
    required this.lime,
  });

  final double spaceXs;
  final double spaceSm;
  final double spaceMd;
  final double spaceLg;
  final double spaceXl;
  final double radius;
  final double radiusLg;
  final Color success;
  final Color warning;
  final Color lime;

  static const light = AppTokens(
    spaceXs: 4,
    spaceSm: 8,
    spaceMd: 16,
    spaceLg: 24,
    spaceXl: 32,
    radius: 16,
    radiusLg: 32,
    success: Color(0xFF22C55E),
    warning: Color(0xFFF59E0B),
    lime: Color(0xFFB7FF2A),
  );

  static const dark = AppTokens(
    spaceXs: 4,
    spaceSm: 8,
    spaceMd: 16,
    spaceLg: 24,
    spaceXl: 32,
    radius: 16,
    radiusLg: 32,
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    lime: Color(0xFFB7FF2A),
  );

  @override
  AppTokens copyWith({
    double? spaceXs,
    double? spaceSm,
    double? spaceMd,
    double? spaceLg,
    double? spaceXl,
    double? radius,
    double? radiusLg,
    Color? success,
    Color? warning,
    Color? lime,
  }) {
    return AppTokens(
      spaceXs: spaceXs ?? this.spaceXs,
      spaceSm: spaceSm ?? this.spaceSm,
      spaceMd: spaceMd ?? this.spaceMd,
      spaceLg: spaceLg ?? this.spaceLg,
      spaceXl: spaceXl ?? this.spaceXl,
      radius: radius ?? this.radius,
      radiusLg: radiusLg ?? this.radiusLg,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      lime: lime ?? this.lime,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      spaceXs: lerpDouble(spaceXs, other.spaceXs, t),
      spaceSm: lerpDouble(spaceSm, other.spaceSm, t),
      spaceMd: lerpDouble(spaceMd, other.spaceMd, t),
      spaceLg: lerpDouble(spaceLg, other.spaceLg, t),
      spaceXl: lerpDouble(spaceXl, other.spaceXl, t),
      radius: lerpDouble(radius, other.radius, t),
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t),
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      lime: Color.lerp(lime, other.lime, t) ?? lime,
    );
  }
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;
