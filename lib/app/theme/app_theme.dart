// ============================================================
// GeniusLink Mobile — MaterialApp Theme
// File placement:  lib/app/theme/app_theme.dart
// ============================================================

import 'package:flutter/material.dart';
import '../../design_system/tokens/m_colors.dart';
import 'design_system_theme.dart';

ThemeData buildMobileTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: M.bg,
  fontFamily: M.body,
  colorScheme: const ColorScheme.dark(primary: M.blue, surface: M.surface, background: M.bg),
  splashFactory: InkRipple.splashFactory,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: M.blue, selectionColor: Color(0x554A7CFF)),
  extensions: const [kMobileTreeTheme, kMobileTableTheme, kMobileSuggestTheme],
);
