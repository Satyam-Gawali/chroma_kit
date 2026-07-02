# Changelog

All notable changes to this project will be documented in this file.

---

## 1.2.0

### Added
- `generateColorScheme()` – Generates a complete Material 3 `ColorScheme` from a single source color.
- `darkModeVariant()` – Creates a dark-theme-friendly variant while preserving hue and vibrancy.
- `shadow()` – Generates Material-style `BoxShadow` objects from any color.
- `nearestMaterialColorName` – Returns the nearest Flutter Material color shade name using RGB distance matching.
- `isLight` – Convenience brightness helper.
- `ChromaKitUtils.fromString()` – Generates deterministic colors from strings.
- `ChromaKitUtils.avatarColor()` – Generates avatar-friendly deterministic colors.

### Improved
- Expanded unit test coverage across color manipulation, accessibility, palette matching, shadows, avatar colors, and theme generation.
- Enhanced API documentation with additional examples.
- Improved internal HSL-based color generation algorithms.

### Documentation
- Added README examples for:
  - `generateColorScheme()`
  - `darkModeVariant()`
  - `avatarColor()`
  - `fromString()`
  - `nearestMaterialColorName()`

---

## 1.1.0

### Added
- `contrastRatio()` – Calculates WCAG contrast ratio between two colors.
- `isAccessibleOn()` – Validates accessibility compliance for text and background colors.
- `toMaterialColor()` – Generates a complete `MaterialColor` swatch for Flutter themes.

### Changed
- Renamed APIs for improved clarity:
  - `faint()` → `pastel()`
  - `faintWith()` → `blendWith()`
  - `faintWiths()` → `blendMany()`

### Deprecated
- `withOpacityFraction()` → Use `transparency()` instead.

### Improved
- Flutter 3.27+ compatibility.
- Replaced deprecated `Color.value` usage with `toARGB32()`.

---

## 1.0.2

### Added
- A comprehensive example demonstrating original vs modified color comparisons.

### Fixed
- Replaced deprecated `.opacity` usage with `.a` to resolve static analysis warnings.

### Improved
- Completed library-level dartdoc comments for improved documentation scoring.
- Improved project structure by organizing implementation files.

---

## 1.0.1

### Improved
- Updated README for better clarity.
- Minor documentation improvements.

---

## 1.0.0

### Added
- Initial release of **ChromaKit**.
- Transparency utilities.
- Pastel color generation.
- Color blending utilities.
- Hex color parsing and conversion.
- Adaptive contrast helpers.
- Accessibility-focused color utilities.