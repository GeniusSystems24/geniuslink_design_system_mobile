import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gl_mobile_app/core/state/load_status.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_connection.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_database.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_session.dart';
import 'package:gl_mobile_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/controllers/mobile_dashboard_controller.dart';
import 'package:gl_mobile_app/workspace/presentation/controllers/tenant_controller.dart';
import 'package:gl_mobile_app/workspace/presentation/widgets/tenant_scope.dart';

void main() {
  group('AuthController', () {
    test('login authenticates and loads tenants', () async {
      final controller = AuthController(
        resolver: const FakeTenantConnectionResolver(),
        initial: const AuthState.unauthenticated(),
      );

      final ok = await controller.login('layla.a@geniuslink.sa', '');

      expect(ok, isTrue);
      expect(controller.state.status, AuthStatus.authenticated);
      expect(controller.state.availableTenants, isNotEmpty);
      expect(controller.state.user.email, 'layla.a@geniuslink.sa');
      controller.dispose();
    });

    test('logout resets authentication state', () async {
      final controller = AuthController(
        resolver: const FakeTenantConnectionResolver(),
      );
      await controller.login('owner@example.com', '');
      controller.logout();
      expect(controller.state.status, AuthStatus.unauthenticated);
      controller.dispose();
    });
  });

  group('MobileDashboardController', () {
    test('selectTab switches tab and clears chart metric', () {
      final controller = MobileDashboardController();
      controller.setChartMetric('cash');
      controller.selectTab('inventory');

      expect(controller.state.tab, 'inventory');
      expect(controller.state.chartMetric, isNull);
      controller.dispose();
    });

    test('refresh cycles loading to ready', () async {
      final controller = MobileDashboardController();
      final statuses = <LoadStatus>[];
      controller.addListener(() => statuses.add(controller.state.status));

      await controller.refresh();

      expect(
        statuses,
        containsAllInOrder([LoadStatus.loading, LoadStatus.ready]),
      );
      controller.dispose();
    });
  });

  group('Tenant isolation', () {
    testWidgets('switch tears down previous connection and builds fresh', (
      tester,
    ) async {
      final seen = <TenantDatabase>[];
      final controller =
          TenantController(resolver: const FakeTenantConnectionResolver())
            ..setAvailable(const [
              TenantRef(id: '9', name: 'Al-Rashid'),
              TenantRef(id: '14', name: 'Najd'),
            ]);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: TenantScope(
            controller: controller,
            fallbackBuilder: (_) => const Text('none'),
            child: Builder(
              builder: (context) {
                seen.add(TenantDatabaseScope.of(context));
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await controller.switchTo('9');
      await tester.pump();
      final dbA = seen.last;

      await controller.switchTo('14');
      await tester.pump();
      final dbB = seen.last;

      expect(identical(dbA, dbB), isFalse);
      expect(dbA.isOpen, isFalse);
      expect(dbB.isOpen, isTrue);
      expect(dbB.tenantId, '14');
      controller.dispose();
    });
  });

  test('TenantDatabase.guard blocks cross-tenant access', () {
    final db = TenantDatabase(
      const TenantSession(
        tenantId: '9',
        name: 'Al-Rashid',
        connection: ConnectionDescriptor(baseUrl: 'x', dbName: 'tenant_9.db'),
      ),
    );
    expect(() => db.guard('9'), returnsNormally);
    expect(() => db.guard('14'), throwsStateError);
  });
}
