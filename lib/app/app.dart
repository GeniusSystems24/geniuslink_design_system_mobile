// ============================================================
// GeniusLink Mobile — App root
// ------------------------------------------------------------
// Control-plane provider root: AuthBloc + TenantCubit live above
// the MaterialApp. Mobile boots to the login gate, so AuthBloc
// seeds unauthenticated and no tenant is active until sign-in. A
// root BlocListener links auth → tenancy: on authentication it
// loads the available tenants and activates the first; on logout
// it clears the active tenant (closing the tenant scope).
//
// ThemeCubit joins this root in Phase 2; Phase 4 adds NavCubit and
// wraps the authed shell in TenantScope (and fixed the WorkspacePage/
// AppRoot naming conflict). On logout the AuthBloc listener clears the
// tenant AND resets NavCubit back to the gate.
//
// File placement:  lib/app/app.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';
import 'bloc/theme_cubit.dart';
import '../core/tenancy/tenant_connection.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_state.dart';
import '../workspace/presentation/bloc/tenant_cubit.dart';
import '../workspace/presentation/bloc/nav_cubit.dart';
import '../app/router/app_router.dart';
import '../workspace/presentation/pages/workspace_page.dart';

class GeniusLinkApp extends StatelessWidget {
  const GeniusLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    const resolver = FakeTenantConnectionResolver();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            resolver: resolver,
            initial: const AuthState.unauthenticated(),
          ),
        ),
        BlocProvider<TenantCubit>(
          create: (_) => TenantCubit(resolver: resolver),
        ),
        BlocProvider<NavCubit>(
          create: (_) => NavCubit()
            ..registryHas = (id) => portedScreens.contains(id),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (a, b) =>
            a.status != b.status || a.availableTenants != b.availableTenants,
        listener: (context, state) {
          final tenant = context.read<TenantCubit>();
          if (state.isAuthenticated) {
            tenant.setAvailable(state.availableTenants);
            if (tenant.state.activeTenantId == null &&
                state.availableTenants.isNotEmpty) {
              tenant.switchTo(state.availableTenants.first.id);
            }
            context.read<NavCubit>().login();
          } else if (state.status == AuthStatus.unauthenticated) {
            tenant.clear();
            context.read<NavCubit>().logout();
          }
        },
        child: MaterialApp(
          title: 'GeniusLink',
          debugShowCheckedModeBanner: false,
          theme: buildMobileTheme(),
          home: const Scaffold(body: WorkspacePage()),
        ),
      ),
    );
  }
}
