import 'package:chroma_kit/chroma_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

double _clockwiseHueDelta(double from, double to) {
  final double delta = (to - from) % 360;
  return delta < 0 ? delta + 360 : delta;
}

void _expectReadable(Color foreground, Color background) {
  expect(
    foreground.contrastRatio(background),
    greaterThanOrEqualTo(4.5),
  );
}

List<Color> _trackedColors(ColorScheme scheme) {
  return <Color>[
    scheme.primary,
    scheme.onPrimary,
    scheme.primaryContainer,
    scheme.onPrimaryContainer,
    scheme.secondary,
    scheme.onSecondary,
    scheme.secondaryContainer,
    scheme.onSecondaryContainer,
    scheme.tertiary,
    scheme.onTertiary,
    scheme.tertiaryContainer,
    scheme.onTertiaryContainer,
    scheme.surface,
    scheme.onSurface,
    scheme.surfaceContainerLowest,
    scheme.surfaceContainerLow,
    scheme.surfaceContainer,
    scheme.surfaceContainerHigh,
    scheme.surfaceContainerHighest,
    scheme.error,
    scheme.onError,
    scheme.outline,
    scheme.outlineVariant,
    scheme.shadow,
    scheme.scrim,
    scheme.inversePrimary,
    scheme.inverseSurface,
    scheme.onInverseSurface,
  ];
}

