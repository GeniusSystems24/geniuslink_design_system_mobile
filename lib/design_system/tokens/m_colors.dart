// ============================================================
// GeniusLink Mobile — Color & Font Tokens
// File placement:  lib/design_system/tokens/m_colors.dart
// ============================================================

import 'package:flutter/material.dart';

class M {
  // surfaces
  static const bg           = Color(0xFF111318);
  static const surface      = Color(0xFF1E2025);
  static const card2        = Color(0xFF292D38);
  static const input        = Color(0xFF33353A);
  static const border       = Color(0x8043464F);
  static const borderStrong = Color(0xFF43464F);
  // foreground
  static const fg1 = Color(0xFFE2E2E9);
  static const fg2 = Color(0xFFC3C6D7);
  static const fg3 = Color(0xFF8D90A0);
  static const fg4 = Color(0xFF44474E);
  // brand + semantic
  static const blue   = Color(0xFF4A7CFF);
  static const green  = Color(0xFF1DB88A);
  static const orange = Color(0xFFF97316);
  static const red    = Color(0xFFEF4444);
  // fonts
  static const display = 'Manrope';
  static const body    = 'Inter';
  static const mono    = 'JetBrainsMono';
  static const arabic  = 'NotoNaskhArabic';
}

Color tint(Color c, int alphaHex) => c.withAlpha(alphaHex);
Color tintPct(Color c, double pct) => c.withOpacity(pct);
