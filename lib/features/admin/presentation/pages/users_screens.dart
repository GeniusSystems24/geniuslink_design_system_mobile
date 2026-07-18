// ============================================================
// VIEW — Users & Authentication (ports MobileUsers + Team)
// usersList (with session banner) · userDetail (full, 2FA + sessions)
// createUser · rolesPermissions
// ============================================================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../core/bloc/list_cubit.dart';
import '../../../../core/bloc/form_cubit.dart';

typedef _UserRow = (int, String, String, String, String, Color);

List<_UserRow> _users(BuildContext context) => [
  (5, 'Admin User', 'admin@geniuslink.sa', 'Administrator', 'active', SuperMaterialThemeData.of(context).colorScheme.primary),
  (12, 'Layla Ahmed', 'layla.a@geniuslink.sa', 'Accountant', 'active', SuperMaterialThemeData.of(context).colorScheme.tertiary),
  (3, 'Controller', 'controller@geniuslink.sa', 'Controller', 'active', SuperMaterialThemeData.of(context).colorScheme.secondary),
  (21, 'Khalid Saleh', 'khalid.s@geniuslink.sa', 'Store Manager', 'active', SuperMaterialThemeData.of(context).superTheme.fg3),
  (33, 'Noura Faisal', 'noura.f@geniuslink.sa', 'Viewer', 'inactive', SuperMaterialThemeData.of(context).superTheme.fg3),
  (41, 'Omar Hassan', 'omar.h@geniuslink.sa', 'Accountant', 'pending', SuperMaterialThemeData.of(context).colorScheme.tertiary),
];

PillTone _uTone(String s) => s == 'active' ? PillTone.success : (s == 'pending' ? PillTone.warning : PillTone.neutral);

bool _userPredicate(_UserRow u, String q, Map<String, Object?> f) {
  final role = (f['role'] as String?) ?? 'All';
  if (role != 'All' && u.$4 != role) return false;
  final ql = q.trim().toLowerCase();
  return ql.isEmpty || u.$2.toLowerCase().contains(ql) || u.$3.toLowerCase().contains(ql);
}

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListCubit<_UserRow>>(
      create: (_) => ListCubit<_UserRow>(
        source: () => _users(context),
        predicate: _userPredicate,
        initialFilters: const {'role': 'All'},
      )..load(),
      child: const _UsersListView(),
    );
  }
}

class _UsersListView extends StatelessWidget {
  const _UsersListView();
  @override
  Widget build(BuildContext context) {
    const roles = ['All', 'Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer'];
    final cubit = context.read<ListCubit<_UserRow>>();
    return BlocBuilder<ListCubit<_UserRow>, ListState<_UserRow>>(
      builder: (context, state) {
        final visible = state.results;
        final role = (state.filters['role'] as String?) ?? 'All';
        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Users')),
      body: MScroll([
          SearchInput(placeholder: 'Search name or email…', value: state.query, onChange: cubit.setQuery),
          Segmented(options: roles, value: role, onChange: (v) => cubit.setFilter('role', v)),
          MCard(pad: 8, children: [
            for (int i = 0; i < visible.length; i++)
              GestureDetector(
                onTap: () => context.goTo('userDetail'),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(border: i < visible.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                  child: Row(children: [
                    Avatar(visible[i].$2, size: 38),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(visible[i].$2, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      const SizedBox(height: 2),
                      Text(visible[i].$3, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: visible[i].$6, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(visible[i].$4, style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      ]),
                    ])),
                    Pill(visible[i].$5, tone: _uTone(visible[i].$5)),
                  ]),
                ),
              ),
            if (visible.isEmpty) Padding(padding: EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No users match.', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 13, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
          ]),
          const _SessionBanner(),
        ]),
    );
      },
    );
  }
}

class _SessionBanner extends StatefulWidget {
  const _SessionBanner();
  @override
  State<_SessionBanner> createState() => _SessionBannerState();
}

