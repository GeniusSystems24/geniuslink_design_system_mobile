import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// App-scoped MVC controller for the effective Material theme mode.
///
/// This is the ChangeNotifier replacement for the previous theme state unit. The
/// current mobile behavior remains system-driven, so the controller starts in
/// [ThemeMode.system]. Consumers may still set an explicit mode later without
/// changing the view contract.
class ThemeController extends ChangeNotifier {
  ThemeMode _mode;
  bool _disposed = false;

  ThemeController({ThemeMode initial = ThemeMode.system}) : _mode = initial;

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  void setMode(ThemeMode mode) {
    if (_disposed || _mode == mode) return;
    _mode = mode;
    notifyListeners();
  }

  /// Retained for API symmetry with the previous mobile theme control.
  /// Mobile theme toggling remains deliberately disabled.
  void toggle() {}

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
