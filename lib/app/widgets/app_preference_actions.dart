import 'package:flutter/material.dart';

import 'app_settings_scope.dart';

/// Toggles the application language between Arabic and English.
class AppLanguageToggleButton extends StatelessWidget {
  const AppLanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppSettingsScope.of(context);
    final controller = app.localeController;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final currentLocale = Localizations.localeOf(context);
        final currentLanguage =
            (controller.locale ?? currentLocale).languageCode;
        final targetLanguage = currentLanguage == 'ar' ? 'English' : 'العربية';

        return IconButton(
          tooltip: targetLanguage,
          icon: const Icon(Icons.language_rounded),
          onPressed: () => controller.toggle(currentLocale),
        );
      },
    );
  }
}

/// Toggles the application between effective light and dark themes.
class AppThemeToggleButton extends StatelessWidget {
  const AppThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppSettingsScope.of(context);
    final controller = app.themeController;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final brightness = Theme.of(context).brightness;
        final isDark = brightness == Brightness.dark;

        return IconButton(
          tooltip: isDark ? 'Light mode' : 'Dark mode',
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
          onPressed: () => controller.toggle(
            currentBrightness: brightness,
          ),
        );
      },
    );
  }
}
