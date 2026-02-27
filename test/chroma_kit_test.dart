import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chroma_kit/chroma_kit.dart';

void main() {
  group('ChromaKit Opacity & Tinting Tests', () {
    const color = Colors.blue;

    test('Opacity should clamp values and adjust alpha', () {
      // Clamping test: Valid range (0.5)
      expect(color.transparency(0.5).a, 0.5);

      // Clamping test: Above 1.0 should result in 1.0
      expect(color.transparency(1.5).a, 1.0);

      // Clamping test: Below 0.0 should result in 0.0
      expect(color.transparency(-0.5).a, 0.0);
    });

    test('Faint should create a solid pastel version', () {
      final faintBlue = color.faint(0.8);

      // Faint color should be lighter than original (Check luminance)
      expect(faintBlue.computeLuminance() > color.computeLuminance(), true);

      // Alpha should remain consistent with original color
      expect(faintBlue.a, color.a);
    });
  });

  group('ChromaKit Adaptive UI Tests', () {
    test('contrastColor should return correct foreground for visibility', () {
      // Black background -> White text
      expect(Colors.black.contrastColor, Colors.white);

      // White background -> Black text
      expect(Colors.white.contrastColor, Colors.black);

      // Edge Case: Transparent color (alpha < 0.2) should return black text
      expect(Colors.transparent.contrastColor, Colors.black);
    });

    test('isDark should correctly identify brightness', () {
      expect(Colors.black.isDark, true);
      expect(Colors.white.isDark, false);
    });
  });

  group('ChromaKit Hex Parsing Tests', () {
    test('toHex should return valid uppercase hex string', () {
      const pureRed = Color(0xFFFF0000);
      expect(pureRed.toHex(), '#FFFF0000');
      expect(pureRed.toHex(includeHash: false), 'FFFF0000');
    });

    test('fromHex should handle multiple formats safely', () {
      expect(ChromaKit.fromHex('#F44336'), const Color(0xFFF44336));

      expect(ChromaKit.fromHex('#F00'), const Color(0xFFFF0000));

      // Error Handling: Invalid hex string should return black
      expect(ChromaKit.fromHex('invalid_hex'), Colors.black);
    });
  });

  group('ChromaKit Advanced Blending Tests', () {
    test('faintWith should blend with a specific color correctly', () {
      const base = Colors.red;
      const target = Colors.blue;
      final blended = base.faintWith(target, 0.5);

      // Using .r and .b instead of .red and .blue for Modern API compatibility
      expect(blended.r < base.r, true);
      expect(blended.b > base.b, true);
    });

    test('faintWiths should fallback to faint if others list is empty', () {
      const base = Colors.red;
      // Should blend with white by default if list is empty
      expect(base.faintWiths([]), base.faint());
    });
  });
}