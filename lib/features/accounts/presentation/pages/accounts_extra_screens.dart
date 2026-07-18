// ============================================================
// VIEW — Accounts parity (ports MobileAccountsExtra)
// accountDetail (full, overrides the simple one) · accountTree
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_tab_bar/super_tab_bar.dart';
import 'package:super_tree_field/super_tree.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

// ── Tab wrapper ──────────────────────────────────────────────

class AccountsExtraTabs extends StatefulWidget {
  const AccountsExtraTabs({super.key});
  @override
  State<AccountsExtraTabs> createState() => _AccountsExtraTabsState();
}

class _AccountsExtraTabsState extends State<AccountsExtraTabs> {
  late final SuperTabBarController _tabs = SuperTabBarController(
    tabs: [
      BrowserTab(
        id: 1,
        title: 'Chart of Accounts',
        pinned: true,
        behavior: SuperTabBehavior.requiredPinned,
        leading: const Icon(Icons.account_tree_outlined, size: 15),
        pageBuilder: (context, tab) => const AccountTreeScreen(),
      ),
      BrowserTab(
        id: 2,
        title: 'Account Detail',
        leading: const Icon(Icons.description_outlined, size: 15),
        pageBuilder: (context, tab) => const AccountDetailFullScreen(),
      ),
    ],
    activeId: 1,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SuperTabBar(
      controller: _tabs,
      fillContent: true,
      scrollContent: false,
      contentPadding: EdgeInsets.zero,
      allowAutoCompact: true,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Account detail (full)
// ════════════════════════════════════════════════════════════════

class AccountDetailFullScreen extends StatelessWidget {
  const AccountDetailFullScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const tx = [
      ('JV-2024-0042', 'Dec 15, 14:22', 'Opening balance', '+5,000.00', true, '5,000.00'),
      ('JV-2024-0058', 'Dec 16, 09:14', 'Cash sale — Customer 102', '+1,250.00', true, '6,250.00'),
      ('TR-9042', 'Dec 17, 11:48', 'Transfer to NCB Bank', '-1,800.00', false, '4,450.00'),
      ('JV-2024-0071', 'Dec 18, 16:33', 'Petty cash reimbursement', '+650.00', true, '5,100.00'),
    ];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Account Detail')),
      body: MScroll([
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Current Balance', subtitle: 'As of Dec 18, 2025 16:33', trailing: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          SizedBox(width: 8),
          Text('42,500.00', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 32, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).colorScheme.secondary, letterSpacing: -0.6)),
        ]),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.4, children: const [
          Mini(label: 'Total Debits', value: '148,920', sub: 'SAR'),
          Mini(label: 'Total Credits', value: '106,420', sub: 'SAR'),
        ]),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Account Information', children: [
        KV('Code', '1001', mono: true), KV('Type', 'Asset · Cash Equivalents'),
        KV('Name English', 'Cash Box'), KV('Name Arabic', 'الصندوق', ar: true),
        KV('Account Tree', 'Assets Tree (1)'), KV('Currency', 'SAR — Saudi Riyal'),
        KV('Parent Group', 'Current Assets (1000)'), KV('Tenant ID', '9', mono: true),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, title: 'Recent Transactions', subtitle: 'Latest entries · running balance', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < tx.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < tx.length - 1 ? Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border)) : null),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(tx[i].$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                    Text(tx[i].$4, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w600, color: tx[i].$5 ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error)),
                  ]),
                  const SizedBox(height: 4),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text('${tx[i].$3} · ${tx[i].$2}', style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
                    Text('Bal ${tx[i].$6}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary, title: 'Audit Information', children: [
        _AuditGrid(rows: [('Created By', 'Admin User (ID: 5)'), ('Created At', 'Apr 12, 2024 09:21'), ('Modified By', 'Layla A. (ID: 12)'), ('Modified At', 'Nov 02, 2025 15:48')]),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Export', variant: MBtnVariant.secondary, icon: 'download', full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('accounts'))),
      ]),
    ]),
    );
  }
}

class _AuditGrid extends StatelessWidget {
  final List<(String, String)> rows;
  const _AuditGrid({required this.rows});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 4.0,
      children: [
        for (final r in rows)
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Eyebrow(r.$1, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
            const SizedBox(height: 5),
            Text(r.$2, style: TextStyle(fontSize: 12.5, color: SuperMaterialThemeData.of(context).superTheme.fg1, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          ]),
      ],
    );
  }
}

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

class AccountTreeScreen extends StatefulWidget {
  const AccountTreeScreen({super.key});
  @override
  State<AccountTreeScreen> createState() => _AccountTreeScreenState();
}

class _AccountTreeScreenState extends State<AccountTreeScreen> {
  late final SuperTreeController<Account> _c = SuperTreeController<Account>(
    roots: _accountRoots,
    searchText: (n) => '${n.code} ${n.name} ${n.value?.type ?? ''}',
    onOpenLeaf: (node) => context.goTo('accountDetail'),
  );

  @override
  void initState() {
    super.initState();
    _c.expandAll();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: AppBar(backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, elevation: 0, title: const Text('Account Tree')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SuperTree<Account>(
          controller: _c,
          leadingBuilder: _leading,
          trailingBuilder: _trailing,
          title: 'Chart of Accounts',
          subtitle: 'Roll-up balances · bilingual',
          nameColumnLabel: 'Account',
          trailingColumnLabel: 'Balance (SAR)',
          enableEditing: false,
        ),
      ),
    );
  }

  static Widget _leading(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    final color = _typeDot(context)[node.value?.type];
    if (color == null) return const SizedBox.shrink();
    return Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  static Widget? _trailing(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    return Text(
      _fmtAmount(_accTotal(node)),
      style: TextStyle(
        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
        fontSize: 12,
        fontWeight: info.depth == 0 ? FontWeight.w700 : FontWeight.w500,
        color: SuperMaterialThemeData.of(context).superTheme.fg1,
      ),
    );
  }
}

double _accTotal(TreeNode<Account> node) {
  if (!node.hasChildren) return (node.value?.balance ?? 0).toDouble();
  return node.children!.fold<double>(0, (s, c) => s + _accTotal(c));
}
