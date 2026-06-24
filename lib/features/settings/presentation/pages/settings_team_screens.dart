// ============================================================
// VIEW — Settings · Team & Security (ports MobileSettingsTeam)
// rolesList · roleEditor · tenants
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

const _roles = [
  ('admin', 'Administrator', M.blue, 1, 'Full access to every module and settings.', [('Accounts', 'Full'), ('Banking', 'Full'), ('Users', 'Full')]),
  ('controller', 'Controller', M.green, 1, 'Approves postings and manages the ledger.', [('Ledger', 'Full'), ('Banking', 'Full'), ('Users', 'View')]),
  ('accountant', 'Accountant', M.orange, 2, 'Creates and edits day-to-day transactions.', [('Accounts', 'Edit'), ('Ledger', 'Edit'), ('Reports', 'View')]),
  ('manager', 'Store Manager', M.fg3, 1, 'Manages inventory and store operations.', [('Stores', 'Edit'), ('Inventory', 'Edit'), ('Banking', '—')]),
  ('viewer', 'Viewer', M.fg3, 1, 'Read-only access to reports and records.', [('Reports', 'View'), ('Accounts', 'View'), ('Users', '—')]),
];

Color? _lvlColor(String l) => switch (l) { 'Full' => M.green, 'Edit' => M.blue, 'View' => M.fg3, _ => null };

class RolesListScreen extends StatelessWidget {
  final NavController nav;
  const RolesListScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      for (final r in _roles)
        MCard(children: [
          Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: r.$3, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(r.$2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1, fontFamily: M.body)),
            const Spacer(),
            Text('${r.$4} member${r.$4 == 1 ? '' : 's'}', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
          ]),
          Text(r.$5, style: const TextStyle(fontSize: 12.5, color: M.fg3, height: 1.5, fontFamily: M.body)),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: M.border))),
            child: Column(children: [
              for (final p in r.$6)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(p.$1, style: const TextStyle(color: M.fg2, fontFamily: M.body, fontSize: 12)),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      if (_lvlColor(p.$2) != null) Padding(padding: const EdgeInsets.only(right: 6), child: Container(width: 6, height: 6, decoration: BoxDecoration(color: _lvlColor(p.$2), shape: BoxShape.circle))),
                      Text(p.$2.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.4, color: _lvlColor(p.$2) ?? M.fg4, fontFamily: M.body)),
                    ]),
                  ]),
                ),
            ]),
          ),
          MBtn('Edit Role', variant: MBtnVariant.secondary, icon: 'edit', full: true, onTap: () => nav.go('roleEditor')),
        ]),
      MBtn('New Role', icon: 'plus', full: true, onTap: () => nav.go('roleEditor')),
    ]);
  }
}

class RoleEditorScreen extends StatefulWidget {
  const RoleEditorScreen({super.key});
  @override
  State<RoleEditorScreen> createState() => _RoleEditorScreenState();
}

class _RoleEditorScreenState extends State<RoleEditorScreen> {
  static const _modules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Customers', 'Suppliers', 'Users', 'Settings'];
  final _perms = <String, List<bool>>{
    'Accounts': [true, true, false], 'Stores': [true, true, false], 'Inventory': [true, true, true], 'Banking': [true, true, false],
    'Ledger': [true, true, false], 'Reports': [true, false, false], 'Customers': [true, true, false], 'Suppliers': [true, true, false],
    'Users': [true, false, false], 'Settings': [false, false, false],
  };
  static const _cols = [('View', M.green), ('Edit', M.blue), ('Delete', M.red)];

  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Accountant', sub: '2 members assigned', children: [
        TInput(label: 'Role Name', defaultValue: 'Accountant'),
      ]),
      MCard(marker: M.green, title: 'Permission Matrix', sub: 'Tap a cell to toggle access', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: M.border))),
              child: Row(children: [
                const Expanded(child: Eyebrow('Module', color: M.fg3, size: 9.5)),
                for (final c in _cols) SizedBox(width: 44, child: Center(child: Text(c.$1.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 9, letterSpacing: 0.4, color: M.fg3, fontFamily: M.body)))),
              ]),
            ),
            for (int i = 0; i < _modules.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(border: i < _modules.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Expanded(child: Text(_modules[i], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body))),
                  for (int ci = 0; ci < _cols.length; ci++)
                    SizedBox(
                      width: 44,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => setState(() => _perms[_modules[i]]![ci] = !_perms[_modules[i]]![ci]),
                          child: Container(
                            width: 28, height: 28, alignment: Alignment.center,
                            decoration: BoxDecoration(color: _perms[_modules[i]]![ci] ? _cols[ci].$2 : M.input, border: Border.all(color: _perms[_modules[i]]![ci] ? _cols[ci].$2 : M.borderStrong), borderRadius: BorderRadius.circular(7)),
                            child: _perms[_modules[i]]![ci] ? const Icon(Icons.check_rounded, size: 15, color: Colors.white) : null,
                          ),
                        ),
                      ),
                    ),
                ]),
              ),
          ]),
        ),
      ]),
      const MBtn('Save Role', icon: 'check', full: true),
    ]);
  }
}

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({super.key});
  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  int _active = 9;
  @override
  Widget build(BuildContext context) {
    const tenants = [(9, 'Al-Rashid Trading Co.', 'Administrator', 'Business', 6, M.blue), (14, 'Najd Holdings', 'Controller', 'Enterprise', 28, M.green), (22, 'Coastal Logistics', 'Accountant', 'Starter', 3, M.orange)];
    return MScroll([
      for (final t in tenants)
        MCard(children: [
          Row(children: [
            Container(width: 44, height: 44, alignment: Alignment.center, decoration: BoxDecoration(color: tint(t.$6, 0x1F), borderRadius: BorderRadius.circular(11)), child: Icon(MIcons.of('building'), size: 22, color: t.$6)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text(t.$2, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: M.fg1, fontFamily: M.body))),
                if (t.$1 == _active) const Padding(padding: EdgeInsets.only(left: 8), child: Pill('Current')),
              ]),
              const SizedBox(height: 3),
              Text('Tenant ${t.$1} · ${t.$3} · ${t.$5} members', style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
            ])),
            Pill(t.$4, tone: t.$4 == 'Enterprise' ? PillTone.info : (t.$4 == 'Business' ? PillTone.success : PillTone.neutral)),
          ]),
          if (t.$1 == _active)
            const MBtn('Manage Workspace', variant: MBtnVariant.secondary, icon: 'settings', full: true)
          else
            MBtn('Switch to this Workspace', icon: 'switch2', full: true, onTap: () => setState(() => _active = t.$1)),
        ]),
      const MBtn('New Workspace', icon: 'plus', full: true),
    ]);
  }
}
