// ============================================================
// VIEW — Settings · Team & Security (ports MobileSettingsTeam)
// rolesList · roleEditor · tenants
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/form_cubit.dart';
import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../../../../workspace/presentation/bloc/tenant_state.dart';

final _roles = [
  ('admin', 'Administrator', SuperTokens.accent, 1, 'Full access to every module and settings.', [('Accounts', 'Full'), ('Banking', 'Full'), ('Users', 'Full')]),
  ('controller', 'Controller', SuperTokens.success, 1, 'Approves postings and manages the ledger.', [('Ledger', 'Full'), ('Banking', 'Full'), ('Users', 'View')]),
  ('accountant', 'Accountant', SuperTokens.warning, 2, 'Creates and edits day-to-day transactions.', [('Accounts', 'Edit'), ('Ledger', 'Edit'), ('Reports', 'View')]),
  ('manager', 'Store Manager', SuperThemeData.dark.fg3, 1, 'Manages inventory and store operations.', [('Stores', 'Edit'), ('Inventory', 'Edit'), ('Banking', '—')]),
  ('viewer', 'Viewer', SuperThemeData.dark.fg3, 1, 'Read-only access to reports and records.', [('Reports', 'View'), ('Accounts', 'View'), ('Users', '—')]),
];

Color? _lvlColor(String l) => switch (l) { 'Full' => SuperTokens.success, 'Edit' => SuperTokens.accent, 'View' => SuperThemeData.dark.fg3, _ => null };

class RolesListScreen extends StatelessWidget {
  const RolesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Roles List')),
      body: MScroll([
      for (final r in _roles)
        MCard(children: [
          Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: r.$3, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(r.$2, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
            const Spacer(),
            Text('${r.$4} member${r.$4 == 1 ? '' : 's'}', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
          ]),
          Text(r.$5, style: TextStyle(fontSize: 12.5, color: SuperThemeData.dark.fg3, height: 1.5, fontFamily: SuperTokens.bodyFont)),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperThemeData.dark.border))),
            child: Column(children: [
              for (final p in r.$6)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(p.$1, style: TextStyle(color: SuperThemeData.dark.fg2, fontFamily: SuperTokens.bodyFont, fontSize: 12)),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      if (_lvlColor(p.$2) != null) Padding(padding: const EdgeInsets.only(right: 6), child: Container(width: 6, height: 6, decoration: BoxDecoration(color: _lvlColor(p.$2), shape: BoxShape.circle))),
                      Text(p.$2.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.4, color: _lvlColor(p.$2) ?? SuperThemeData.dark.fg4, fontFamily: SuperTokens.bodyFont)),
                    ]),
                  ]),
                ),
            ]),
          ),
          MBtn('Edit Role', variant: MBtnVariant.secondary, icon: 'edit', full: true, onTap: () => context.goTo('roleEditor')),
        ]),
      MBtn('New Role', icon: 'plus', full: true, onTap: () => context.goTo('roleEditor')),
    ]),
    );
  }
}

class RoleEditorScreen extends StatelessWidget {
  const RoleEditorScreen({super.key});
  static const _modules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Customers', 'Suppliers', 'Users', 'Settings'];
  static const _cols = [('View', SuperTokens.success), ('Edit', SuperTokens.accent), ('Delete', SuperTokens.danger)];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(initial: const {
        'perms': {
          'Accounts': [true, true, false], 'Stores': [true, true, false], 'Inventory': [true, true, true], 'Banking': [true, true, false],
          'Ledger': [true, true, false], 'Reports': [true, false, false], 'Customers': [true, true, false], 'Suppliers': [true, true, false],
          'Users': [true, false, false], 'Settings': [false, false, false],
        }
      }, onSubmit: (_) async {}),
      child: const _RoleEditorView(),
    );
  }
}

