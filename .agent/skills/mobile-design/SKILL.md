---
name: mobile-design
description: Mobile-first design thinking and decision-making for Flutter apps. Focuses on premium Custom UI, Glassmorphism, and avoiding clunky Material defaults.
allowed-tools: Read, Glob, Grep
---

# Mobile Design System (Flutter Edition)

> **Philosophy:** Touch-first. Aesthetic. Custom. Premium.
> **Core Principle:** Never settle for default Material widgets. Build premium, glassy, custom UI.

---

## 🚫 YASAK LİSTESİ (STRICT DESIGN UN-PATTERNS)

**DO NOT USE THESE DEFAULT WIDGETS WITHOUT HEAVY CUSTOMIZATION:**
- ❌ Standard `AppBar` (use transparent custom headers)
- ❌ Standard `Card` with default elevation
- ❌ Standard `ElevatedButton` (use custom gradient/glass buttons)
- ❌ Default `BottomNavigationBar` (use floating, blurred bars)

## ✅ MÜKEMMEL UI/UX İÇİN GEREKSİNİMLER (MANDATORY)

1. **Glassmorphism (Cam Efekti):**
   - Use `BackdropFilter` with `ImageFilter.blur`.
   - Apply semi-transparent white/dark colors for background containers.
   - Use subtle white/light borders to simulate glass edges.

2. **Typography:**
   - Always use modern fonts (e.g., Google Fonts like Inter, Outfit, or Poppins).
   - Never use default Roboto without typography adjustments (weight, spacing).

3. **Minimal Padding & Spacing:**
   - Avoid oversized UI padding. Keep grids tight and aesthetic.
   - Use Masonry grids for image lists: `flutter_staggered_grid_view`.

4. **Image Handling (Crucial for UI):**
   - Never use simple `Image.network`.
   - **MUST USE** `cached_network_image` for all fetched images to prevent flickering and excessive network usage.
   - Provide beautiful loading placeholders (shimmer effect) inside image widgets.

## 🔥 Premium Component Guide

### Beautiful Buttons
Instead of `ElevatedButton`, create an `InkWell` wrapped inside a `Container` with `BoxDecoration` featuring a linear gradient, soft shadows, and rounded borders. 

### Floating AppBars
Instead of Scaffold's `appBar` property, use a `Stack` to place a blurred, custom header over the scrollable content.

> **Final UX Check:** Does this app look like a dribbble shot? If no, it is not finished. Build it better.
