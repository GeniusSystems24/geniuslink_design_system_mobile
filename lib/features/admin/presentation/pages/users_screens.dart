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

const List<_UserRow> _users = [
  (5, 'Admin User', 'admin@geniuslink.sa', 'Administrator', 'active', M.blue),
  (12, 'Layla Ahmed', 'layla.a@geniuslink.sa', 'Accountant', 'active', M.orange),
  (3, 'Controller', 'controller@geniuslink.sa', 'Controller', 'active', M.green),
  (21, 'Khalid Saleh', 'khalid.s@geniuslink.sa', 'Store Manager', 'active', M.fg3),
  (33, 'Noura Faisal', 'noura.f@geniuslink.sa', 'Viewer', 'inactive', M.fg3),
  (41, 'Omar Hassan', 'omar.h@geniuslink.sa', 'Accountant', 'pending', M.orange),
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
        source: () => _users,
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
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Users')),
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
                  decoration: BoxDecoration(border: i < visible.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                  child: Row(children: [
                    Avatar(visible[i].$2, size: 38),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(visible[i].$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                      const SizedBox(height: 2),
                      Text(visible[i].$3, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: visible[i].$6, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(visible[i].$4, style: const TextStyle(fontSize: 11, color: M.fg3, fontFamily: M.body)),
                      ]),
                    ])),
                    Pill(visible[i].$5, tone: _uTone(visible[i].$5)),
                  ]),
                ),
              ),
            if (visible.isEmpty) const Padding(padding: EdgeInsets.symmetric(vertical: 36), child: Center(child: Text('No users match.', style: TextStyle(color: M.fg3, fontSize: 13, fontFamily: M.body)))),
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
        color: M.surface,
        border: Border(left: BorderSide(color: urgent ? M.red : M.orange, width: 3), top: BorderSide(color: urgent ? M.red : M.borderStrong), right: BorderSide(color: urgent ? M.red : M.borderStrong), bottom: BorderSide(color: urgent ? M.red : M.borderStrong)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 28, offset: Offset(0, 12))],
      ),
      child: !_reauth
          ? Row(children: [
              Icon(MIcons.of('clock'), size: 18, color: urgent ? M.red : M.orange),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(TextSpan(children: [
                  const TextSpan(text: 'Session expires in ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                  TextSpan(text: '$mm:$ss', style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: urgent ? M.red : M.fg1)),
                ])),
                const SizedBox(height: 1),
                const Text('Re-authenticate to stay signed in', style: TextStyle(fontSize: 11, color: M.fg3, fontFamily: M.body)),
              ])),
              GestureDetector(onTap: () => setState(() => _dismissed = true), child: const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Dismiss', style: TextStyle(color: M.fg3, fontSize: 12, fontFamily: M.body)))),
              MBtn('Renew', icon: 'lock', onTap: () => setState(() => _reauth = true)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Icon(MIcons.of('lock'), size: 16, color: M.blue),
                const SizedBox(width: 10),
                const Text('Confirm your password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
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
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('User Detail')),
      body: MScroll([
      const MCard(children: [
        Row(children: [
          Avatar('Layla Ahmed', size: 56),
          SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Layla Ahmed', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: M.fg1, fontFamily: M.body)),
            SizedBox(height: 3),
            Text('layla.a@geniuslink.sa', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg3)),
            SizedBox(height: 6),
            Row(children: [
              _RoleChip(),
              SizedBox(width: 8),
              Pill('Active'),
            ]),
          ])),
        ]),
      ]),
      const ISection(icon: 'user', title: 'Profile', marker: M.blue, children: [
        TInput(label: 'Full Name', defaultValue: 'Layla Ahmed'),
        TInput(label: 'Work Email', defaultValue: 'layla.a@geniuslink.sa', mono: true),
        TInput(label: 'Employee ID', defaultValue: 'EMP-0012', mono: true),
      ]),
      MCard(accentColor: M.green, title: 'Security', children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Two-Factor Authentication', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
            const SizedBox(height: 2),
            Text(_twofa ? 'Enabled · Authenticator app' : 'Disabled', style: const TextStyle(fontSize: 11.5, color: M.fg3, fontFamily: M.body)),
          ])),
          GestureDetector(
            onTap: () => setState(() => _twofa = !_twofa),
            child: Container(
              width: 42, height: 24,
              decoration: BoxDecoration(color: _twofa ? M.green : M.input, border: Border.all(color: _twofa ? M.green : M.borderStrong), borderRadius: BorderRadius.circular(999)),
              child: AnimatedAlign(duration: const Duration(milliseconds: 150), alignment: _twofa ? Alignment.centerRight : Alignment.centerLeft, child: Container(width: 18, height: 18, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))),
            ),
          ),
        ]),
      ]),
      MCard(accentColor: M.orange, title: 'Active Sessions', subtitle: 'Devices currently signed in', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < sessions.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < sessions.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(children: [
                  Icon(MIcons.of(sessions[i].$3 ? 'briefcase' : 'swap'), size: 17, color: M.fg3),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(sessions[i].$1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                      if (sessions[i].$3) const Padding(padding: EdgeInsets.only(left: 7), child: Pill('This')),
                    ]),
                    const SizedBox(height: 2),
                    Text(sessions[i].$2, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                  ])),
                  if (!sessions[i].$3) const Text('Revoke', style: TextStyle(color: M.red, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: M.body)),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: M.green, title: 'Recent Activity', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < activity.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(border: i < activity.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(activity[i].$1, style: const TextStyle(fontSize: 13, color: M.fg1, fontFamily: M.body)),
                  Text(activity[i].$2, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
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
  Widget build(BuildContext context) => const Row(mainAxisSize: MainAxisSize.min, children: [
        _Dot(M.orange),
        SizedBox(width: 5),
        Text('Accountant', style: TextStyle(fontSize: 12, color: M.fg2, fontFamily: M.body)),
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
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Invite User')),
      body: const MScroll([
      ISection(icon: 'user', title: 'Identity', sub: "The new member's name and contact", marker: M.blue, children: [
        TInput(label: 'Name English', placeholder: 'e.g. Omar Hassan', required: true),
        TInput(label: 'الاسم بالعربية', placeholder: 'مثال: عمر حسن', ar: true),
        TInput(label: 'Work Email', placeholder: 'name@geniuslink.sa', required: true),
        TInput(label: 'Employee ID', placeholder: 'Optional', mono: true),
      ]),
      ISection(icon: 'lock', title: 'Access', sub: 'Role determines default permissions', marker: M.green, children: [
        TSelect(label: 'Role', value: 'Accountant', options: ['Administrator', 'Controller', 'Accountant', 'Store Manager', 'Viewer']),
        TSelect(label: 'Default Store', value: 'All Stores', options: ['All Stores', 'Downtown Central', 'King Fahd Warehouse', 'Jeddah Showroom']),
        InfoNote('An invitation email with a single-use setup link will be sent. The account stays Pending until the user sets a password.', tone: M.blue),
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

const _permOrder = ['none', 'view', 'edit', 'full'];
const _permMeta = {'full': (M.green, 'Full'), 'edit': (M.blue, 'Edit'), 'view': (M.fg3, 'View'), 'none': (M.fg4, '—')};

const _roleModules = ['Accounts', 'Stores', 'Inventory', 'Banking', 'Ledger', 'Reports', 'Users'];
const _roleNames = ['Admin', 'Controller', 'Accountant', 'Manager', 'Viewer'];
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
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Roles & Permissions')),
      body: MScroll([
          MCard(accentColor: M.blue, title: 'Select Role', subtitle: "Tap a module's badge to cycle its access level", children: [
            Segmented(options: _roleNames, value: role, onChange: (v) => form.setField('role', v)),
          ]),
          MCard(pad: 8, children: [
            for (int i = 0; i < _roleModules.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                decoration: BoxDecoration(border: i < _roleModules.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(_roleModules[i], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                  GestureDetector(
                    onTap: () => cycle(_roleModules[i]),
                    child: () {
                      final lvl = matrix[_roleModules[i]]![ri];
                      final meta = _permMeta[lvl]!;
                      final hasColor = lvl != 'none';
                      return Container(
                        constraints: const BoxConstraints(minWidth: 72),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(color: hasColor ? tint(meta.$1, 0x26) : Colors.transparent, border: hasColor ? null : Border.all(color: M.border), borderRadius: BorderRadius.circular(999)),
                        child: Text(meta.$2.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, fontFamily: M.body, color: hasColor ? meta.$1 : M.fg4)),
                      );
                    }(),
                  ),
                ]),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Wrap(spacing: 18, runSpacing: 8, children: [
              for (final e in _permMeta.entries)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 9, height: 9, decoration: BoxDecoration(color: e.key == 'none' ? Colors.transparent : e.value.$1, border: e.key == 'none' ? Border.all(color: M.borderStrong) : null, shape: BoxShape.circle)),
                  const SizedBox(width: 7),
                  Text(e.value.$2 == '—' ? 'No access' : e.value.$2, style: const TextStyle(fontSize: 11.5, color: M.fg2, fontFamily: M.body)),
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
