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

  /// Toggle between the effective light and dark themes.
  ///
  /// When the current mode is [ThemeMode.system], [currentBrightness] is used
  /// so the first toggle always moves to the opposite visible theme.
  void toggle({Brightness? currentBrightness}) {
    if (_disposed) return;

    final currentlyDark = switch (_mode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => currentBrightness == Brightness.dark,
    };

    setMode(currentlyDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
