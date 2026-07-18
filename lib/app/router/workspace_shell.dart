// ============================================================
// GeniusLink Mobile — GoRouter with typed routes
// ------------------------------------------------------------
// All route definitions live here. build_runner generates
// router.g.dart from @TypedGoRoute annotations.
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:go_router/go_router.dart';

class WorkspaceShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const WorkspaceShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final tab = location.replaceAll('/', '');

    return Column(
      children: [
        Expanded(child: navigationShell),
        MTabBar(
          active: tab,
          onChange: (i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
// Local MAppBar & MTabBar (pulled from m_shell.dart)
// ════════════════════════════════════════════════════════════

class MAppBar extends StatelessWidget {
  final String title;
  final Widget? action;
  const MAppBar({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 14, 16, 12),
      decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg.withAlpha(0xEB), border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Row(children: [
        Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 19, letterSpacing: -0.4, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
        if (action != null) action!,
      ]),
    );
  }
}

class MTabBar extends StatelessWidget {
  final String active;
  final ValueChanged<int> onChange;
  const MTabBar({super.key, required this.active, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg.withAlpha(0xE6), border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      padding: EdgeInsets.only(top: 8, bottom: 8 + MediaQuery.of(context).padding.bottom),
      child: Row(children: [
        for (int i = 0; i < _tabs.length; i++)
          Expanded(child: GestureDetector(
            onTap: () => onChange(i),
            behavior: HitTestBehavior.opaque,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(MIcons.of(_tabs[i].$3), size: 22, color: active == _tabs[i].$1 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg3),
              const SizedBox(height: 4),
              Text(_tabs[i].$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, fontWeight: active == _tabs[i].$1 ? FontWeight.w700 : FontWeight.w500, color: active == _tabs[i].$1 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg3)),
            ])),
          )),
      ]),
    );
  }

  static const _tabs = [
    ('dashboard', 'Home', 'home'),
    ('accounts', 'Accounts', 'ledger'),
    ('stores', 'Stores', 'store'),
    ('more', 'More', 'grid'),
  ];
}
