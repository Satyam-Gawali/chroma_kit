import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: ChromaKitShowcase(),
));

class ChromaKitShowcase extends StatelessWidget {
  const ChromaKitShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    const original = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChromaKit Showcase'),
        backgroundColor: original,
        foregroundColor: original.contrastColor,
        elevation: 2,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // ==========================================
            // HEADER SECTION
            // ==========================================
            _buildHeader(),
            const SizedBox(height: 24),

            // ==========================================
            // COLOR MANIPULATION
            // ==========================================
            _buildSectionHeader('Color Manipulation'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRowItem('pastel()', original, original.pastel(0.7), 'Soft pastel look'),
                    _buildRowItem('blendWith()', original, original.blendWith(Colors.red, 0.5), 'Blended 50% with Red'),
                    _buildRowItem('blendMany()', original, original.blendMany([Colors.red, Colors.yellow], 0.5), 'Blended with Red & Yellow'),
                    _buildRowItem('lighten()', original, original.lighten(0.3), 'Lightened by 30%'),
                    _buildRowItem('darken()', original, original.darken(0.3), 'Darkened by 30%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // TRANSPARENCY
            // ==========================================
            _buildSectionHeader('Transparency'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRowItem('transparency(0.25)', original, original.transparency(0.25), 'Alpha factor at 25%'),
                    _buildRowItem('transparency(0.50)', original, original.transparency(0.50), 'Alpha factor at 50%'),
                    _buildRowItem('transparency(0.75)', original, original.transparency(0.75), 'Alpha factor at 75%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // ACCESSIBILITY
            // ==========================================
            _buildSectionHeader('Accessibility'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccessibilityItem('White on Blue', Colors.white, Colors.blue),
                    const Divider(height: 24),
                    _buildAccessibilityItem('Black on Yellow', Colors.black, Colors.yellow),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // BRIGHTNESS DETECTION
            // ==========================================
            _buildSectionHeader('Brightness Detection'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _buildBrightnessBadge('Black', Colors.black),
                    const SizedBox(width: 12),
                    _buildBrightnessBadge('White', Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // MATERIAL SWATCHES
            // ==========================================
            _buildSectionHeader('Material Swatches'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Colors.blue.toMaterialColor()', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildMaterialPalette(Colors.blue.toMaterialColor()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // MATERIAL COLOR MATCHING
            // ==========================================
            _buildSectionHeader('Material Color Matching'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMatchItem(Colors.blue, 'Colors.blue'),
                    _buildMatchItem(const Color(0xFF008B85), 'Color(0xFF008B85)'),
                    _buildMatchItem(const Color(0xFFE53935), 'Color(0xFFE53935)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // DARK MODE VARIANTS
            // ==========================================
            _buildSectionHeader('Dark Mode Variants'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRowItem('Blue Variant', Colors.blue, Colors.blue.darkModeVariant(), 'Optimized dark hue'),
                    _buildRowItem('Amber Variant', Colors.amber, Colors.amber.darkModeVariant(), 'Optimized dark hue'),
                    _buildRowItem('Green Variant', Colors.green, Colors.green.darkModeVariant(), 'Optimized dark hue'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // SHADOWS
            // ==========================================
            _buildSectionHeader('Shadows'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [Colors.blue.shadow()],
                      ),
                      alignment: Alignment.center,
                      child: const Text('Default Shadow', style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [Colors.blue.shadow(blurRadius: 24, opacity: 0.4, offset: const Offset(0, 8))],
                      ),
                      alignment: Alignment.center,
                      child: const Text('Custom Shadow', style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // STRING BASED COLORS
            // ==========================================
            _buildSectionHeader('String Based Colors'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAvatarCircle('Flutter', ChromaKitUtils.fromString('Flutter')),
                    _buildAvatarCircle('Satyam', ChromaKitUtils.fromString('Satyam')),
                    _buildAvatarCircle('ChromaKit', ChromaKitUtils.fromString('ChromaKit')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // AVATAR COLORS
            // ==========================================
            _buildSectionHeader('Avatar Colors'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAvatarCircle('U1', ChromaKitUtils.avatarColor('user_1')),
                    _buildAvatarCircle('U2', ChromaKitUtils.avatarColor('user_2')),
                    _buildAvatarCircle('U3', ChromaKitUtils.avatarColor('user_3')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // COLOR SCHEME GENERATION
            // ==========================================
            _buildSectionHeader('ColorScheme Generation'),
            _buildSchemePreview('Light Scheme', Colors.deepPurple.generateColorScheme(brightness: Brightness.light)),
            const SizedBox(height: 16),
            _buildSchemePreview('Dark Scheme', Colors.deepPurple.generateColorScheme(brightness: Brightness.dark)),
            const SizedBox(height: 24),

            // ==========================================
            // HEX UTILITIES
            // ==========================================
            _buildSectionHeader('Hex Utilities'),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Original Color Hex: ${original.toHex()}', style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    _buildHexSection('#FF6200EE', ChromaKit.fromHex('#FF6200EE')),
                    _buildHexSection('#F00', ChromaKit.fromHex('#F00')),
                    _buildHexSection('#FFF', ChromaKit.fromHex('#FFF')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ==========================================
            // FOOTER
            // ==========================================
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // WIDGET BUILDER HELPER METHODS
  // ==========================================================================

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'ChromaKit Showcase',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          'Advanced Real-time Color Utility Extension Kit',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.transparency(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
          ),
          child: const Text(
            'v1.2.0',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
      ),
    );
  }

  Widget _buildRowItem(String method, Color from, Color to, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(method, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _buildColorPreviewTile('Original', from)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.grey),
              ),
              Expanded(child: _buildColorPreviewTile('Result', to)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 2),
            child: Text(info, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontStyle: FontStyle.italic)),
          ),
          const Divider(height: 16, color: Colors.black12),
        ],
      ),
    );
  }

  Widget _buildColorPreviewTile(String label, Color color) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      alignment: Alignment.center,
      child: Text(
        '$label (${color.toHex()})',
        style: TextStyle(color: color.contrastColor, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAccessibilityItem(String label, Color text, Color bg) {
    final double ratio = text.contrastRatio(bg);
    final bool passesNormal = text.isAccessibleOn(bg, largeText: false);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ratio: ${ratio.toStringAsFixed(2)}:1', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildAccessibilityChip('WCAG AA', passesNormal),
                const SizedBox(width: 4),
                _buildAccessibilityChip('WCAG AAA', ratio >= 7.0),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildAccessibilityChip(String label, bool pass) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: pass ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${pass ? "PASS" : "FAIL"}',
        style: TextStyle(color: pass ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBrightnessBadge(String name, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            Text(name, style: TextStyle(color: color.contrastColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: [
                _buildLabelChip('isDark: ${color.isDark}', color.contrastColor, color),
                _buildLabelChip('isLight: ${color.isLight}', color.contrastColor, color),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelChip(String text, Color textColor, Color currentBg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: textColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildMaterialPalette(MaterialColor materialColor) {
    final shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    return Column(
      children: shades.map((shade) {
        final color = materialColor[shade]!;
        return Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: color),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$shade', style: TextStyle(color: color.contrastColor, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(color.toHex(), style: TextStyle(color: color.contrastColor, fontSize: 11)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMatchItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Matches: ${color.nearestMaterialColorName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAvatarCircle(String text, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Text(text.substring(0, min(text.length, 2)), style: TextStyle(color: color.contrastColor, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  int min(int a, int b) => a < b ? a : b;

  Widget _buildSchemePreview(String title, ColorScheme scheme) {
    final roles = [
      ('Primary', scheme.primary, scheme.onPrimary),
      ('Secondary', scheme.secondary, scheme.onSecondary),
      ('Tertiary', scheme.tertiary, scheme.onTertiary),
      ('Surface', scheme.surface, scheme.onSurface),
      ('Container', scheme.primaryContainer, scheme.onPrimaryContainer),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: roles.map((role) {
              return Expanded(
                child: Container(
                  height: 60,
                  color: role.$2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(role.$1, style: TextStyle(color: role.$3, fontSize: 9, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(role.$2.toHex(includeHash: false), style: TextStyle(color: role.$3, fontSize: 8)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHexSection(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Input: $label', style: TextStyle(color: color.contrastColor, fontWeight: FontWeight.w500, fontSize: 12)),
          Text('Parsed: ${color.toHex()}', style: TextStyle(color: color.contrastColor, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text('Built with ChromaKit', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          icon: const Icon(Icons.code_rounded, size: 18),
          label: const Text('GitHub Repository', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// ==========================================================================
// CORE CHROMAPACKAGE IMPLEMENTATION INLINED AS DIRECTED
// ==========================================================================

final List<({String name, Color color})> _materialColorPalette = <({String name, Color color})>[
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

List<({String name, Color color})> _materialColorShades(String colorName, MaterialColor materialColor) {
  const shades = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  return shades.map((int shade) => (name: '$colorName $shade', color: materialColor[shade]!)).toList(growable: false);
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

  return source.withHue(_shiftHue(source.hue, 30)).withSaturation(saturation).withLightness(lightness).toColor();
}

Color _generateTertiary(HSLColor source, Brightness brightness) {
  final double saturation = _clampDouble(source.saturation + 0.08, 0.45, 0.88);
  final double lightness = brightness == Brightness.light
      ? _clampDouble((source.lightness * 0.95) + 0.01, 0.36, 0.58)
      : _clampDouble(0.64 + ((source.lightness - 0.5) * 0.18), 0.60, 0.78);

  return source.withHue(_shiftHue(source.hue, 65)).withSaturation(saturation).withLightness(lightness).toColor();
}

Color _generateContainer(HSLColor source, Brightness brightness, {double lightBias = 0.0, double saturationOffset = -0.04}) {
  final HSLColor adjustedSource = source.withSaturation(_clampDouble(source.saturation + saturationOffset, 0.20, 0.95));
  final double lightness = brightness == Brightness.light
      ? _clampDouble(0.84 + lightBias + ((1.0 - adjustedSource.saturation) * 0.05), 0.78, 0.94)
      : _clampDouble(0.24 + lightBias + (adjustedSource.saturation * 0.06), 0.18, 0.36);

  return adjustedSource.withLightness(lightness).toColor();
}

Color _generateSurface(HSLColor source, Brightness brightness, {required double lightness}) {
  final double saturation = brightness == Brightness.light
      ? _clampDouble(source.saturation * 0.10, 0.02, 0.08)
      : _clampDouble(source.saturation * 0.14, 0.03, 0.10);

  return source.withSaturation(saturation).withLightness(_clampDouble(lightness, 0.0, 1.0)).toColor();
}

Color _generateOutline(HSLColor source, Brightness brightness, {bool isVariant = false}) {
  final double saturation = _clampDouble(source.saturation * (isVariant ? 0.22 : 0.30), 0.05, 0.20);
  final double lightness = brightness == Brightness.light ? (isVariant ? 0.78 : 0.55) : (isVariant ? 0.32 : 0.64);

  return source.withSaturation(saturation).withLightness(lightness).toColor();
}

Color _resolveOnColor(Color background) {
  if (background.a < 0.2) return Colors.black;
  final Color preferred = background.contrastColor;
  if (background.contrastRatio(preferred) >= 4.5) return preferred;
  final Color alternate = preferred == Colors.white ? Colors.black : Colors.white;
  return background.contrastRatio(alternate) > background.contrastRatio(preferred) ? alternate : preferred;
}

final class ChromaKitUtils {
  ChromaKitUtils._();

  static Color fromString(String text) {
    final int hash = _stableStringHash(text);
    final double hue = (hash % 360).toDouble();
    final double saturation = 0.5 + (((hash ~/ 360) % 31) / 100);
    final double lightness = 0.4 + (((hash ~/ (360 * 31)) % 31) / 100);
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  static Color avatarColor(String identifier) {
    final HSLColor baseColor = HSLColor.fromColor(fromString(identifier));
    return baseColor.withSaturation(baseColor.saturation.clamp(0.55, 0.75)).withLightness(baseColor.lightness.clamp(0.45, 0.65)).toColor();
  }
}

extension ChromaKit on Color {
  Color transparency(double fraction) => withValues(alpha: fraction.clamp(0.0, 1.0));

  @Deprecated('Use transparency(fraction) instead.')
  Color withOpacityFraction(double fraction) => transparency(fraction);

  Color pastel([double factor = 0.9]) {
    final double safeFactor = factor.clamp(0.0, 1.0);
    return (Color.lerp(this, Colors.white, safeFactor) ?? this).withValues(alpha: a);
  }

  @Deprecated('Use pastel() instead.')
  Color faint([double factor = 0.9]) => pastel(factor);

  Color blendWith(Color other, [double factor = 0.5]) {
    return (Color.lerp(this, other, factor.clamp(0.0, 1.0)) ?? this).withValues(alpha: a);
  }

  @Deprecated('Use blendWith() instead.')
  Color faintWith(Color other, [double factor = 0.5]) => blendWith(other, factor);

  Color blendMany(List<Color> others, [double factor = 0.5]) {
    if (others.isEmpty) return pastel(factor);
    int rSum = 0, gSum = 0, bSum = 0;
    for (var c in others) {
      rSum += c.r.toInt();
      gSum += c.g.toInt();
      bSum += c.b.toInt();
    }
    final Color avgColor = Color.fromARGB(a.toInt(), rSum ~/ others.length, gSum ~/ others.length, bSum ~/ others.length);
    return blendWith(avgColor, factor);
  }

  @Deprecated('Use blendMany() instead.')
  Color faintWiths(List<Color> others, [double factor = 0.5]) => blendMany(others, factor);

  Color get contrastColor {
    if (a < 0.2) return Colors.black;
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  bool get isDark => computeLuminance() < 0.5;
  bool get isLight => !isDark;

  double contrastRatio(Color other) {
    final l1 = computeLuminance();
    final l2 = other.computeLuminance();
    final brightest = l1 > l2 ? l1 : l2;
    final darkest = l1 > l2 ? l2 : l1;
    return (brightest + 0.05) / (darkest + 0.05);
  }

  bool isAccessibleOn(Color background, {bool largeText = false}) {
    final ratio = contrastRatio(background);
    return largeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  Color darken([double factor = 0.1]) => blendWith(Colors.black, factor);
  Color lighten([double factor = 0.1]) => blendWith(Colors.white, factor);

  Color darkModeVariant() {
    final HSLColor hsl = HSLColor.fromColor(this);
    final double targetLightness = hsl.lightness > 0.7
        ? 0.34
        : hsl.lightness > 0.45
        ? (hsl.lightness * 0.6).clamp(0.18, 0.38)
        : (hsl.lightness * 0.8).clamp(0.16, 0.36);
    final double targetSaturation = hsl.saturation < 0.35 ? (hsl.saturation + 0.2).clamp(0.0, 1.0) : (hsl.saturation + 0.08).clamp(0.0, 1.0);
    return hsl.withLightness(targetLightness).withSaturation(targetSaturation).toColor();
  }

  BoxShadow shadow({double blurRadius = 12, double spreadRadius = 0, Offset offset = const Offset(0, 4), double opacity = 0.25}) {
    return BoxShadow(color: withValues(alpha: opacity.clamp(0.0, 1.0)), blurRadius: blurRadius, spreadRadius: spreadRadius, offset: offset);
  }

  ColorScheme generateColorScheme({Brightness brightness = Brightness.light}) {
    final Color seedColor = withValues(alpha: 1.0);
    final HSLColor source = HSLColor.fromColor(seedColor);
    final Brightness inverseBrightness = brightness == Brightness.light ? Brightness.dark : Brightness.light;

    final Color primary = seedColor;
    final Color primaryContainer = _generateContainer(source, brightness, lightBias: brightness == Brightness.light ? 0.02 : 0.0, saturationOffset: -0.02);
    final Color secondary = _generateSecondary(source, brightness);
    final Color secondaryContainer = _generateContainer(HSLColor.fromColor(secondary), brightness, lightBias: brightness == Brightness.light ? 0.01 : -0.01, saturationOffset: -0.05);
    final Color tertiary = _generateTertiary(source, brightness);
    final Color tertiaryContainer = _generateContainer(HSLColor.fromColor(tertiary), brightness, lightBias: brightness == Brightness.light ? 0.0 : -0.01, saturationOffset: -0.06);

    final Color surface = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.98 : 0.06);
    final Color surfaceDim = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.87 : 0.05);
    final Color surfaceBright = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.99 : 0.24);
    final Color surfaceContainerLowest = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 1.0 : 0.04);
    final Color surfaceContainerLow = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.96 : 0.10);
    final Color surfaceContainer = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.94 : 0.12);
    final Color surfaceContainerHigh = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.92 : 0.17);
    final Color surfaceContainerHighest = _generateSurface(source, brightness, lightness: brightness == Brightness.light ? 0.90 : 0.22);

    final Color outline = _generateOutline(source, brightness);
    final Color outlineVariant = _generateOutline(source, brightness, isVariant: true);

    final HSLColor errorSource = HSLColor.fromColor(Colors.red.shade700);
    final Color error = brightness == Brightness.light ? errorSource.withLightness(0.42).toColor() : errorSource.withLightness(0.72).toColor();
    final Color errorContainer = _generateContainer(HSLColor.fromColor(error), brightness, lightBias: brightness == Brightness.light ? 0.01 : -0.01, saturationOffset: -0.03);

    final Color inverseSurface = _generateSurface(source, inverseBrightness, lightness: inverseBrightness == Brightness.light ? 0.92 : 0.20);
    final Color inversePrimary = _generateContainer(source, inverseBrightness, lightBias: inverseBrightness == Brightness.light ? -0.02 : 0.03, saturationOffset: 0.0);

    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: _resolveOnColor(primary),
      primaryContainer: primaryContainer,
      onPrimaryContainer: _resolveOnColor(primaryContainer),
      secondary: secondary,
      onSecondary: _resolveOnColor(secondary),
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: _resolveOnColor(secondaryContainer),
      tertiary: tertiary,
      onTertiary: _resolveOnColor(tertiary),
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: _resolveOnColor(tertiaryContainer),
      error: error,
      onError: _resolveOnColor(error),
      errorContainer: errorContainer,
      onErrorContainer: _resolveOnColor(errorContainer),
      surface: surface,
      onSurface: _resolveOnColor(surface),
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: _resolveOnColor(surfaceContainerHighest),
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: inverseSurface,
      onInverseSurface: _resolveOnColor(inverseSurface),
      inversePrimary: inversePrimary,
      surfaceTint: primary,
    );
  }

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

  String get nearestMaterialColorName {
    final double red = r;
    final double green = g;
    final double blue = b;
    var nearest = _materialColorPalette.first;
    double shortestDistance = double.infinity;

    for (final candidate in _materialColorPalette) {
      final double redDiff = red - candidate.color.r;
      final double greenDiff = green - candidate.color.g;
      final double blueDiff = blue - candidate.color.b;
      final double distance = (redDiff * redDiff) + (greenDiff * greenDiff) + (blueDiff * blueDiff);

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearest = candidate;
      }
    }
    return nearest.name;
  }

  String toHex({bool includeHash = true}) {
    final String hex = toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    return includeHash ? '#$hex' : hex;
  }

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
      return Colors.black;
    }
  }
}