class _SessionBannerState extends State<_SessionBanner> {
  int _left = 90;
  bool _reauth = false, _dismissed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_reauth || _dismissed) return;
      setState(() => _left = _left > 0 ? _left - 1 : 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();
    final mm = (_left ~/ 60).toString().padLeft(2, '0');
    final ss = (_left % 60).toString().padLeft(2, '0');
    final urgent = _left <= 30;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SuperMaterialThemeData.of(context).superTheme.surface,
        border: Border(left: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).colorScheme.tertiary, width: 3), top: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong), right: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong), bottom: BorderSide(color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.borderStrong)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 28, offset: Offset(0, 12))],
      ),
      child: !_reauth
          ? Row(children: [
              Icon(MIcons.of('clock'), size: 18, color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).colorScheme.tertiary),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Session expires in ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  TextSpan(text: '$mm:$ss', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: urgent ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg1)),
                ])),
                const SizedBox(height: 1),
                Text('Re-authenticate to stay signed in', style: TextStyle(fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ])),
              GestureDetector(onTap: () => setState(() => _dismissed = true), child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Dismiss', style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.fg3, fontSize: 12, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
              MBtn('Renew', icon: 'lock', onTap: () => setState(() => _reauth = true)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Icon(MIcons.of('lock'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text('Confirm your password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
              ]),
              const SizedBox(height: 12),
              const TPassword(label: 'Password', placeholder: '••••••••••'),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true, onTap: () => setState(() => _reauth = false))),
                const SizedBox(width: 10),
                Expanded(child: MBtn('Confirm', icon: 'check', full: true, onTap: () => setState(() => _dismissed = true))),
              ]),
            ]),
    );
  }
}

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});
  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool _twofa = true;
  @override
  Widget build(BuildContext context) {
    const activity = [('Posted JV-2024-0226', 'Dec 19, 10:14'), ('Created DEP-2024-0182', 'Dec 18, 09:42'), ('Edited account 1200', 'Dec 17, 16:20')];
    const sessions = [('MacBook Pro · Chrome', 'Riyadh · 10.4.22.18 · now', true), ('iPhone 15 · App', 'Riyadh · 10.4.22.51 · 2h ago', false), ('Windows · Edge', 'Jeddah · 94.12.8.140 · Yesterday', false)];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('User Detail')),
      body: MScroll([
      MCard(children: [
        Row(children: [
          Avatar('Layla Ahmed', size: 56),
          SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Layla Ahmed', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            SizedBox(height: 3),
            Text('layla.a@geniuslink.sa', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
            SizedBox(height: 6),
            Row(children: [
              _RoleChip(),
              SizedBox(width: 8),
              Pill('Active'),
            ]),
          ])),
        ]),
      ]),
      ISection(icon: 'user', title: 'Profile', marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        TInput(label: 'Full Name', defaultValue: 'Layla Ahmed'),
        TInput(label: 'Work Email', defaultValue: 'layla.a@geniuslink.sa', mono: true),
        TInput(label: 'Employee ID', defaultValue: 'EMP-0012', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Security', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Two-Factor Authentication', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
            const SizedBox(height: 2),
            Text(_twofa ? 'Enabled · Authenticator app' : 'Disabled', style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          ])),
          GestureDetector(
            onTap: () => setState(() => _twofa = !_twofa),
            child: Container(
              width: 42, height: 24,
              decoration: BoxDecoration(color: _twofa ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: _twofa ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(999)),
              child: AnimatedAlign(duration: const Duration(milliseconds: 150), alignment: _twofa ? Alignment.centerRight : Alignment.centerLeft, child: Container(width: 18, height: 18, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))),
            ),
          ),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Active Sessions', subtitle: 'Devices currently signed in', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < sessions.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < sessions.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(children: [
                  Icon(MIcons.of(sessions[i].$3 ? 'briefcase' : 'swap'), size: 17, color: SuperMaterialThemeData.of(context).superTheme.fg3),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(sessions[i].$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                      if (sessions[i].$3) const Padding(padding: EdgeInsets.only(left: 7), child: Pill('This')),
                    ]),
                    const SizedBox(height: 2),
                    Text(sessions[i].$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ])),
                  if (!sessions[i].$3) Text('Revoke', style: TextStyle(color: SuperMaterialThemeData.of(context).colorScheme.error, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Recent Activity', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < activity.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(border: i < activity.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(activity[i].$1, style: TextStyle(fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  Text(activity[i].$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ]),
              ),
          ]),
        ),
      ]),
      const MBtn('Deactivate User', variant: MBtnVariant.danger, icon: 'trash', full: true),
    ]),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip();
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        _Dot(SuperMaterialThemeData.of(context).colorScheme.tertiary),
        SizedBox(width: 5),
        Text('Accountant', style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
      ]);
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot(this.color);
  @override
  Widget build(BuildContext context) => Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Invite User')),
      body: MScroll([
      ISection(icon: 'user', title: 'Identity', sub: "The new member's name and contact", marker: SuperMaterialThemeData.of(context).colorScheme.primary, children: [
        TInput(label: 'Name English', placeholder: 'e.g. Omar Hassan', required: true),
        TInput(label: 'الاسم بالعربية', placeholder: 'مثال: عمر حسن', ar: true),
        TInput(label: 'Work Email', placeholder: 'name@geniuslink.sa', required: true),
        TInput(label: 'Employee ID', placeholder: 'Optional', mono: true),
      ]),
      ISection(icon: 'lock', title: 'Access', sub: 'Role determines default permissions', marker: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
        TSelect(label: 'Role', value: 'Accountant', options: ['Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer']),
        TSelect(label: 'Default Store', value: 'All Stores', options: ['All Stores', 'Downtown Central', 'King Fahd Warehouse', 'Jeddah Showroom']),
        InfoNote('An invitation email with a single-use setup link will be sent. The account stays Pending until the user sets a password.', tone: SuperMaterialThemeData.of(context).colorScheme.primary),
      ]),
      Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Send Invitation', icon: 'check', full: true)),
      ]),
    ]),
    );
  }
}

