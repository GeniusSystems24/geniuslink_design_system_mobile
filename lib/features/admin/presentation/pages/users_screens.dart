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

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'users_list_screen.dart';
part 'user_detail_screen.dart';
part 'create_user_screen.dart';
part 'roles_permissions_screen.dart';

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
