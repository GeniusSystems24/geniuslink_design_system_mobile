import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gl_mobile_app/app/controllers/app_controller.dart';
import 'package:gl_mobile_app/app/controllers/theme_controller.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_connection.dart';
import 'package:gl_mobile_app/workspace/presentation/controllers/nav_controller.dart';

void main() {
  group('ThemeController', () {
    test(
      'starts with the effective system theme and notifies on explicit set',
      () {
        final controller = ThemeController();
        var notifications = 0;
        controller.addListener(() => notifications++);

        expect(controller.mode, ThemeMode.system);
        controller.setMode(ThemeMode.dark);

        expect(controller.mode, ThemeMode.dark);
        expect(controller.isDark, isTrue);
        expect(notifications, 1);
        controller.dispose();
      },
    );

    test('toggle remains a no-op for mobile behavior compatibility', () {
      final controller = ThemeController(initial: ThemeMode.dark);
      controller.toggle();
      expect(controller.mode, ThemeMode.dark);
      controller.dispose();
    });
  });

  group('NavController', () {
    test('preserves auth, tab, push, back and home behavior', () {
      final controller = NavController()
        ..registryHas = (id) => {'detail', 'settings'}.contains(id);

      controller.login();
      controller.selectTab('accounts');
      controller.go('detail');
      controller.go('settings');

      expect(controller.authed, isTrue);
      expect(controller.tab, 'accounts');
      expect(controller.sub, 'settings');

      controller.back('detail');
      expect(controller.sub, 'detail');

      controller.home();
      expect(controller.sub, isNull);

      controller.logout();
      expect(controller.authed, isFalse);
      expect(controller.tab, 'dashboard');
      controller.dispose();
    });
  });

  group('AppController', () {
    test('auth changes synchronize navigation and tenant state', () async {
      final controller = AppController(
        resolver: const FakeTenantConnectionResolver(),
      );

      expect(controller.navController.authed, isFalse);

      final ok = await controller.authController.login(
        'owner@example.com',
        'password',
      );
      await Future<void>.delayed(Duration.zero);

      expect(ok, isTrue);
      expect(controller.navController.authed, isTrue);
      expect(controller.tenantController.state.availableTenants, isNotEmpty);

      controller.authController.logout();
      expect(controller.navController.authed, isFalse);
      expect(controller.tenantController.state.activeTenantId, isNull);
      controller.dispose();
    });
  });
}
