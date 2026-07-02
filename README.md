# 🎨 ChromaKit

<div align="center">

[![pub package](https://img.shields.io/pub/v/chroma_kit.svg)](https://pub.dev/packages/chroma_kit)
[![likes](https://img.shields.io/pub/likes/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![points](https://img.shields.io/pub/points/chroma_kit)](https://pub.dev/packages/chroma_kit/score)

**A lightweight Flutter toolkit for dynamic color manipulation, accessibility utilities, and theme generation.**

ChromaKit provides practical Flutter color utilities for building polished apps and design systems, including Flutter accessibility helpers, Material palette utilities, and a Material 3 ColorScheme generator.

Installation • Features • Usage • API Reference • Contributing

</div>

---

## ✨ What's New in v1.2.0

### 🚀 New Features

- **`generateColorScheme()`**  
  Generate a complete Material 3 `ColorScheme` from a single source color.

- **`darkModeVariant()`**  
  Create a dark-theme-friendly variant while preserving hue and vibrancy.

- **`shadow()`**  
  Build Material-style `BoxShadow` values directly from any color.

- **`nearestMaterialColorName`**  
  Find the closest Flutter Material color shade name using palette matching.

- **`isLight`**  
  Add a convenient brightness helper alongside `isDark`.

- **`ChromaKitUtils.fromString()`**  
  Create deterministic UI-friendly colors from text values.

- **`ChromaKitUtils.avatarColor()`**  
  Produce consistent, avatar-friendly colors from user identifiers.

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  chroma_kit: ^1.2.0
```

Then run:

```bash
flutter pub get
```

---

## 💡 Why ChromaKit?

ChromaKit keeps common Flutter design system color work simple, consistent, and dependency-free.

- Color manipulation helpers for opacity, blending, pastels, and shades
- Flutter accessibility utilities for contrast and readable foreground colors
- Material 3 ColorScheme generator and theme generation helpers
- Material palette utilities for matching colors to Flutter Material shades
- Deterministic avatar colors, string-based colors, and shadow generation

---

## 🎯 Features at a Glance

| Category | Methods | Description |
|----------|---------|-------------|
| **Opacity** | `transparency()` | Safe alpha manipulation with auto-clamping |
| **Pastel** | `pastel()` | Create soft, muted color variations |
| **Blending** | `blendWith()`, `blendMany()` | Dynamic color mixing |
| **Accessibility** | `contrastRatio()`, `isAccessibleOn()`, `contrastColor`, `isDark`, `isLight` | Flutter accessibility and WCAG compliance tools |
| **Shades** | `lighten()`, `darken()` | Quick brightness adjustments |
| **Theming** | `toMaterialColor()` | Generate Material Design swatches |
| **Theme Generation** | `generateColorScheme()`, `darkModeVariant()` | Build Material 3 themes from source colors |
| **Material Intelligence** | `nearestMaterialColorName` | Match colors to the closest Material palette shade |
| **Utilities** | `ChromaKitUtils.fromString()`, `ChromaKitUtils.avatarColor()`, `shadow()` | Deterministic colors and reusable UI effects |
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

// Check brightness helpers
final useDarkText = myBackground.isLight;
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
);

// Or use a custom color
ThemeData(
  primarySwatch: const Color(0xFF6200EE).toMaterialColor(),
);
```

### 🌙 Dark Mode Variants

```dart
// Create a color variant designed for dark surfaces
final darkBlue = Colors.blue.darkModeVariant();
```

### 🎨 Material 3 ColorScheme Generation

```dart
// Generate a light Material 3 ColorScheme from one source color
final scheme =
    Colors.deepPurple.generateColorScheme();

ThemeData(
  colorScheme: scheme,
  useMaterial3: true,
);

// Generate a dark Material 3 ColorScheme
final darkScheme = Colors.deepPurple.generateColorScheme(
  brightness: Brightness.dark,
);

ThemeData(
  colorScheme: darkScheme,
  useMaterial3: true,
);
```

### 🏷️ Nearest Material Color

```dart
// Match any color to the nearest Flutter Material palette shade
final materialName = Colors.blue.nearestMaterialColorName; // "Blue 500"
```

### 👤 Avatar Colors

```dart
// Generate a consistent, avatar-friendly color from a user identifier
final avatarColor = ChromaKitUtils.avatarColor('user_123');
```

### 🔤 String-Based Colors

```dart
// Generate deterministic colors from strings
final flutterColor = ChromaKitUtils.fromString('Flutter');
```

### 🌫️ Shadows

```dart
// Create a Material-style BoxShadow from any color
final blueShadow = Colors.blue.shadow();
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
- 🌙 Dark mode color variants
- 🧩 Material 3 ColorScheme generator
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
| `darkModeVariant()` | none | `Color` | Create a dark-theme-friendly variant |
| `shadow()` | `{blurRadius, spreadRadius, offset, opacity}` | `BoxShadow` | Generate a Material-style shadow |
| `generateColorScheme()` | `{brightness: Brightness.light}` | `ColorScheme` | Generate a Material 3 ColorScheme |
| `toHex()` | `{includeHash: true}` | `String` | Convert to hex string |

### Static Methods

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `ChromaKit.fromHex()` | `hexString: String` | `Color` | Safely parse hex color |
| `ChromaKitUtils.fromString()` | `text: String` | `Color` | Generate a deterministic color from text |
| `ChromaKitUtils.avatarColor()` | `identifier: String` | `Color` | Generate an avatar-friendly deterministic color |

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `contrastColor` | `Color` | Returns black/white for readability |
| `isDark` | `bool` | Checks if color is dark |
| `isLight` | `bool` | Checks if color is light |
| `nearestMaterialColorName` | `String` | Returns the closest Flutter Material palette shade name |

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
- ✅ Color utilities and manipulation methods
- ✅ Edge cases (clamping, invalid inputs)
- ✅ Flutter accessibility and WCAG ratio calculations
- ✅ Theme generation and Material 3 ColorScheme output
- ✅ Avatar colors and deterministic string colors
- ✅ Material palette matching
- ✅ Shadows and Material swatch generation

---

## 🛣️ Roadmap

Future ideas:

- Color Harmony Utilities (Complementary, Analogous, Triadic)
- Gradient Generation
- Dynamic Palette Generation
- Advanced Theme Helpers
- Material 3 Design Utilities

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

Flutter Developer • Open Source Contributor

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
