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
}
