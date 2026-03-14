import 'package:flutter/material.dart';

/// [ChromaKit] provides a robust set of utilities for
/// dynamic color manipulation in Flutter.
///
/// Use this extension to handle design challenges like creating
/// pastel shades, WCAG accessibility, and Material swatches.
extension ChromaKit on Color {
  // ==========================================================================
  // 1. OPACITY & TINTING
  // ==========================================================================

  /// Adjusts the alpha channel based on a [fraction] (0.0 to 1.0).
  ///
  /// Example: `Colors.blue.transparency(0.5)`
  Color transparency(double fraction) {
    return withValues(alpha: fraction.clamp(0.0, 1.0));
  }

  /// **Deprecated**: Use [transparency] instead.
  ///
  /// Adjusts the alpha channel of the color based on a [fraction].
  /// This alias is kept for backward compatibility and may be removed in a future release.
  @Deprecated(
      'Use transparency(fraction) instead. This alias may be removed in a future release.')
  Color withOpacityFraction(double fraction) => transparency(fraction);

  /// Blends the color with pure white to create a solid pastel tint.
  ///
  /// [factor] : 0.0 (original) to 1.0 (pure white).
  /// Defaults to 0.9 for a soft pastel look.
  Color pastel([double factor = 0.9]) {
    final double safeFactor = factor.clamp(0.0, 1.0);
    final Color blended = Color.lerp(this, Colors.white, safeFactor) ?? this;
    return blended.withValues(alpha: a);
  }

  /// @Deprecated: Use [pastel] instead.
  @Deprecated('Use pastel() instead. This will be removed in v2.0.0')
  Color faint([double factor = 0.9]) => pastel(factor);

  // ==========================================================================
  // 2. ADVANCED BLENDING
  // ==========================================================================

  /// Blends the color with a specific [other] color.
  ///
  /// [factor] : Degree of blending (0.0 = self, 1.0 = other).
  Color blendWith(Color other, [double factor = 0.5]) {
    final Color blended =
        Color.lerp(this, other, factor.clamp(0.0, 1.0)) ?? this;
    return blended.withValues(alpha: a);
  }

  /// @Deprecated: Use [blendWith] instead.
  @Deprecated('Use blendWith() instead. This will be removed in v2.0.0')
  Color faintWith(Color other, [double factor = 0.5]) =>
      blendWith(other, factor);

  /// Blends the color with the average of a list of [others].
  ///
  /// Useful for creating dynamic UI themes that match a collection of images/colors.
  Color blendMany(List<Color> others, [double factor = 0.5]) {
    if (others.isEmpty) return pastel(factor);
    int rSum = 0, gSum = 0, bSum = 0;
    for (var c in others) {
      rSum += c.r.toInt();
      gSum += c.g.toInt();
      bSum += c.b.toInt();
    }
    final Color avgColor = Color.fromARGB(
      a.toInt(), // Keeping original alpha as suggested
      rSum ~/ others.length,
      gSum ~/ others.length,
      bSum ~/ others.length,
    );
    return blendWith(avgColor, factor);
  }

  /// @Deprecated: Use [blendMany] instead.
  @Deprecated('Use blendMany() instead. This will be removed in v2.0.0')
  Color faintWiths(List<Color> others, [double factor = 0.5]) =>
      blendMany(others, factor);

  // ==========================================================================
  // 3. ADAPTIVE UI & ACCESSIBILITY
  // ==========================================================================

  /// Returns [Colors.black] or [Colors.white] depending on brightness.
  ///
  /// Automatically handles high transparency by defaulting to black if alpha < 0.2.
  Color get contrastColor {
    if (a < 0.2) return Colors.black;
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  /// Checks if the color is dark based on its luminance value.
  bool get isDark => computeLuminance() < 0.5;

  /// Calculates the WCAG contrast ratio between this color and [other].
  ///
  /// Returns a value between 1.0 and 21.0.
  double contrastRatio(Color other) {
    final l1 = computeLuminance();
    final l2 = other.computeLuminance();
    final brightest = l1 > l2 ? l1 : l2;
    final darkest = l1 > l2 ? l2 : l1;
    return (brightest + 0.05) / (darkest + 0.05);
  }

  /// Checks if this color (as text) is accessible on a given [background].
  ///
  /// - Normal text requires a ratio of 4.5:1
  /// - Large text requires a ratio of 3.0:1
  bool isAccessibleOn(Color background, {bool largeText = false}) {
    final ratio = contrastRatio(background);
    return largeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  // ==========================================================================
  // 4. SHADE & MATERIAL MANIPULATION
  // ==========================================================================

  /// Darkens the color by blending it with black.
  Color darken([double factor = 0.1]) => blendWith(Colors.black, factor);

  /// Lightens the color by blending it with white.
  Color lighten([double factor = 0.1]) => blendWith(Colors.white, factor);

  /// Generates a [MaterialColor] swatch based on this color.
  ///
  /// Perfect for setting `primarySwatch` in Flutter's [ThemeData].
  MaterialColor toMaterialColor() {
    return MaterialColor(toARGB32(), {
      50: lighten(0.45),
      100: lighten(0.40),
      200: lighten(0.30),
      300: lighten(0.20),
      400: lighten(0.10),
      500: this,
      600: darken(0.10),
      700: darken(0.20),
      800: darken(0.30),
      900: darken(0.40),
    });
  }

  // ==========================================================================
  // 5. HEX CONVERSION
  // ==========================================================================

  /// Returns the color in Hexadecimal string format (e.g., #FF6200EE).
  String toHex({bool includeHash = true}) {
    final String hex =
        toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    return includeHash ? '#$hex' : hex;
  }

  /// Safely creates a [Color] from a hex string.
  ///
  /// Supports: #RGB, #RRGGBB, #AARRGGBB formats.
  static Color fromHex(String hexString) {
    try {
      String cleanHex = hexString.replaceAll('#', '').trim();
      if (cleanHex.length == 3) {
        cleanHex = cleanHex.split('').map((c) => '$c$c').join();
      }
      final buffer = StringBuffer();
      if (cleanHex.length == 6) buffer.write('FF');
      buffer.write(cleanHex);
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      debugPrint('[ChromaKit] Invalid hex: $hexString. Defaulting to black.');
      return Colors.black;
    }
  }
}
