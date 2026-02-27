import 'package:flutter/material.dart';

/// [ChromaKit] provides a robust set of utilities for
/// dynamic color manipulation in Flutter.
///
/// This extension handles common design challenges such as creating
/// pastel shades, ensuring accessibility contrast, and safe hex parsing.
/// chroma_kit_impl.dart
extension ChromaKit on Color {
  // ==========================================================================
  // 1. OPACITY & TINTING
  // ==========================================================================

  /// Adjusts the alpha channel of the color based on a [fraction].
  ///
  /// [fraction] : A value between 0.0 (transparent) and 1.0 (opaque).
  /// Edge Case: If input is out of range, it is automatically clamped.
  Color transparency(double fraction) {
    final double safeFraction = fraction.clamp(0.0, 1.0);
    return withValues(alpha: safeFraction);
  }

  /// An alias for transparency for backward compatibility.
  Color withOpacityFraction(double fraction) => transparency(fraction);

  /// Blends the color with pure white to create a solid pastel tint.
  ///
  /// [factor] : 0.0 returns the original color; 1.0 returns pure white.
  /// Result: A non-transparent lighter version of the color.
  Color faint([double factor = 0.9]) {
    final double safeFactor = factor.clamp(0.0, 1.0);
    if (safeFactor == 0.0) return this;

    final Color blended = Color.lerp(this, Colors.white, safeFactor) ?? this;
    // Edge Case: Re-applies original alpha to ensure consistent transparency.
    // Fixed: Using '.a' instead of '.opacity' to resolve static analysis warning.
    return blended.withValues(alpha: a);
  }

  // ==========================================================================
  // 2. ADVANCED BLENDING
  // ==========================================================================

  /// Blends the color with a specific [other] color.
  ///
  /// Useful for "fading" a color into a specific background or surface theme.
  Color faintWith(Color other, [double factor = 0.9]) {
    final double safeFactor = factor.clamp(0.0, 1.0);
    if (safeFactor == 0.0) return this;

    final Color blended = Color.lerp(this, other, safeFactor) ?? this;
    // Fixed: Using '.a' for compatibility with latest Flutter API.
    return blended.withValues(alpha: a);
  }

  /// Blends the color with the calculated average of a list of [others].
  ///
  /// Edge Case: If the list is empty, it defaults to standard [faint] (white blend).
  Color faintWiths(List<Color> others, [double factor = 0.9]) {
    if (others.isEmpty) return faint(factor);

    double rAvg = 0, gAvg = 0, bAvg = 0;
    for (var c in others) {
      rAvg += c.r;
      gAvg += c.g;
      bAvg += c.b;
    }

    // Creates an average color from the provided list.
    final Color avgColor = Color.from(
      alpha: 1.0,
      red: rAvg / others.length,
      green: gAvg / others.length,
      blue: bAvg / others.length,
    );

    return faintWith(avgColor, factor);
  }

  // ==========================================================================
  // 3. ADAPTIVE UI & ACCESSIBILITY
  // ==========================================================================

  /// Returns [Colors.black] or [Colors.white] depending on the color's brightness.
  ///
  /// Edge Case: If the color is highly transparent (alpha < 0.2), it assumes
  /// a light background and returns black for visibility.
  Color get contrastColor {
    // Fixed: Using '.a' to resolve deprecation warning.
    if (a < 0.2) return Colors.black;
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  /// Checks if the color is dark based on its luminance value.
  bool get isDark => computeLuminance() < 0.5;

  // ==========================================================================
  // 4. SHADE MANIPULATION
  // ==========================================================================

  /// Darkens the color by blending it with black.
  Color darken([double factor = 0.1]) {
    return Color.lerp(this, Colors.black, factor.clamp(0.0, 1.0)) ?? this;
  }

  /// Lightens the color by blending it with white.
  Color lighten([double factor = 0.1]) {
    return Color.lerp(this, Colors.white, factor.clamp(0.0, 1.0)) ?? this;
  }

  // ==========================================================================
  // 5. HEX PARSING & CONVERSION
  // ==========================================================================

  /// Returns the color in Hexadecimal string format (e.g., #FF6200EE).
  ///
  /// [includeHash] : Whether to prepend '#' to the result.
  String toHex({bool includeHash = true}) {
    final String hex = toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return includeHash ? '#$hex' : hex;
  }

  /// Safely creates a [Color] from a hex string.
  ///
  /// Edge Cases Handled:
  /// * Removes '#' and extra whitespace.
  /// * Converts shorthand hex (e.g., #FFF) to 8-digit format.
  /// * Error Handling: Returns [Colors.black] if parsing fails.
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
      debugPrint(
        '[ChromaKitColorUtils] fromHex Error: "$hexString" is not valid. Returning black.',
      );
      return Colors.black;
    }
  }
}