// ============================================================
// APP / BLOC — ThemeCubit
// ------------------------------------------------------------
// Control-plane theme selection (tenant-agnostic — lives at the
// app root, ABOVE TenantScope, so the theme survives tenant
// switches). Mobile remains dark-only: the cubit is seeded dark and
// `toggle()` stays a deliberate no-op for API symmetry with desktop.
//
// State is the bare ThemeMode enum — no wrapper class needed for a
// single value.
//
// File placement:  lib/app/bloc/theme_cubit.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit([super.initial = ThemeMode.dark]);

  bool get isDark => state == ThemeMode.dark;

  /// Mobile remains dark-only; the application theme comes from super_core.
  void toggle() {}

  void set(ThemeMode mode) => emit(mode);
}