void main() {
  const deepPurple = Colors.deepPurple;
  final lightScheme = deepPurple.generateColorScheme();
  final darkScheme = deepPurple.generateColorScheme(
    brightness: Brightness.dark,
  );
  final lightSourceHsl = HSLColor.fromColor(deepPurple);
  final lightSecondaryHsl = HSLColor.fromColor(lightScheme.secondary);
  final lightTertiaryHsl = HSLColor.fromColor(lightScheme.tertiary);
  final darkSecondaryHsl = HSLColor.fromColor(darkScheme.secondary);
  final darkTertiaryHsl = HSLColor.fromColor(darkScheme.tertiary);

  group('generateColorScheme light mode', () {
    test('sets light brightness', () {
      expect(lightScheme.brightness, Brightness.light);
    });

    test('preserves the source color as primary', () {
      expect(lightScheme.primary, deepPurple);
    });

    test('uses readable onPrimary', () {
      _expectReadable(lightScheme.onPrimary, lightScheme.primary);
    });

    test('creates a lighter primary container', () {
      expect(
        lightScheme.primaryContainer.computeLuminance(),
        greaterThan(lightScheme.primary.computeLuminance()),
      );
    });

    test('uses readable onPrimaryContainer', () {
      _expectReadable(
        lightScheme.onPrimaryContainer,
        lightScheme.primaryContainer,
      );
    });

    test('rotates the secondary hue by about 30 degrees', () {
      expect(
        _clockwiseHueDelta(lightSourceHsl.hue, lightSecondaryHsl.hue),
        inInclusiveRange(25.0, 35.0),
      );
    });

    test('slightly reduces secondary saturation', () {
      expect(lightSecondaryHsl.saturation, lessThan(lightSourceHsl.saturation));
    });

    test('uses readable onSecondary', () {
      _expectReadable(lightScheme.onSecondary, lightScheme.secondary);
    });

    test('creates a lighter secondary container', () {
      expect(
        lightScheme.secondaryContainer.computeLuminance(),
        greaterThan(lightScheme.secondary.computeLuminance()),
      );
    });

    test('uses readable onSecondaryContainer', () {
      _expectReadable(
        lightScheme.onSecondaryContainer,
        lightScheme.secondaryContainer,
      );
    });

    test('rotates the tertiary hue by about 65 degrees', () {
      expect(
        _clockwiseHueDelta(lightSourceHsl.hue, lightTertiaryHsl.hue),
        inInclusiveRange(55.0, 75.0),
      );
    });

    test('slightly increases tertiary saturation', () {
      expect(
        lightTertiaryHsl.saturation,
        greaterThan(lightSourceHsl.saturation),
      );
    });

    test('uses readable onTertiary', () {
      _expectReadable(lightScheme.onTertiary, lightScheme.tertiary);
    });

    test('creates a lighter tertiary container', () {
      expect(
        lightScheme.tertiaryContainer.computeLuminance(),
        greaterThan(lightScheme.tertiary.computeLuminance()),
      );
    });

    test('uses readable onTertiaryContainer', () {
      _expectReadable(
        lightScheme.onTertiaryContainer,
        lightScheme.tertiaryContainer,
      );
    });

    test('keeps surface colors near neutral', () {
      expect(
        HSLColor.fromColor(lightScheme.surface).saturation,
        lessThanOrEqualTo(0.12),
      );
    });

    test('orders light surface containers from brightest to darkest', () {
      expect(
        lightScheme.surfaceContainerLowest.computeLuminance(),
        greaterThan(lightScheme.surfaceContainerLow.computeLuminance()),
      );
      expect(
        lightScheme.surfaceContainerLow.computeLuminance(),
        greaterThan(lightScheme.surfaceContainer.computeLuminance()),
      );
      expect(
        lightScheme.surfaceContainer.computeLuminance(),
        greaterThan(lightScheme.surfaceContainerHigh.computeLuminance()),
      );
      expect(
        lightScheme.surfaceContainerHigh.computeLuminance(),
        greaterThan(lightScheme.surfaceContainerHighest.computeLuminance()),
      );
    });

    test('uses readable onSurface', () {
      _expectReadable(lightScheme.onSurface, lightScheme.surface);
    });

    test('reduces saturation for outline colors', () {
      expect(
        HSLColor.fromColor(lightScheme.outline).saturation,
        lessThan(lightSourceHsl.saturation),
      );
      expect(
        HSLColor.fromColor(lightScheme.outlineVariant).saturation,
        lessThan(lightSourceHsl.saturation),
      );
    });

    test('creates a darker inverse surface', () {
      expect(
        lightScheme.inverseSurface.computeLuminance(),
        lessThan(lightScheme.surface.computeLuminance()),
      );
    });

    test('uses readable onInverseSurface', () {
      _expectReadable(
        lightScheme.onInverseSurface,
        lightScheme.inverseSurface,
      );
    });
  });

  group('generateColorScheme dark mode', () {
    test('sets dark brightness', () {
      expect(darkScheme.brightness, Brightness.dark);
    });

    test('preserves the source color as primary', () {
      expect(darkScheme.primary, deepPurple);
    });

    test('uses readable onPrimary', () {
      _expectReadable(darkScheme.onPrimary, darkScheme.primary);
    });

    test('creates a darker primary container than the light scheme', () {
      expect(
        darkScheme.primaryContainer.computeLuminance(),
        lessThan(lightScheme.primaryContainer.computeLuminance()),
      );
    });

    test('uses readable onPrimaryContainer', () {
      _expectReadable(
        darkScheme.onPrimaryContainer,
        darkScheme.primaryContainer,
      );
    });

    test('rotates the dark secondary hue by about 30 degrees', () {
      expect(
        _clockwiseHueDelta(lightSourceHsl.hue, darkSecondaryHsl.hue),
        inInclusiveRange(25.0, 35.0),
      );
    });

    test('uses readable onSecondary', () {
      _expectReadable(darkScheme.onSecondary, darkScheme.secondary);
    });

    test('creates a darker secondary container than the light scheme', () {
      expect(
        darkScheme.secondaryContainer.computeLuminance(),
        lessThan(lightScheme.secondaryContainer.computeLuminance()),
      );
    });

    test('uses readable onSecondaryContainer', () {
      _expectReadable(
        darkScheme.onSecondaryContainer,
        darkScheme.secondaryContainer,
      );
    });

    test('rotates the dark tertiary hue by about 65 degrees', () {
      expect(
        _clockwiseHueDelta(lightSourceHsl.hue, darkTertiaryHsl.hue),
        inInclusiveRange(55.0, 75.0),
      );
    });

    test('uses readable onTertiary', () {
      _expectReadable(darkScheme.onTertiary, darkScheme.tertiary);
    });

    test('creates a darker tertiary container than the light scheme', () {
      expect(
        darkScheme.tertiaryContainer.computeLuminance(),
        lessThan(lightScheme.tertiaryContainer.computeLuminance()),
      );
    });

    test('uses readable onTertiaryContainer', () {
      _expectReadable(
        darkScheme.onTertiaryContainer,
        darkScheme.tertiaryContainer,
      );
    });

    test('keeps dark surface colors near neutral', () {
      expect(
        HSLColor.fromColor(darkScheme.surface).saturation,
        lessThanOrEqualTo(0.15),
      );
    });

    test('orders dark surface containers from darkest to brightest', () {
      expect(
        darkScheme.surfaceContainerLowest.computeLuminance(),
        lessThan(darkScheme.surfaceContainerLow.computeLuminance()),
      );
      expect(
        darkScheme.surfaceContainerLow.computeLuminance(),
        lessThan(darkScheme.surfaceContainer.computeLuminance()),
      );
      expect(
        darkScheme.surfaceContainer.computeLuminance(),
        lessThan(darkScheme.surfaceContainerHigh.computeLuminance()),
      );
      expect(
        darkScheme.surfaceContainerHigh.computeLuminance(),
        lessThan(darkScheme.surfaceContainerHighest.computeLuminance()),
      );
    });

    test('uses readable onSurface', () {
      _expectReadable(darkScheme.onSurface, darkScheme.surface);
    });

    test('reduces saturation for dark outline colors', () {
      expect(
        HSLColor.fromColor(darkScheme.outline).saturation,
        lessThan(lightSourceHsl.saturation),
      );
      expect(
        HSLColor.fromColor(darkScheme.outlineVariant).saturation,
        lessThan(lightSourceHsl.saturation),
      );
    });

    test('creates a lighter inverse surface', () {
      expect(
        darkScheme.inverseSurface.computeLuminance(),
        greaterThan(darkScheme.surface.computeLuminance()),
      );
    });

    test('uses readable onInverseSurface', () {
      _expectReadable(
        darkScheme.onInverseSurface,
        darkScheme.inverseSurface,
      );
    });
  });

  group('generateColorScheme general behavior', () {
    test('returns opaque tracked colors in light mode', () {
      for (final color in _trackedColors(lightScheme)) {
        expect(color.a, 1.0);
      }
    });

    test('returns opaque tracked colors in dark mode', () {
      for (final color in _trackedColors(darkScheme)) {
        expect(color.a, 1.0);
      }
    });

    test('uses a readable light error color pair', () {
      _expectReadable(lightScheme.onError, lightScheme.error);
    });

    test('uses a readable dark error color pair', () {
      _expectReadable(darkScheme.onError, darkScheme.error);
    });

    test('uses black shadow and scrim', () {
      expect(lightScheme.shadow, Colors.black);
      expect(lightScheme.scrim, Colors.black);
      expect(darkScheme.shadow, Colors.black);
      expect(darkScheme.scrim, Colors.black);
    });

    test('creates an inversePrimary that differs from primary', () {
      expect(lightScheme.inversePrimary, isNot(lightScheme.primary));
      expect(darkScheme.inversePrimary, isNot(darkScheme.primary));
    });

    test('keeps amber primary intact', () {
      final scheme = Colors.amber.generateColorScheme();

      expect(scheme.primary, Colors.amber);
    });

    test('generates distinct secondary and tertiary colors for amber', () {
      final scheme = Colors.amber.generateColorScheme();

      expect(scheme.secondary, isNot(scheme.primary));
      expect(scheme.tertiary, isNot(scheme.secondary));
    });
  });
}
