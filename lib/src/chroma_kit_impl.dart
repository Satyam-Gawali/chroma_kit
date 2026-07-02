import 'package:flutter/material.dart';

final List<({String name, Color color})> _materialColorPalette =
    <({String name, Color color})>[
      ..._materialColorShades('Red', Colors.red),
      ..._materialColorShades('Pink', Colors.pink),
      ..._materialColorShades('Purple', Colors.purple),
      ..._materialColorShades('Deep Purple', Colors.deepPurple),
      ..._materialColorShades('Indigo', Colors.indigo),
      ..._materialColorShades('Blue', Colors.blue),
      ..._materialColorShades('Light Blue', Colors.lightBlue),
      ..._materialColorShades('Cyan', Colors.cyan),
      ..._materialColorShades('Teal', Colors.teal),
      ..._materialColorShades('Green', Colors.green),
      ..._materialColorShades('Light Green', Colors.lightGreen),
      ..._materialColorShades('Lime', Colors.lime),
      ..._materialColorShades('Yellow', Colors.yellow),
      ..._materialColorShades('Amber', Colors.amber),
      ..._materialColorShades('Orange', Colors.orange),
      ..._materialColorShades('Deep Orange', Colors.deepOrange),
      ..._materialColorShades('Brown', Colors.brown),
      ..._materialColorShades('Grey', Colors.grey),
      ..._materialColorShades('Blue Grey', Colors.blueGrey),
    ];

List<({String name, Color color})> _materialColorShades(
  String colorName,
  MaterialColor materialColor,
) {
  const shades = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  return shades
      .map((int shade) => (name: '$colorName $shade', color: materialColor[shade]!))
      .toList(growable: false);
}

int _stableStringHash(String text) {
  int hash = 0;
  for (final int codeUnit in text.codeUnits) {
    hash = ((hash * 31) + codeUnit) & 0x7fffffff;
  }
  return hash;
}

double _clampDouble(double value, double min, double max) {
  return value.clamp(min, max).toDouble();
}

double _shiftHue(double hue, double degrees) {
  final double shiftedHue = (hue + degrees) % 360;
  return shiftedHue < 0 ? shiftedHue + 360 : shiftedHue;
}

Color _generateSecondary(HSLColor source, Brightness brightness) {
  final double saturation = _clampDouble(source.saturation * 0.82, 0.28, 0.72);
  final double lightness = brightness == Brightness.light
      ? _clampDouble((source.lightness * 0.92) + 0.02, 0.36, 0.56)
      : _clampDouble(0.60 + ((source.lightness - 0.5) * 0.18), 0.58, 0.74);

  return source
      .withHue(_shiftHue(source.hue, 30))
      .withSaturation(saturation)
      .withLightness(lightness)
      .toColor();
}

Color _generateTertiary(HSLColor source, Brightness brightness) {
  final double saturation =
      _clampDouble(source.saturation + 0.08, 0.45, 0.88);
  final double lightness = brightness == Brightness.light
      ? _clampDouble((source.lightness * 0.95) + 0.01, 0.36, 0.58)
      : _clampDouble(0.64 + ((source.lightness - 0.5) * 0.18), 0.60, 0.78);

  return source
      .withHue(_shiftHue(source.hue, 65))
      .withSaturation(saturation)
      .withLightness(lightness)
      .toColor();
}

Color _generateContainer(
  HSLColor source,
  Brightness brightness, {
  double lightBias = 0.0,
  double saturationOffset = -0.04,
}) {
  final HSLColor adjustedSource = source.withSaturation(
    _clampDouble(source.saturation + saturationOffset, 0.20, 0.95),
  );

  final double lightness = brightness == Brightness.light
      ? _clampDouble(
          0.84 + lightBias + ((1.0 - adjustedSource.saturation) * 0.05),
          0.78,
          0.94,
        )
      : _clampDouble(
          0.24 + lightBias + (adjustedSource.saturation * 0.06),
          0.18,
          0.36,
        );

  return adjustedSource.withLightness(lightness).toColor();
}

