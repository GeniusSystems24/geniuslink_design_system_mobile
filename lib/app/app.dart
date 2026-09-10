import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:super_auto_suggestion_box/localization/generated/l10n.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';
import 'package:super_table_field/super_table_field.dart';
import 'package:super_tree_field/super_tree.dart';

import '../localization/generated/l10n.dart';
import '../core/tenancy/tenant_connection.dart';
import 'controllers/app_controller.dart';
import 'router/router.dart';
import 'router/screen_route_registry.dart';
import 'widgets/app_settings_scope.dart';

import 'theme/app_theme.dart';

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
    return ListenableBuilder(
      listenable: Listenable.merge([
        _appController.themeController,
        _appController.localeController,
      ]),
      builder: (context, _) => MaterialApp.router(
        builder: (context, child) {
          final minimumTextScale = minimumAppTextScale(
            _appController.localeController.locale,
          );

          return MediaQuery.withClampedTextScaling(
            minScaleFactor: minimumTextScale,
            maxScaleFactor: 2.0,
            child: AppSettingsScope(
              controller: _appController,
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
        title: 'GeniusLink',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(
          brightness: Brightness.light,
          locale: _appController.localeController.locale,
        ),
        darkTheme: buildAppTheme(
          brightness: Brightness.dark,
          locale: _appController.localeController.locale,
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
          SuperAutoSuggestionsTranslation.delegate,
          SuperFormTranslation.delegate,
          SuperTreeLocalization.delegate,
          SuperNavigationLocalization.delegate,
        ],
        themeMode: _appController.themeController.mode,
        routerConfig: _router,
      ),
    );
  }
}
