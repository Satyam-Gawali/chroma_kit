# 🎨 ChromaKit

[![pub package](https://img.shields.io/pub/v/chroma_kit.svg)](https://pub.dev/packages/chroma_kit)
[![likes](https://img.shields.io/pub/likes/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![popularity](https://img.shields.io/pub/popularity/chroma_kit)](https://pub.dev/packages/chroma_kit/score)
[![points](https://img.shields.io/pub/points/chroma_kit)](https://pub.dev/packages/chroma_kit/score)

> A lightweight and professional Flutter toolkit for dynamic color manipulation and accessibility.

ChromaKit simplifies common UI design challenges in Flutter such as:
- Creating pastel shades
- Managing transparency safely
- Ensuring accessible text contrast
- Parsing hex colors without crashes
- Lightening and darkening colors programmatically

Clean API. Zero complexity. Production ready.

---

## ✨ Features

### 🟢 Smart Transparency
Set alpha using a safe fraction (`0.0 – 1.0`) with automatic clamping.

```dart
final transparentBlue = Colors.blue.withAlphaFactor(0.5);
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

### 🌗 Shade Manipulation
Easily lighten or darken any color using simple factor-based methods.

```dart
final darker = Colors.blue.darken(0.2);
final lighter = Colors.blue.lighten(0.2);
```

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  chroma_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

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

Computer Engineering Student  
Flutter Developer  
Passionate about high-performance apps and creative 3D experiences

🔗 GitHub: https://github.com/Satyam-Gawali  
🔗 LinkedIn: www.linkedin.com/in/satyam-gawali-b4623b268


---

## 📄 License

This project is licensed under the MIT License.  
See the LICENSE file for details.