Color _generateSurface(
  HSLColor source,
  Brightness brightness, {
  required double lightness,
}) {
  final double saturation = brightness == Brightness.light
      ? _clampDouble(source.saturation * 0.10, 0.02, 0.08)
      : _clampDouble(source.saturation * 0.14, 0.03, 0.10);

  return source
      .withSaturation(saturation)
      .withLightness(_clampDouble(lightness, 0.0, 1.0))
      .toColor();
}

Color _generateOutline(
  HSLColor source,
  Brightness brightness, {
  bool isVariant = false,
}) {
  final double saturation = _clampDouble(
    source.saturation * (isVariant ? 0.22 : 0.30),
    0.05,
    0.20,
  );
  final double lightness = brightness == Brightness.light
      ? (isVariant ? 0.78 : 0.55)
      : (isVariant ? 0.32 : 0.64);

  return source
      .withSaturation(saturation)
      .withLightness(lightness)
      .toColor();
}

Color _resolveOnColor(Color background) {
  if (background.a < 0.2) return Colors.black;

  final Color preferred = background.contrastColor;
  if (background.contrastRatio(preferred) >= 4.5) {
    return preferred;
  }

  final Color alternate = preferred == Colors.white ? Colors.black : Colors.white;
  return background.contrastRatio(alternate) >
          background.contrastRatio(preferred)
      ? alternate
      : preferred;
}

/// Utility helpers for generating and transforming colors.
final class ChromaKitUtils {
  ChromaKitUtils._();

  /// Generates a deterministic opaque [Color] from a string.
  ///
  /// The same [text] always produces the same color. This uses [HSLColor]
  /// internally, deriving hue from a stable hash value while keeping
  /// saturation and lightness in balanced ranges for UI-friendly results.
  ///
  /// Example:
  /// ```dart
  /// ChromaKitUtils.fromString('Satyam')
  /// ```
  ///
  /// Example:
  /// ```dart
  /// ChromaKitUtils.fromString('Flutter')
  /// ```
  static Color fromString(String text) {
    final int hash = _stableStringHash(text);
    final double hue = (hash % 360).toDouble();
    final double saturation = 0.5 + (((hash ~/ 360) % 31) / 100);
    final double lightness = 0.4 + (((hash ~/ (360 * 31)) % 31) / 100);

    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  /// Generates a deterministic avatar-friendly [Color] from an identifier.
  ///
  /// This builds on [fromString] to keep the same identifier mapped to the
  /// same result while nudging saturation and lightness into a pleasant range
  /// for chat apps and user avatars. The returned color is always opaque and
  /// avoids pure white and pure black.
  ///
  /// Example:
  /// ```dart
  /// ChromaKitUtils.avatarColor('user_123')
  /// ```
  static Color avatarColor(String identifier) {
    final HSLColor baseColor = HSLColor.fromColor(fromString(identifier));

    return baseColor
        .withSaturation(baseColor.saturation.clamp(0.55, 0.75))
        .withLightness(baseColor.lightness.clamp(0.45, 0.65))
        .toColor();
  }
}

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

  /// Checks if the color is light based on its luminance value.
  ///
  /// This returns the opposite of [isDark].
  bool get isLight => !isDark;

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

  /// Creates a darker, theme-friendly variant of this color for dark UIs.
  ///
  /// This uses [HSLColor] internally to preserve the original hue as much as
  /// possible while reducing lightness and keeping the result vibrant.
  /// The generated color never drops to pure black, making it suitable for
  /// surfaces, accents, and highlights in dark themes.
  ///
  /// Example:
  /// ```dart
  /// Colors.blue.darkModeVariant()
  /// ```
  ///
  /// Example:
  /// ```dart
  /// Colors.amber.darkModeVariant()
  /// ```
  Color darkModeVariant() {
    final HSLColor hsl = HSLColor.fromColor(this);
    final double targetLightness = hsl.lightness > 0.7
        ? 0.34
        : hsl.lightness > 0.45
        ? (hsl.lightness * 0.6).clamp(0.18, 0.38)
        : (hsl.lightness * 0.8).clamp(0.16, 0.36);
    final double targetSaturation = hsl.saturation < 0.35
        ? (hsl.saturation + 0.2).clamp(0.0, 1.0)
        : (hsl.saturation + 0.08).clamp(0.0, 1.0);

    return hsl
        .withLightness(targetLightness)
        .withSaturation(targetSaturation)
        .toColor();
  }

