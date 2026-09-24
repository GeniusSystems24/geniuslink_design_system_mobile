import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';
import 'package:super_tab_bar/super_tab_bar.dart';
import 'package:super_table_field/super_table_field.dart';
import 'package:super_tree_field/super_tree.dart';

import '../localization/generated/l10n.dart';
import '../core/tenancy/tenant_connection.dart';
import 'controllers/app_controller.dart';
import 'router/router.dart';
import 'router/screen_route_registry.dart';
import 'widgets/app_settings_scope.dart';

class GeniusLinkApp extends StatefulWidget {
  const GeniusLinkApp({super.key});

  @override
  State<GeniusLinkApp> createState() => _GeniusLinkAppState();
}

class _GeniusLinkAppState extends State<GeniusLinkApp> {
  static const _resolver = FakeTenantConnectionResolver();

  late final AppController _appController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appController = AppController(
      resolver: _resolver,
      registryHas: ScreenRouteRegistry.hasRoute,
    );
    _router = createRouter(
      authController: _appController.authController,
      tenantController: _appController.tenantController,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _appController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = SuperPalette.bluePalette;
    return ListenableBuilder(
      listenable: Listenable.merge([
        _appController.themeController,
        _appController.localeController,
      ]),
      builder: (context, _) {
        final effectiveLocale =
            _appController.localeController.locale ??
            WidgetsBinding.instance.platformDispatcher.locale;
        final isArabic = effectiveLocale.languageCode == "ar";
        final typography = SuperTextTheme(isArabic: isArabic);

        var superSectionTitleThemeData = SuperSectionTitleThemeData(
          // title1Style: typography.bodyMedium?.copyWith(),
          // title2Style: typography.bodyMedium?.copyWith(),
        );
        return MaterialApp.router(
          builder: (context, child) {
            var appSettingsScope = AppSettingsScope(
              controller: _appController,
              child: child ?? const SizedBox.shrink(),
            );

            // return appSettingsScope;

            return MediaQuery.withClampedTextScaling(
              minScaleFactor: 1.0,
              maxScaleFactor: 2.0,
              child: appSettingsScope,
            );
          },
          title: 'GeniusLink',
          debugShowCheckedModeBanner: false,
          theme: SuperMaterialThemeData.light(
            mode: SuperDeviceMode.mobile,
            palette: palette,
            textTheme: typography,
            primaryTextTheme: typography,
            extensions: [
              superSectionTitleThemeData,
              SuperNavigationSidebarThemeData.light,
              SuperTabBarThemeData.light,
              SuperAutoSuggestionsBoxThemeData.light,
            ],
          ),
          darkTheme: SuperMaterialThemeData.dark(
            mode: SuperDeviceMode.mobile,
            palette: palette,
            textTheme: typography,
            primaryTextTheme: typography,
            extensions: [
              superSectionTitleThemeData,
              SuperNavigationSidebarThemeData.dark,
              SuperTabBarThemeData.dark,
              SuperAutoSuggestionsBoxThemeData.dark,
            ],
          ),
          locale: _appController.localeController.locale,
          supportedLocales: [const Locale('en'), const Locale('ar')],
          localizationsDelegates: const [
            GeniusLinkLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // super packages
            SuperTableLocalization.delegate,
            SuperAutoSuggestionLocalization.delegate,
            SuperFormTranslation.delegate,
            SuperTreeLocalization.delegate,
            SuperNavigationLocalization.delegate,
          ],
          themeMode: _appController.themeController.mode,
          routerConfig: _router,
        );
      },
    );
  }
}
