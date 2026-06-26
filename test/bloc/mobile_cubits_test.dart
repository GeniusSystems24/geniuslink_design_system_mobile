// ============================================================
// TEST — Mobile cubits + tenant isolation
// ------------------------------------------------------------
// NavCubit · MobileDashboardCubit · TenantCubit isolation for the
// mobile app. Package name: gl_mobile_app.
//
// Run:  flutter test test/bloc/mobile_cubits_test.dart
// ============================================================

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gl_mobile_app/core/bloc/load_status.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_connection.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_database.dart';
import 'package:gl_mobile_app/core/tenancy/tenant_session.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/bloc/mobile_dashboard_cubit.dart';
import 'package:gl_mobile_app/workspace/presentation/bloc/nav_cubit.dart';
import 'package:gl_mobile_app/workspace/presentation/bloc/tenant_cubit.dart';
import 'package:gl_mobile_app/workspace/presentation/widgets/tenant_scope.dart';

void main() {
  group('NavCubit', () {
    blocTest<NavCubit, NavState>(
      'login authenticates the gate',
      build: () => NavCubit(),
      act: (c) => c.login(),
      expect: () => [isA<NavState>().having((s) => s.authed, 'authed', true)],
    );

    blocTest<NavCubit, NavState>(
      'go pushes a sub-screen; back pops it',
      build: () => NavCubit(),
      act: (c) {
        c.go('userDetail');
        c.back(null);
      },
      expect: () => [
        isA<NavState>().having((s) => s.sub, 'sub', 'userDetail'),
        isA<NavState>().having((s) => s.sub, 'sub', null),
      ],
    );

    blocTest<NavCubit, NavState>(
      'selectTab clears the sub-stack',
      build: () => NavCubit(),
      seed: () => const NavState(authed: true, tab: 'dashboard', stack: ['x']),
      act: (c) => c.selectTab('accounts'),
      expect: () => [
        isA<NavState>()
            .having((s) => s.tab, 'tab', 'accounts')
            .having((s) => s.stack.isEmpty, 'cleared', true),
      ],
    );
  });

  group('MobileDashboardCubit', () {
    blocTest<MobileDashboardCubit, MobileDashboardState>(
      'selectTab switches tab and clears the chart metric',
      build: () => MobileDashboardCubit(),
      seed: () => const MobileDashboardState(tab: 'banking', chartMetric: 'cash'),
      act: (c) => c.selectTab('inventory'),
      expect: () => [
        isA<MobileDashboardState>()
            .having((s) => s.tab, 'tab', 'inventory')
            .having((s) => s.chartMetric, 'metric', null),
      ],
    );

    blocTest<MobileDashboardCubit, MobileDashboardState>(
      'refresh cycles loading -> ready',
      build: () => MobileDashboardCubit(),
      act: (c) => c.refresh(),
      expect: () => [
        isA<MobileDashboardState>().having((s) => s.status, 'status', LoadStatus.loading),
        isA<MobileDashboardState>().having((s) => s.status, 'status', LoadStatus.ready),
      ],
    );
  });

  group('Tenant isolation (mobile)', () {
    testWidgets('switch tears down previous connection, builds fresh', (tester) async {
      final seen = <TenantDatabase>[];
      final cubit = TenantCubit(resolver: const FakeTenantConnectionResolver());
      cubit.setAvailable(const [
        TenantRef(id: '9', name: 'Al-Rashid'),
        TenantRef(id: '14', name: 'Najd'),
      ]);

      await tester.pumpWidget(BlocProvider<TenantCubit>.value(
        value: cubit,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TenantScope(
            fallbackBuilder: (_) => const Text('none', textDirection: TextDirection.ltr),
            child: Builder(builder: (context) {
              seen.add(RepositoryProvider.of<TenantDatabase>(context));
              return const SizedBox.shrink();
            }),
          ),
        ),
      ));

      await cubit.switchTo('9');
      await tester.pumpAndSettle();
      final dbA = seen.last;

      await cubit.switchTo('14');
      await tester.pumpAndSettle();
      final dbB = seen.last;

      expect(identical(dbA, dbB), false);
      expect(dbA.isOpen, false); // A closed on teardown
      expect(dbB.isOpen, true); // B fresh
      expect(dbB.tenantId, '14');

      cubit.close();
    });
  });

  test('TenantDatabase.guard blocks cross-tenant access', () {
    final db = TenantDatabase(const TenantSession(
      tenantId: '9',
      name: 'Al-Rashid',
      connection: ConnectionDescriptor(baseUrl: 'x', dbName: 'tenant_9.db'),
    ));
    expect(() => db.guard('9'), returnsNormally);
    expect(() => db.guard('14'), throwsStateError);
  });
}
