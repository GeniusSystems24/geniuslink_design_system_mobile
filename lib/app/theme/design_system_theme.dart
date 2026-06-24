// ============================================================
// GeniusLink Mobile — Design System Theme Extensions
// File placement:  lib/app/theme/design_system_theme.dart
// ============================================================

import 'dart:ui';

import 'package:geniuslink_design_system/geniuslink_design_system.dart';
import '../../design_system/tokens/m_colors.dart';

const TreeThemeData kMobileTreeTheme = TreeThemeData(
  bg: M.bg, surface: M.surface, inputBg: M.input, hover: M.card2,
  border: M.border, borderStrong: M.borderStrong, guide: Color(0xFF3A3D46),
  fg1: M.fg1, fg2: M.fg2, fg3: M.fg3, fg4: M.fg4,
);

const EditableTableThemeData kMobileTableTheme = EditableTableThemeData(
  bg: M.bg, surface: M.surface, inputBg: M.input, hover: M.card2,
  border: M.border, borderStrong: M.borderStrong,
  fg1: M.fg1, fg2: M.fg2, fg3: M.fg3, fg4: M.fg4,
);

const AutoSuggestionsBoxThemeData kMobileSuggestTheme = AutoSuggestionsBoxThemeData(
  fieldBg: M.input, fieldBgFocus: M.card2, overlayBg: M.surface, hover: M.card2,
  border: M.borderStrong, borderFocus: M.blue,
  fg1: M.fg1, fg2: M.fg2, fg3: M.fg3, groupFg: M.fg3,
);
