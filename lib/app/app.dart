import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:super_auto_suggestion_box/super_auto_suggestion_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_form_field/super_form_field.dart';
import 'package:super_table_field/super_table_field.dart';

import 'package:super_core/super_core.dart';
import '../core/tenancy/tenant_connection.dart';
import 'controllers/app_controller.dart';
import 'router/router.dart';
import 'router/screen_route_registry.dart';

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
    var superTextTheme = SuperTextTheme(
      bodyFont: GoogleFonts.robotoTextTheme().bodyMedium!,
    );
    final lightTheme = SuperMaterialThemeData.light(
      palette: palette,
      textTheme: superTextTheme,
      primaryTextTheme: superTextTheme,
    );
    final darkTheme = SuperMaterialThemeData.dark(
      palette: palette,
      textTheme: superTextTheme,
      primaryTextTheme: superTextTheme,
    );

    return ListenableBuilder(
      listenable: _appController.themeController,
      builder: (context, _) => MaterialApp.router(
        title: 'GeniusLink',
        debugShowCheckedModeBanner: false,
        theme: lightTheme.copyWith(
          extensions: [
            SuperAutoSuggestionsBoxThemeData.fromMaterialTheme(lightTheme),
          ],
        ),
        darkTheme: darkTheme.copyWith(
          extensions: [
            SuperAutoSuggestionsBoxThemeData.fromMaterialTheme(darkTheme),
          ],
        ),
        supportedLocales: [const Locale('en'), const Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // super packages
          SuperTableTranslation.delegate,
          SuperAutoSuggestionsTranslation.delegate,
          SuperFormTranslation.delegate,
        ],
        themeMode: _appController.themeController.mode,
        routerConfig: _router,
      ),
    );
  }
}
