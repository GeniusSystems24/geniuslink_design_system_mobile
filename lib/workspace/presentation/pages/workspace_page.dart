// ============================================================
// VIEW — App root / navigator (ports the MobileApp shell)
// ------------------------------------------------------------
// Auth gate → tab shell (AppBar + body + TabBar) → sub-screen
// stack (AppBar + body). Reads NavController; rebuilds on notify.
// ============================================================

import 'package:flutter/material.dart';
import '../controllers/nav_controller.dart';
import '../../../design_system/kit.dart';
import '../../../app/router/app_router.dart';
import '../../../features/auth/presentation/pages/auth_screen.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});
  @override
  State<WorkspacePage> createState() => _AppRootState();
}

class _AppRootState extends State<WorkspacePage> {
  final _nav = NavController();

  @override
  void initState() {
    super.initState();
    _nav.registryHas = (id) => portedScreens.contains(id);
  }

  @override
  void dispose() {
    _nav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _nav,
      builder: (context, _) {
        final body = _buildBody();
        // Constrain to a phone-width column centered on a dark backdrop (matches mobile.html).
        return ColoredBox(
          color: const Color(0xFF0B0C10),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: M.bg,
                  boxShadow: [BoxShadow(color: Color(0x10FFFFFF), blurRadius: 0, spreadRadius: 1)],
                ),
                child: body,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    if (!_nav.authed) {
      return switch (_nav.authScreen) {
        AuthScreen.signup => SignUpScreen(nav: _nav),
        AuthScreen.forgot => ForgotScreen(nav: _nav),
        AuthScreen.login => LoginScreen(nav: _nav),
      };
    }

    // sub-screen route
    final sub = _nav.sub;
    if (sub != null) {
      // full-bleed screens render their own app bar + nav
      if (fullBleedScreens.contains(sub)) {
        return WillPopScope(
          onWillPop: () async { _nav.back(subTitles[sub]?.back); return false; },
          child: buildSubScreen(sub, _nav),
        );
      }
      final meta = subTitles[sub] ?? ScreenMeta(sub, back: _nav.tab);
      return Column(
        children: [
          MAppBar(title: meta.title, ar: meta.ar, onBack: () => _nav.back(meta.back)),
          Expanded(child: buildSubScreen(sub, _nav)),
        ],
      );
    }

    // tab shell
    final (title, action) = _tabChrome(_nav.tab);
    return Column(
      children: [
        MAppBar(title: title, action: action),
        Expanded(child: buildTabScreen(_nav.tab, _nav)),
        MTabBar(active: _nav.tab, onChange: _nav.selectTab),
      ],
    );
  }

  (String, Widget?) _tabChrome(String tab) {
    switch (tab) {
      case 'accounts':
        return ('Accounts', _actionBtn('plus', () => _nav.go('createAccount')));
      case 'stores':
        return ('Stores', _actionBtn('plus', () => _nav.go('createStore')));
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
        child: Padding(padding: const EdgeInsets.only(left: 8), child: Icon(MIcons.of(icon), size: 22, color: M.blue)),
      );
}