  /// Creates a Material-style [BoxShadow] using this color.
  ///
  /// The source color is preserved and only its alpha is adjusted using
  /// [opacity], which is clamped between `0.0` and `1.0`.
  ///
  /// Example:
  /// ```dart
  /// Colors.blue.shadow()
  /// ```
  ///
  /// Example:
  /// ```dart
  /// Colors.red.shadow(
  ///   blurRadius: 20,
  ///   opacity: 0.4,
  /// )
  /// ```
  BoxShadow shadow({
    double blurRadius = 12,
    double spreadRadius = 0,
    Offset offset = const Offset(0, 4),
    double opacity = 0.25,
  }) {
    return BoxShadow(
      color: withValues(alpha: opacity.clamp(0.0, 1.0)),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: offset,
    );
  }

  /// Generates a complete Material 3 [ColorScheme] from this color.
  ///
  /// The source color is preserved as the scheme's [ColorScheme.primary] color.
  /// Related roles are created with [HSLColor] to keep the hue recognizable
  /// while producing balanced secondary, tertiary, container, surface, and
  /// outline colors for the requested [brightness].
  ///
  /// Example:
  /// ```dart
  /// final scheme = Colors.deepPurple.generateColorScheme();
  /// ```
  ///
  /// Example:
  /// ```dart
  /// ThemeData(
  ///   colorScheme: Colors.deepPurple.generateColorScheme(
  ///     brightness: Brightness.dark,
  ///   ),
  ///   useMaterial3: true,
  /// );
  /// ```
  ColorScheme generateColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    // 1. Core initialization and seed conversion
    final Color seedColor = withValues(alpha: 1.0);
    final HSLColor source = HSLColor.fromColor(seedColor);
    final Brightness inverseBrightness = brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    // 2. Primary Accent Role Generation
    final Color primary = seedColor;
    final Color primaryContainer = _generateContainer(
      source,
      brightness,
      lightBias: brightness == Brightness.light ? 0.02 : 0.0,
      saturationOffset: -0.02,
    );

    // 3. Secondary Accent Role Generation
    final Color secondary = _generateSecondary(source, brightness);
    final HSLColor secondarySource = HSLColor.fromColor(secondary);
    final Color secondaryContainer = _generateContainer(
      secondarySource,
      brightness,
      lightBias: brightness == Brightness.light ? 0.01 : -0.01,
      saturationOffset: -0.05,
    );

    // 4. Tertiary Accent Role Generation
    final Color tertiary = _generateTertiary(source, brightness);
    final HSLColor tertiarySource = HSLColor.fromColor(tertiary);
    final Color tertiaryContainer = _generateContainer(
      tertiarySource,
      brightness,
      lightBias: brightness == Brightness.light ? 0.0 : -0.01,
      saturationOffset: -0.06,
    );

