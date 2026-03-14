# 🎨 ChromaKit

<div align="center">

[![pub package](https://img.shields.io/pub/v/chroma_kit.svg)](https://pub.dev/packages/chroma_kit)
[![likes](https://img.shields.io/pub/likes/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![points](https://img.shields.io/pub/points/chroma_kit)](https://pub.dev/packages/chroma_kit/score)


**A lightweight Flutter toolkit for dynamic color manipulation, accessibility utilities, and theme generation.**

Installation • Features • Usage • API Reference • Contributing

</div>

---

## ✨ What's New in v1.1.0

### 🚀 New Features

- **`contrastRatio()`**  
  Calculates the WCAG contrast ratio between two colors (range **1.0 – 21.0**).

- **`isAccessibleOn()`**  
  Validates accessibility compliance between text and background colors.

- **`toMaterialColor()`**  
  Generates a complete `MaterialColor` swatch for Flutter themes.

- **`contrastColor` property**  
  Automatically returns **black or white** text color based on readability.

---

### 📝 API Improvements

Some APIs were renamed for better clarity and consistency:

| Old Method | New Method |
|-----------|------------|
| `faint()` | `pastel()` |
| `faintWith()` | `blendWith()` |
| `faintWiths()` | `blendMany()` |

Additional improvements:

- Updated for **Flutter 3.27+**
- Removed deprecated **`Color.value`** usage
- Improved internal color precision

---

### ⚠️ Deprecated

The following method is deprecated but still supported for backward compatibility:


withOpacityFraction()


Please use:


transparency()


instead.

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  chroma_kit: ^1.1.0
```
Then run:
```cmd
flutter pub get
```

---



## 🎯 Features at a Glance

| Category | Methods | Description |
|----------|---------|-------------|
| **Opacity** | `transparency()` | Safe alpha manipulation with auto-clamping |
| **Pastel** | `pastel()` | Create soft, muted color variations |
| **Blending** | `blendWith()`, `blendMany()` | Dynamic color mixing |
| **Accessibility** | `contrastRatio()`, `isAccessibleOn()`, `contrastColor` | WCAG compliance tools |
| **Shades** | `lighten()`, `darken()` | Quick brightness adjustments |
| **Theming** | `toMaterialColor()` | Generate Material Design swatches |
| **Hex** | `toHex()`, `ChromaKit.fromHex()` | Safe hex conversions |

---

## 🚀 Example Usage

### 🟢 Smart Transparency
```dart
// Safe alpha manipulation (automatically clamped 0.0–1.0)
final transparentBlue = Colors.blue.transparency(0.5);
final fullyTransparent = Colors.red.transparency(1.5); // Clamps to 1.0
```

### 🎨 Pastel Colors
```dart
// Create soft pastel versions (blend with white)
final softRed = Colors.red.pastel(0.8); // 80% white blend
final mintGreen = Colors.green.pastel(); // Default 0.9 factor
```

### 🔄 Color Blending
```dart
// Blend two colors
final purple = Colors.blue.blendWith(Colors.red, 0.5);

// Blend multiple colors
final gradient = Colors.blue.blendMany([
  Colors.red,
  Colors.green,
  Colors.yellow
], 0.7); // 70% blend factor
```

### ♿ Accessibility Utilities

```dart
// Calculate WCAG contrast ratio (1.0–21.0)
final ratio = Colors.white.contrastRatio(Colors.blue);
print('Contrast ratio: $ratio:1');

// Check accessibility compliance
final isAccessible = Colors.white.isAccessibleOn(
  Colors.blue,
  largeText: false, // Normal text requires 4.5:1
);

// Get readable text color automatically
final textColor = myBackground.contrastColor; // Returns black or white
```

### 🌗 Shade Manipulation
```dart
// Lighten or darken colors
final darkerBlue = Colors.blue.darken(0.2);  // 20% darker
final lighterBlue = Colors.blue.lighten(0.2); // 20% lighter
```

### 🎨 Material Theme Generation
```dart
// Generate complete MaterialColor swatch
MaterialColor primarySwatch = Colors.teal.toMaterialColor();

ThemeData(
  primarySwatch: Colors.blue.toMaterialColor(),
  // Or use custom color
  primarySwatch: const Color(0xFF6200EE).toMaterialColor(),
);
```

### 🔢 Hex Utilities
```dart
// Color to hex
String hex = Colors.blue.toHex(); // "#FF2196F3"
String hexNoHash = Colors.blue.toHex(includeHash: false); // "FF2196F3"

// Safe hex parsing (supports #RGB, #RRGGBB, #AARRGGBB)
final color1 = ChromaKit.fromHex('#FF6200EE');
final color2 = ChromaKit.fromHex('#F00'); // Expands to #FFFF0000
final color3 = ChromaKit.fromHex('invalid'); // Defaults to Colors.black
```

---

## 🛠️ Interactive Demo

Check out the comprehensive example app for side-by-side comparisons:

```bash
git clone https://github.com/Satyam-Gawali/chroma_kit.git
cd chroma_kit/example
flutter run
```

The example demonstrates:
- 🔄 Live color manipulation
- 👁️ Original vs modified color comparison
- 📊 Accessibility ratio calculator
- 🎨 Material swatch preview
- 🎯 Contrast checking visualization

👉 **[View Example on GitHub](https://github.com/Satyam-Gawali/chroma_kit/tree/main/example)**

---

## 📚 API Reference

### Core Methods

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `transparency()` | `fraction: double` | `Color` | Adjust alpha with clamping |
| `pastel()` | `[factor: 0.9]` | `Color` | Blend with white |
| `blendWith()` | `other: Color, [factor: 0.5]` | `Color` | Blend with specific color |
| `blendMany()` | `others: List<Color>, [factor: 0.5]` | `Color` | Blend with average of colors |
| `contrastRatio()` | `other: Color` | `double` | Calculate WCAG ratio |
| `isAccessibleOn()` | `background: Color, {largeText: false}` | `bool` | Check WCAG compliance |
| `darken()` | `[factor: 0.1]` | `Color` | Blend with black |
| `lighten()` | `[factor: 0.1]` | `Color` | Blend with white |
| `toMaterialColor()` | none | `MaterialColor` | Generate theme swatch |
| `toHex()` | `{includeHash: true}` | `String` | Convert to hex string |

### Static Methods

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `ChromaKit.fromHex()` | `hexString: String` | `Color` | Safely parse hex color |

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `contrastColor` | `Color` | Returns black/white for readability |
| `isDark` | `bool` | Checks if color is dark |

---

## 🧪 Test Coverage

ChromaKit includes comprehensive tests:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

Test coverage includes:
- ✅ All color manipulation methods
- ✅ Edge cases (clamping, invalid inputs)
- ✅ WCAG ratio calculations
- ✅ Hex parsing validation
- ✅ Material swatch generation

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing`)
3. 💻 Write tests for your changes
4. ✅ Ensure all tests pass (`flutter test`)
5. 📝 Update documentation
6. 🚀 Submit a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 📋 Requirements

- Flutter: `>=3.27.0`
- Dart SDK: `>=3.6.0 <4.0.0`
---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Developer

<div align="center">

**Built with ❤️ by [Satyam Gawali](https://github.com/Satyam-Gawali)**

Computer Engineering Student | Flutter Developer

[![GitHub](https://img.shields.io/badge/GitHub-Satyam--Gawali-blue?style=social&logo=github)](https://github.com/Satyam-Gawali)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Satyam%20Gawali-blue?style=social&logo=linkedin)](https://www.linkedin.com/in/satyam-gawali-b4623b268)

</div>

---

## ⭐ Support

If you find **ChromaKit** useful, please consider:

- ⭐ Starring the [GitHub repository](https://github.com/Satyam-Gawali/chroma_kit)
- 📢 Sharing it with fellow Flutter developers
- 🐛 Reporting issues or suggesting new features

---


<div align="center">

Made with 💙 for the Flutter community  
Built by **Satyam Gawali**

</div>