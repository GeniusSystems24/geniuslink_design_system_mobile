import 'package:flutter/material.dart';

/// App-scoped locale controller for English/Arabic language switching.
///
/// A null [locale] means MaterialApp follows the device/system locale. As soon
/// as the user toggles language, the controller switches explicitly between
/// English and Arabic.
class LocaleController extends ChangeNotifier {
  Locale? _locale;
  bool _disposed = false;

  LocaleController({Locale? initial}) : _locale = initial;

  Locale? get locale => _locale;

  void setLocale(Locale? locale) {
    if (_disposed || _locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggle(Locale effectiveLocale) {
    if (_disposed) return;

    final currentLanguage = (_locale ?? effectiveLocale).languageCode;
    setLocale(Locale(currentLanguage == 'ar' ? 'en' : 'ar'));
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