    // 5. Baseline Surface Roles
    final Color surface = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.98 : 0.06,
    );
    final Color surfaceDim = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.87 : 0.05,
    );
    final Color surfaceBright = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.99 : 0.24,
    );

    // 6. Material 3 Tonal Surface Containers
    final Color surfaceContainerLowest = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 1.0 : 0.04,
    );
    final Color surfaceContainerLow = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.96 : 0.10,
    );
    final Color surfaceContainer = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.94 : 0.12,
    );
    final Color surfaceContainerHigh = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.92 : 0.17,
    );
    final Color surfaceContainerHighest = _generateSurface(
      source,
      brightness,
      lightness: brightness == Brightness.light ? 0.90 : 0.22,
    );

    // 7. Outline & Separation Roles
    final Color outline = _generateOutline(source, brightness);
    final Color outlineVariant = _generateOutline(
      source,
      brightness,
      isVariant: true,
    );

    // 8. Semantic Error State Roles
    final HSLColor errorSource = HSLColor.fromColor(Colors.red.shade700);
    final Color error = brightness == Brightness.light
        ? errorSource.withLightness(0.42).toColor()
        : errorSource.withLightness(0.72).toColor();
    final Color errorContainer = _generateContainer(
      HSLColor.fromColor(error),
      brightness,
      lightBias: brightness == Brightness.light ? 0.01 : -0.01,
      saturationOffset: -0.03,
    );

    // 9. Adaptive Inverse Layout Roles
    final Color inverseSurface = _generateSurface(
      source,
      inverseBrightness,
      lightness: inverseBrightness == Brightness.light ? 0.92 : 0.20,
    );
    final Color inversePrimary = _generateContainer(
      source,
      inverseBrightness,
      lightBias: inverseBrightness == Brightness.light ? -0.02 : 0.03,
      saturationOffset: 0.0,
    );

    // 10. Fixed Token Calculation (Maintains high luminance invariant of theme brightness)
    final Color primaryFixed = source.withLightness(0.90).toColor();
    final Color primaryFixedDim = source.withLightness(0.80).toColor();
    final Color secondaryFixed = secondarySource.withLightness(0.90).toColor();
    final Color secondaryFixedDim = secondarySource.withLightness(0.80).toColor();
    final Color tertiaryFixed = tertiarySource.withLightness(0.90).toColor();
    final Color tertiaryFixedDim = tertiarySource.withLightness(0.80).toColor();

    // 11. Final ColorScheme construction mapping all 38 semantic tokens
    return ColorScheme(
      brightness: brightness,

      // Primary Accent Matrix
      primary: primary,
      onPrimary: _resolveOnColor(primary),
      primaryContainer: primaryContainer,
      onPrimaryContainer: _resolveOnColor(primaryContainer),

      // Secondary Accent Matrix
      secondary: secondary,
      onSecondary: _resolveOnColor(secondary),
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: _resolveOnColor(secondaryContainer),

      // Tertiary Accent Matrix
      tertiary: tertiary,
      onTertiary: _resolveOnColor(tertiary),
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: _resolveOnColor(tertiaryContainer),

      // Error State Matrix
      error: error,
      onError: _resolveOnColor(error),
      errorContainer: errorContainer,
      onErrorContainer: _resolveOnColor(errorContainer),

      // Structural Surfaces
      surface: surface,
      onSurface: _resolveOnColor(surface),
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,

      // Material 3 Progressive Containers
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: _resolveOnColor(surfaceContainerHighest),

      // Outlines & Utility Overlays
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: inverseSurface,
      onInverseSurface: _resolveOnColor(inverseSurface),
      inversePrimary: inversePrimary,
      surfaceTint: primary,

      // Material 3 Fixed Roles (Theme Invariant Tokens)
      primaryFixed: primaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixed: source.withLightness(0.10).toColor(),
      onPrimaryFixedVariant: source.withLightness(0.30).toColor(),

      secondaryFixed: secondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixed: secondarySource.withLightness(0.10).toColor(),
      onSecondaryFixedVariant: secondarySource.withLightness(0.30).toColor(),

      tertiaryFixed: tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixed: tertiarySource.withLightness(0.10).toColor(),
      onTertiaryFixedVariant: tertiarySource.withLightness(0.30).toColor(),
    );
  }

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

  /// Returns the name of the nearest Flutter Material color shade.
  ///
  /// This compares the current color against all shades in the Material color
  /// palette using RGB distance and returns the closest match.
  ///
  /// Example:
  /// ```dart
  /// Colors.blue.nearestMaterialColorName
  /// ```
  ///
  /// Example:
  /// ```dart
  /// Colors.red.nearestMaterialColorName
  /// ```
  String get nearestMaterialColorName {
    final double red = r;
    final double green = g;
    final double blue = b;
    ({String name, Color color}) nearest = _materialColorPalette.first;
    double shortestDistance = double.infinity;

    for (final candidate in _materialColorPalette) {
      final double redDiff = red - candidate.color.r;
      final double greenDiff = green - candidate.color.g;
      final double blueDiff = blue - candidate.color.b;
      final double distance =
          (redDiff * redDiff) + (greenDiff * greenDiff) + (blueDiff * blueDiff);

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearest = candidate;
      }
    }

    return nearest.name;
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
