---
name: performance-profiling
description: Performance optimization principles for Flutter. Target 60fps, strict memory management, and smooth UI.
allowed-tools: Read, Glob, Grep
---

# Performance Optimization Principles (Flutter)

> **Core Principle:** Never block the UI thread. Respect device memory. Keep the frame rate at 60fps+.

## 🚀 MANDATORY OPTIMIZATIONS

### 1. Image Optimization Strategies
- **Uploading to Supabase:** You MUST use `flutter_image_compress` before uploading any image taken from the camera or gallery. Never upload raw multi-megabyte files.
- **Displaying Images:** You MUST use `cached_network_image` for fetching and displaying remote images. This avoids repeated expensive downloads.
- **List Layouts:** For masonry grids (like Pinterest), MUST use `flutter_staggered_grid_view`. Avoid nested listbuilders that calculate infinite heights.

### 2. Isolates for Heavy Computation
- **Rule of Thumb:** If a sync execution takes > 16ms, it will drop frames (UI jank).
- **Requirement:** Heavy CPU tasks MUST be offloaded using `Isolate.run()` or `compute()`.
- **Common Use Case:** Extracting dominant colors from images (e.g., using `palette_generator`), complex JSON parsing of massive payloads, or heavy data manipulation. 

### 3. Widget Performance
- Use `const` constructors everywhere possible to prevent unnecessary rebuilds.
- Keep widget trees shallow.
- Avoid using `Opacity` widget in animated lists; use animated colors instead.
- Avoid large `build` methods. Extract widgets into smaller classes (not just methods).
