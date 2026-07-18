// ============================================================
// WORKSPACE PRESENTATION — WorkspacePage (mobile app shell)
// ------------------------------------------------------------
// Auth gate → (TenantScope) tab shell (AppBar + body + TabBar) →
// sub-screen stack (AppBar + body). Driven by NavCubit (provided
// at the app root); the authed shell is wrapped in TenantScope so
// the active tenant's connection is isolated and torn down on
// switch/logout.
//
// File placement:  lib/workspace/presentation/pages/workspace_page.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/nav_cubit.dart';
import '../widgets/tenant_scope.dart';
import '../../../app/router/navigation_extensions.dart';
import '../../../design_system/kit.dart';
import '../../../app/router/app_router.dart';
import '../../../features/auth/presentation/pages/auth_screen.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        final nav = context.read<NavCubit>();
        // Constrain to a phone-width column centered on a dark backdrop
        // (matches mobile.html).
        return ColoredBox(
          color: const Color(0xFF0B0C10),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: SuperThemeData.dark.bg,
                  boxShadow: [BoxShadow(color: Color(0x10FFFFFF), blurRadius: 0, spreadRadius: 1)],
                ),
                child: _buildBody(context, nav, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, NavCubit nav, NavState state) {
    if (!state.authed) {
      return switch (state.authScreen) {
        AuthScreen.signup => SignUpScreen(nav: nav),
        AuthScreen.forgot => ForgotScreen(nav: nav),
        AuthScreen.login => LoginScreen(nav: nav),
      };
    }
    // Authed → the tab/sub shell lives inside the tenant scope.
    return TenantScope(
      fallbackBuilder: (_) => const _TenantLoading(),
      child: _authedBody(context, nav, state),
    );
  }

  Widget _authedBody(BuildContext context, NavCubit nav, NavState state) {
    // sub-screen route
    final sub = state.sub;
    if (sub != null) {
      // full-bleed screens render their own app bar + nav
      if (fullBleedScreens.contains(sub)) {
        return WillPopScope(
          onWillPop: () async { context.goTo(subTitles[sub]?.back ?? ''); return false; },
          child: buildSubScreen(sub),
        );
      }
      final meta = subTitles[sub] ?? ScreenMeta(sub, back: state.tab);
      return Column(
        children: [
          MAppBar(title: meta.title, ar: meta.ar, onBack: () => context.goTo(meta.back)),
          Expanded(child: buildSubScreen(sub)),
        ],
      );
    }

    // tab shell
    final (title, action) = _tabChrome(context, state.tab);
    return Column(
      children: [
        if (state.tab != 'dashboard') MAppBar(title: title, action: action),
        Expanded(child: buildTabScreen(state.tab)),
        MTabBar(active: state.tab, onChange: nav.selectTab),
      ],
    );
  }

  (String, Widget?) _tabChrome(BuildContext context, String tab) {
    switch (tab) {
      case 'accounts':
        return ('Accounts', _actionBtn('plus', () => context.goTo('createAccount')));
      case 'stores':
        return ('Stores', _actionBtn('plus', () => context.goTo('createStore')));
      case 'more':
        return ('More', null);
      case 'dashboard':
      default:
        return ('Dashboard', _actionBtn('bell', () {}));
    }
  }

  Widget _actionBtn(String icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(padding: const EdgeInsets.only(left: 8), child: Icon(MIcons.of(icon), size: 22, color: SuperTokens.accent)),
      );
}

/// Shown while the active tenant's connection is resolving.
class _TenantLoading extends StatelessWidget {
  const _TenantLoading();
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SuperThemeData.dark.bg,
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2, color: SuperThemeData.dark.fg3),
        ),
      ),
    );
  }
}
