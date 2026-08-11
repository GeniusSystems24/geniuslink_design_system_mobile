import 'dart:async' show unawaited;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/tenancy/tenant_connection.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../workspace/presentation/controllers/nav_controller.dart';
import '../../workspace/presentation/controllers/tenant_controller.dart';
import 'theme_controller.dart';

/// Root MVC controller that owns and synchronizes app-scoped controllers.
///
/// This centralizes the former provider/listener control plane.
/// Screen/page controllers remain independently testable ChangeNotifiers, while
/// the application root has a single lifecycle owner for auth, tenancy,
/// navigation compatibility state, and theme state.
class AppController extends ChangeNotifier {
  final AuthController authController;
  final TenantController tenantController;
  final NavController navController;
  final ThemeController themeController;

  bool _disposed = false;

  AppController({
    required TenantConnectionResolver resolver,
    AuthState initialAuth = const AuthState.unauthenticated(),
    ThemeMode initialThemeMode = ThemeMode.system,
    bool Function(String)? registryHas,
  }) : authController = AuthController(
         resolver: resolver,
         initial: initialAuth,
       ),
       tenantController = TenantController(resolver: resolver),
       navController = NavController(),
       themeController = ThemeController(initial: initialThemeMode) {
    if (registryHas != null) {
      navController.registryHas = registryHas;
    }
    authController.addListener(_syncFromAuth);
    _syncFromAuth();
  }

  void _syncFromAuth() {
    if (_disposed) return;

    final auth = authController.state;
    if (auth.isAuthenticated) {
      tenantController.setAvailable(auth.availableTenants);
      if (tenantController.state.activeTenantId == null &&
          auth.availableTenants.isNotEmpty) {
        unawaited(tenantController.switchTo(auth.availableTenants.first.id));
      }
      if (!navController.authed) navController.login();
    } else if (auth.status == AuthStatus.unauthenticated) {
      tenantController.clear();
      if (navController.authed || navController.state.stack.isNotEmpty) {
        navController.logout();
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    authController.removeListener(_syncFromAuth);
    themeController.dispose();
    navController.dispose();
    tenantController.dispose();
    authController.dispose();
    super.dispose();
  }
}
