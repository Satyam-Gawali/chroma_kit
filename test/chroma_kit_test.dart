import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chroma_kit/chroma_kit.dart';

void main() {
  group('ChromaKit Opacity & Tinting Tests', () {
    const color = Colors.blue;

    test('transparency should clamp values and adjust alpha', () {
      expect(color.transparency(0.5).a, 0.5);

      expect(color.transparency(1.5).a, 1.0);

      expect(color.transparency(-0.5).a, 0.0);
    });

    test('pastel should create a lighter version of the color', () {
      final pastelBlue = color.pastel(0.8);

      expect(
        pastelBlue.computeLuminance() > color.computeLuminance(),
        true,
      );

      expect(pastelBlue.a, color.a);
    });
  });

  group('ChromaKit Adaptive UI Tests', () {
    test('contrastColor should return correct foreground color', () {
      expect(Colors.black.contrastColor, Colors.white);

      expect(Colors.white.contrastColor, Colors.black);

      expect(Colors.transparent.contrastColor, Colors.black);
    });

    test('isDark should correctly detect brightness', () {
      expect(Colors.black.isDark, true);

      expect(Colors.white.isDark, false);
    });

    test('isLight should correctly detect brightness', () {
      expect(Colors.black.isLight, false);

      expect(Colors.white.isLight, true);

      expect(Colors.black.isLight, !Colors.black.isDark);

      expect(Colors.white.isLight, !Colors.white.isDark);
    });
  });

  group('ChromaKit Hex Parsing Tests', () {
    test('toHex should return valid hex string', () {
      const pureRed = Color(0xFFFF0000);

      expect(pureRed.toHex(), '#FFFF0000');

      expect(pureRed.toHex(includeHash: false), 'FFFF0000');
    });

    test('fromHex should handle multiple formats', () {
      expect(
        ChromaKit.fromHex('#F44336'),
        const Color(0xFFF44336),
      );

      expect(
        ChromaKit.fromHex('#F00'),
        const Color(0xFFFF0000),
      );

      expect(
        ChromaKit.fromHex('invalid_hex'),
        Colors.black,
      );
    });
  });

  group('ChromaKit Advanced Blending Tests', () {
    test('blendWith should mix two colors correctly', () {
      const base = Colors.red;

      const target = Colors.blue;

      final blended = base.blendWith(target, 0.5);

      expect(blended.r < base.r, true);

      expect(blended.b > base.b, true);
    });

    test('blendMany should fallback to pastel if list empty', () {
      const base = Colors.red;

      expect(
        base.blendMany([], 0.5),
        base.pastel(0.5),
      );
    });
  });

  group('ChromaKit Shadow Tests', () {
    test('shadow should use Material-style defaults', () {
      final shadow = Colors.blue.shadow();

      expect(shadow.color.r, Colors.blue.r);
      expect(shadow.color.g, Colors.blue.g);
      expect(shadow.color.b, Colors.blue.b);
      expect(shadow.color.a, 0.25);
      expect(shadow.blurRadius, 12);
      expect(shadow.spreadRadius, 0);
      expect(shadow.offset, const Offset(0, 4));
    });

    test('shadow should apply custom values and clamp opacity', () {
      final shadow = Colors.red.shadow(
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 8),
        opacity: 1.5,
      );

      expect(shadow.color.r, Colors.red.r);
      expect(shadow.color.g, Colors.red.g);
      expect(shadow.color.b, Colors.red.b);
      expect(shadow.color.a, 1.0);
      expect(shadow.blurRadius, 20);
      expect(shadow.spreadRadius, 2);
      expect(shadow.offset, const Offset(0, 8));
    });

    test('shadow should clamp opacity to zero', () {
      final shadow = Colors.green.shadow(opacity: -1);

      expect(shadow.color.r, Colors.green.r);
      expect(shadow.color.g, Colors.green.g);
      expect(shadow.color.b, Colors.green.b);
      expect(shadow.color.a, 0.0);
    });
  });

  group('ChromaKit Dark Theme Tests', () {
    test('darkModeVariant should preserve blue hue and reduce lightness', () {
      final original = HSLColor.fromColor(Colors.blue);
      final variant = HSLColor.fromColor(Colors.blue.darkModeVariant());

      expect((variant.hue - original.hue).abs(), lessThan(1.0));
      expect(variant.lightness, lessThan(original.lightness));
      expect(variant.lightness, greaterThan(0.0));
      expect(Colors.blue.darkModeVariant(), isNot(Colors.black));
    });

    test('darkModeVariant should keep amber vibrant for dark themes', () {
      final original = HSLColor.fromColor(Colors.amber);
      final variant = HSLColor.fromColor(Colors.amber.darkModeVariant());

      expect((variant.hue - original.hue).abs(), lessThan(1.0));
      expect(variant.lightness, lessThan(original.lightness));
      expect(variant.lightness, greaterThanOrEqualTo(0.16));
      expect(variant.saturation, greaterThanOrEqualTo(original.saturation));
      expect(Colors.amber.darkModeVariant(), isNot(Colors.black));
    });
  });

  group('ChromaKit Material Palette Tests', () {
    test('nearestMaterialColorName should match exact base shades', () {
      expect(Colors.blue.nearestMaterialColorName, 'Blue 500');
      expect(Colors.red.nearestMaterialColorName, 'Red 500');
    });

    test('nearestMaterialColorName should match exact non-500 shades', () {
      expect(Colors.blue[700]!.nearestMaterialColorName, 'Blue 700');
      expect(Colors.amber[800]!.nearestMaterialColorName, 'Amber 800');
    });

    test('nearestMaterialColorName should use RGB distance for nearby colors', () {
      const customTeal = Color(0xFF008B85);

      expect(customTeal.nearestMaterialColorName, 'Teal 600');
    });
  });

  group('ChromaKitUtils Tests', () {
    test('fromString should return the same color for the same input', () {
      expect(
        ChromaKitUtils.fromString('Satyam'),
        ChromaKitUtils.fromString('Satyam'),
      );
    });

    test('fromString should return an opaque color', () {
      final color = ChromaKitUtils.fromString('Flutter');

      expect(color.a, 1.0);
    });

    test('fromString should keep saturation and lightness in range', () {
      final hsl = HSLColor.fromColor(ChromaKitUtils.fromString('Flutter'));

      expect(hsl.saturation, inInclusiveRange(0.5, 0.8));
      expect(hsl.lightness, inInclusiveRange(0.4, 0.7));
    });

    test('fromString should generate different colors for different strings', () {
      expect(
        ChromaKitUtils.fromString('Satyam'),
        isNot(ChromaKitUtils.fromString('Flutter')),
      );
    });

    test('avatarColor should return the same color for the same identifier', () {
      expect(
        ChromaKitUtils.avatarColor('user_123'),
        ChromaKitUtils.avatarColor('user_123'),
      );
    });

    test('avatarColor should return an opaque avatar-friendly color', () {
      final color = ChromaKitUtils.avatarColor('user_123');
      final hsl = HSLColor.fromColor(color);

      expect(color.a, 1.0);
      expect(color, isNot(Colors.black));
      expect(color, isNot(Colors.white));
      expect(hsl.saturation, inInclusiveRange(0.55, 0.75));
      expect(hsl.lightness, inInclusiveRange(0.45, 0.65));
    });

    test('avatarColor should preserve the base hue from fromString', () {
      final baseHue = HSLColor.fromColor(
        ChromaKitUtils.fromString('user_123'),
      ).hue;
      final avatarHue = HSLColor.fromColor(
        ChromaKitUtils.avatarColor('user_123'),
      ).hue;

      expect((avatarHue - baseHue).abs(), lessThan(1.0));
    });
  });
}