final _permOrder = ['none', 'view', 'edit', 'full'];
Map<String, (Color, String)> _permMeta(BuildContext context) {
  final theme = SuperMaterialThemeData.of(context).superTheme;
  return {
    'full': (SuperMaterialThemeData.of(context).colorScheme.secondary, 'Full'),
    'edit': (SuperMaterialThemeData.of(context).colorScheme.primary, 'Edit'),
    'view': (theme.fg3, 'View'),
    'none': (theme.fg4, '—'),
  };
}

final _roleModules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Users'];
final _roleNames = ['Admin', 'Controller', 'Accountant', 'Manager', 'Viewer'];
Map<String, List<String>> _defaultMatrix() => {
      'Accounts': ['full', 'edit', 'edit', 'view', 'view'], 'Stores': ['full', 'edit', 'view', 'edit', 'view'],
      'Inventory': ['full', 'edit', 'edit', 'edit', 'view'], 'Banking': ['full', 'full', 'edit', 'none', 'none'],
      'Ledger': ['full', 'full', 'edit', 'view', 'view'], 'Reports': ['full', 'full', 'view', 'view', 'view'],
      'Users': ['full', 'view', 'none', 'none', 'none'],
    };

class RolesPermissionsScreen extends StatelessWidget {
  const RolesPermissionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormCubit>(
      create: (_) => FormCubit(
        initial: {'role': 'Admin', 'matrix': _defaultMatrix()},
        onSubmit: (_) async {}, // later: await rolesRepo.save(matrix)
      ),
      child: const _RolesPermissionsView(),
    );
  }
}

class _RolesPermissionsView extends StatelessWidget {
  const _RolesPermissionsView();
  @override
  Widget build(BuildContext context) {
    final form = context.read<FormCubit>();
    return BlocBuilder<FormCubit, FormData>(
      builder: (context, state) {
        final role = state.value<String>('role') ?? 'Admin';
        final matrix = state.value<Map<String, List<String>>>('matrix') ?? _defaultMatrix();
        final ri = _roleNames.indexOf(role);

        void cycle(String module) {
          final next = {for (final e in matrix.entries) e.key: [...e.value]};
          final cur = next[module]![ri];
          next[module]![ri] = _permOrder[(_permOrder.indexOf(cur) + 1) % _permOrder.length];
          form.setField('matrix', next);
        }

        return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Roles & Permissions')),
      body: MScroll([
          MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Select Role', subtitle: "Tap a module's badge to cycle its access level", children: [
            Segmented(options: _roleNames, value: role, onChange: (v) => form.setField('role', v)),
          ]),
          MCard(pad: 8, children: [
            for (int i = 0; i < _roleModules.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                decoration: BoxDecoration(border: i < _roleModules.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(_roleModules[i], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                  GestureDetector(
                    onTap: () => cycle(_roleModules[i]),
                    child: () {
                      final lvl = matrix[_roleModules[i]]![ri];
                      final meta = _permMeta(context)[lvl]!;
                      final hasColor = lvl != 'none';
                      return Container(
                        constraints: const BoxConstraints(minWidth: 72),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(color: hasColor ? superCoreTint(meta.$1, 0x26) : Colors.transparent, border: hasColor ? null : Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(999)),
                        child: Text(meta.$2.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, color: hasColor ? meta.$1 : SuperMaterialThemeData.of(context).superTheme.fg4)),
                      );
                    }(),
                  ),
                ]),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Wrap(spacing: 18, runSpacing: 8, children: [
              for (final e in _permMeta(context).entries)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 9, height: 9, decoration: BoxDecoration(color: e.key == 'none' ? Colors.transparent : e.value.$1, border: e.key == 'none' ? Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong) : null, shape: BoxShape.circle)),
                  const SizedBox(width: 7),
                  Text(e.value.$2 == '—' ? 'No access' : e.value.$2, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg2, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                ]),
            ]),
          ),
          MBtn('Save Permissions', icon: 'check', full: true, onTap: form.submit),
        ]),
    );
      },
    );
  }
}
