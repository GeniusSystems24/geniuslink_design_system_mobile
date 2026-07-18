// ============================================================
// GeniusLink Mobile — super_core theme helpers
// File placement: lib/design_system/theme/super_core_theme_helpers.dart
// ============================================================

import 'package:flutter/material.dart';

/// Applies an 8-bit alpha value to a color sourced from `super_core`.
Color superCoreTint(Color color, int alphaHex) =>
    color.withAlpha(alphaHex.clamp(0, 255).toInt());

/// Applies a percentage opacity to a color sourced from `super_core`.
Color superCoreTintPct(Color color, double pct) =>
    color.withValues(alpha: pct.clamp(0.0, 1.0).toDouble());
