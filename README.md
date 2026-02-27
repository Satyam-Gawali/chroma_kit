# 🎨 ChromaKit

[![pub package](https://img.shields.io/pub/v/chroma_kit.svg)](https://pub.dev/packages/chroma_kit)
[![likes](https://img.shields.io/pub/likes/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![popularity](https://img.shields.io/pub/popularity/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![points](https://img.shields.io/pub/points/chroma_kit)](https://pub.dev/packages/chroma_kit/score)

> A lightweight and professional Flutter toolkit for dynamic color manipulation and accessibility.

ChromaKit simplifies common UI design challenges in Flutter:

- 🎨 Creating pastel shades
- 🟢 Managing transparency safely
- ♿ Ensuring accessible text contrast
- 🔢 Parsing hex colors without crashes
- 🌗 Lightening and darkening colors programmatically

Clean API. Zero complexity. Production ready.

---

## ✨ Key Updates

### v1.0.2
- Added detailed side-by-side comparison example
- Optimized for latest Flutter API (`.a` for alpha handling)
- Improved documentation clarity
- Standardized transparency API (`transparency()` as primary method)

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  chroma_kit: ^1.0.2
```

Then run:

```bash
flutter pub get
```

---

## 🛠️ Interactive Example

Check out the example folder for a side-by-side comparison of original vs. modified colors:

👉 https://github.com/Satyam-Gawali/chroma_kit/tree/main/example

The example demonstrates:

- Faint blending
- Contrast detection
- Transparency handling
- Shade manipulation
- Hex parsing

---

## ✨ Features

---

### 🟢 Smart Transparency

Set alpha using a safe fraction (`0.0 – 1.0`) with automatic clamping.

```dart
final transparentBlue = Colors.blue.transparency(0.5);
```

Alias (for backward compatibility):

```dart
final transparentBlue = Colors.blue.withOpacityFraction(0.5);
```

---

### 🎨 Pastel Blending (Faint)

Create soft pastel versions of colors by blending with white while preserving original alpha.

```dart
final pastelRed = Colors.red.faint(0.8);
```

---

### ♿ Adaptive Contrast

Automatically detect whether black or white provides better readability.

```dart
Color textColor = myBackgroundColor.contrastColor;
bool isDark = myColor.isDark;
```

Perfect for:
- Buttons
- Cards
- Dynamic themes
- Accessibility-friendly UI

---

### 🌗 Shade Manipulation

Easily lighten or darken any color using simple factor-based methods.

```dart
final darker = Colors.blue.darken(0.2);
final lighter = Colors.blue.lighten(0.2);
```

---

### 🔢 Safe Hex Utilities

#### Convert Color → Hex

```dart
String hex = Colors.blue.toHex();
// Output: #FF2196F3
```

#### Parse Hex → Color

Supports:
- #RRGGBB
- #AARRGGBB
- Shorthand #FFF

```dart
Color myColor = ChromaKit.fromHex('#FF6200EE');
```

Built-in validation prevents crashes from invalid input.

---

## 🛠 Example Usage

```dart
Container(
  color: Colors.blue.faint(0.9),
  child: Text(
    "Hello ChromaKit",
    style: TextStyle(
      color: Colors.blue.contrastColor,
    ),
  ),
);
```

---

## 👨‍💻 About the Developer

Built with ❤️ by **Satyam Gawali**

Computer Engineering  
Flutter Developer

Focused on building scalable, production-ready Flutter applications with clean architecture and maintainable code.

🔗 GitHub: https://github.com/Satyam-Gawali  
🔗 LinkedIn: https://www.linkedin.com/in/satyam-gawali-b4623b268

---

## 📄 License

This project is licensed under the MIT License.  
See the LICENSE file for details.