class _RoleEditorView extends StatelessWidget {
  const _RoleEditorView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, state) {
        final perms = {for (final e in (state.value<Map>('perms') ?? const {}).entries) e.key as String: List<bool>.from(e.value as List)};
        void toggle(String mod, int ci) {
          final n = {for (final e in perms.entries) e.key: [...e.value]};
          n[mod]![ci] = !n[mod]![ci];
          form.setField('perms', n);
        }
        return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Role Editor')),
      body: MScroll([
          const MCard(accentColor: SuperTokens.accent, title: 'Accountant', subtitle: '2 members assigned', children: [
            TInput(label: 'Role Name', defaultValue: 'Accountant'),
          ]),
          MCard(accentColor: SuperTokens.success, title: 'Permission Matrix', subtitle: 'Tap a cell to toggle access', pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
                  child: Row(children: [
                    Expanded(child: Eyebrow('Module', color: SuperThemeData.dark.fg3, size: 9.5)),
                    for (final c in RoleEditorScreen._cols) SizedBox(width: 44, child: Center(child: Text(c.$1.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9, letterSpacing: 0.4, color: SuperThemeData.dark.fg3, fontFamily: SuperTokens.bodyFont)))),
                  ]),
                ),
                for (int i = 0; i < RoleEditorScreen._modules.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(border: i < RoleEditorScreen._modules.length - 1 ? Border(bottom: BorderSide(color: SuperThemeData.dark.border)) : null),
                    child: Row(children: [
                      Expanded(child: Text(RoleEditorScreen._modules[i], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont))),
                      for (int ci = 0; ci < RoleEditorScreen._cols.length; ci++)
                        SizedBox(
                          width: 44,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => toggle(RoleEditorScreen._modules[i], ci),
                              child: Container(
                                width: 28, height: 28, alignment: Alignment.center,
                                decoration: BoxDecoration(color: perms[RoleEditorScreen._modules[i]]![ci] ? RoleEditorScreen._cols[ci].$2 : SuperThemeData.dark.inputBg, border: Border.all(color: perms[RoleEditorScreen._modules[i]]![ci] ? RoleEditorScreen._cols[ci].$2 : SuperThemeData.dark.borderStrong), borderRadius: BorderRadius.circular(7)),
                                child: perms[RoleEditorScreen._modules[i]]![ci] ? const Icon(Icons.check_rounded, size: 15, color: Colors.white) : null,
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
              ]),
            ),
          ]),
          MBtn('Save Role', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}

class TenantsScreen extends StatelessWidget {
  const TenantsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const tenants = [(9, 'Al-Rashid Trading Co.', 'Administrator', 'Business', 6, SuperTokens.accent), (14, 'Najd Holdings', 'Controller', 'Enterprise', 28, SuperTokens.success), (22, 'Coastal Logistics', 'Accountant', 'Starter', 3, SuperTokens.warning)];
    return BlocBuilder<TenantCubit, TenantState>(
      buildWhen: (a, b) => a.activeTenantId != b.activeTenantId,
      builder: (context, tstate) {
        final activeId = tstate.activeTenantId;
        return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Workspaces')),
      body: MScroll([
          for (final t in tenants)
            MCard(children: [
              Row(children: [
                Container(width: 44, height: 44, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(t.$6, 0x1F), borderRadius: BorderRadius.circular(11)), child: Icon(MIcons.of('building'), size: 22, color: t.$6)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Flexible(child: Text(t.$2, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont))),
                    if (t.$1.toString() == activeId) const Padding(padding: EdgeInsets.only(left: 8), child: Pill('Current')),
                  ]),
                  const SizedBox(height: 3),
                  Text('Tenant ${t.$1} · ${t.$3} · ${t.$5} members', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 11, color: SuperThemeData.dark.fg3)),
                ])),
                Pill(t.$4, tone: t.$4 == 'Enterprise' ? PillTone.info : (t.$4 == 'Business' ? PillTone.success : PillTone.neutral)),
              ]),
              if (t.$1.toString() == activeId)
                const MBtn('Manage Workspace', variant: MBtnVariant.secondary, icon: 'settings', full: true)
              else
                MBtn('Switch to this Workspace', icon: 'switch2', full: true, onTap: () => context.read<TenantCubit>().switchTo(t.$1.toString())),
            ]),
          const MBtn('New Workspace', icon: 'plus', full: true),
        ]),
    );
      },
    );
  }
}
