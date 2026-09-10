// ============================================================
// VIEW — Accounts parity (ports MobileAccountsExtra)
// accountDetail (full, overrides the simple one) · accountTree
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_tab_bar/super_tab_bar.dart';
import 'package:super_tree_field/super_tree.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import '../../domain/domain.dart';

import '../widgets/widgets.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
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
Map<AccountType, Color> _typeDot(BuildContext context) {
  final colors = SuperMaterialThemeData.of(context).colorScheme;
  return {
    AccountType.asset: colors.primary,
    AccountType.liability: colors.tertiary,
    AccountType.equity: colors.secondary,
    AccountType.income: colors.secondary,
    AccountType.expense: colors.error,
  };
}

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
