// ============================================================
// VIEW — Accounts parity (ports MobileAccountsExtra)
// accountDetail (full, overrides the simple one) · accountTree
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_tab_bar/super_tab_bar.dart';
import 'package:super_tree_field/super_tree.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

import '../widgets/widgets.dart';
export '../widgets/widgets.dart';
part 'accounts_extra_tabs.dart';
part 'account_detail_full_screen.dart';
part 'account_tree_screen.dart';

// ── Tab wrapper ──────────────────────────────────────────────


// ════════════════════════════════════════════════════════════════
// Account detail (full)
// ════════════════════════════════════════════════════════════════


// ════════════════════════════════════════════════════════════
// Account tree — built on `SuperTree` from `super_tree_field`
// ------------------------------------------------------------
// The chart of accounts is modelled as a typed `TreeNode<Account>` forest and
// rendered by SuperTree (search · expand/collapse · keyboard · indent guides).
// Group balances roll up from the leaves; a colour-coded type dot + roll-up
// amount ride the trailing edge of every row. Single-tap opens a posting
// account (→ accountDetail). Read-only: structural editing is disabled.
// ════════════════════════════════════════════════════════════

/// Account-type colour key (matches the rest of the mobile app).
Map<String, Color> _typeDot(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return {
    'Asset': colors.primary,
    'Liability': colors.tertiary,
    'Equity': colors.secondary,
    'Income': colors.secondary,
    'Expense': colors.error,
  };
}

/// Strongly-typed payload carried by every account node.
class Account {
  final String code, nameEn, type;
  final int? balance;
  const Account({required this.code, required this.nameEn, required this.type, this.balance});
}

/// Compact authoring helper for the sample chart of accounts.
TreeNode<Account> _acc(String code, String en, String type, {int? bal, List<TreeNode<Account>> children = const []}) =>
    TreeNode<Account>(
      code: code,
      name: en,
      value: Account(code: code, nameEn: en, type: type, balance: bal),
      children: children,
    );

final List<TreeNode<Account>> _accountRoots = [
  _acc('1000', 'Assets', 'Asset', children: [
    _acc('1001', 'Current Assets', 'Asset', children: [
      _acc('1010', 'Cash Box', 'Asset', bal: 42500),
      _acc('1100', 'Bank · NCB Main', 'Asset', bal: 186420),
      _acc('1200', 'Inventory (WIP)', 'Asset', bal: 54890),
    ]),
    _acc('1500', 'Fixed Assets', 'Asset', children: [
      _acc('1510', 'Equipment', 'Asset', bal: 98000),
      _acc('1520', 'Vehicles', 'Asset', bal: 44000),
    ]),
  ]),
  _acc('2000', 'Liabilities', 'Liability', children: [
    _acc('2001', 'Accounts Payable', 'Liability', bal: 23140),
    _acc('2100', 'Long-Term Debt', 'Liability', bal: 80000),
  ]),
  _acc('3000', 'Equity', 'Equity', children: [
    _acc('3001', 'Owner Capital', 'Equity', bal: 260670),
    _acc('3100', 'Retained Earnings', 'Equity', bal: 61980),
  ]),
];

/// Thousands-grouped amount with two decimals (no intl dependency).
String _fmtAmount(num n) {
  final s = n.abs().round().toString();
  final b = StringBuffer(n < 0 ? '-' : '');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return '${b.toString()}.00';
}


double _accTotal(TreeNode<Account> node) {
  if (!node.hasChildren) return (node.value?.balance ?? 0).toDouble();
  return node.children!.fold<double>(0, (s, c) => s + _accTotal(c));
}
