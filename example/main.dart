import 'package:flutter/material.dart';
import 'package:chroma_kit/chroma_kit.dart'; // Import ChromaKit extension

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: ChromaKitComparison(),
));

class ChromaKitComparison extends StatelessWidget {
  const ChromaKitComparison({super.key});

  @override
  Widget build(BuildContext context) {
    const original = Colors.blue; // Original base color for comparison

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChromaKit Showcase'),
        backgroundColor: original,
        foregroundColor: original.contrastColor, // Auto-selects white/black
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. FAINT COMPARISON (Blending with White)
          _buildComparisonRow(
            title: 'Faint Utility',
            desc: 'Blends with white to create soft pastels while keeping alpha.',
            original: original,
            modified: original.faint(0.7),
            info: 'Change: Lighter & Pastel, Preserved Alpha',
          ),

          // 2. CONTRAST COMPARISON (Accessibility)
          _buildComparisonRow(
            title: 'Adaptive Contrast',
            desc: 'Detects best foreground color for readability.',
            original: original,
            modified: original,
            customText: true,
            info: 'Auto-switches text to ${original.contrastColor == Colors.black ? "Black" : "White"}',
          ),

          // 3. TRANSPARENCY (Safe Alpha Factor)
          _buildComparisonRow(
            title: 'withOpacityFraction',
            desc: 'Safe transparency with 0.0-1.0 factor (Clamped).',
            original: original,
            modified: original.withOpacityFraction(0.4),
            info: 'Alpha set to 40% safely using withValues',
          ),

          // 3.1 TRANSPARENCY (Safe Alpha Factor)
          _buildComparisonRow(
            title: 'Transparency',
            desc: 'Safe transparency with 0.0-1.0 factor (Clamped).',
            original: original,
            modified: original.transparency(0.3),
            info: 'Alpha set to 30% safely using withValues',
          ),

          // 4. SHADE MANIPULATION (Darken/Lighten)
          _buildComparisonRow(
            title: 'Darken Utility',
            desc: 'Programmatic shade deepening via black blending.',
            original: original,
            modified: original.darken(0.3),
            info: 'Luminance reduced by 30%',
          ),

          // 5. HEX PARSING & CONVERSION
          const Divider(height: 40),
          const Text('Hex Utilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildHexSection('#FF6200EE', ChromaKit.fromHex('#FF6200EE')),
          _buildHexSection('#FFF (Shorthand)', ChromaKit.fromHex('#FFF')),
          const SizedBox(height: 10),
          Text('Original Color Hex: ${original.toHex()}', style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildComparisonRow({
    required String title,
    required String desc,
    required Color original,
    required Color modified,
    required String info,
    bool customText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 10),
        Row(
          children: [
            _colorSquare(original, 'Original', Colors.white),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, color: Colors.grey),
            ),
            _colorSquare(modified, 'Modified', customText ? modified.contrastColor : Colors.white),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 24),
          child: Text(info, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _colorSquare(Color color, String label, Color textColor) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(color.toHex(), style: TextStyle(color: textColor, fontSize: 10, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildHexSection(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Input: $label', style: TextStyle(color: color.contrastColor, fontWeight: FontWeight.w500)),
          Text('Result: ${color.toHex()}', style: TextStyle(color: color.contrastColor, fontSize: 12)),
        ],
      ),
    );
  }
}