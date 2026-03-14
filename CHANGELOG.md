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
- Replaced deprecated `.opacity` with `.a` to resolve static analysis warnings.

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