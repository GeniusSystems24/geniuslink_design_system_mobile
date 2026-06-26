// ============================================================
// VIEW — Accounts parity (ports MobileAccountsExtra)
// accountDetail (full, overrides the simple one) · accountTree
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_tab_bar/super_tab_bar.dart';
import 'package:super_tree_field/super_tree.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

// ── Tab wrapper ──────────────────────────────────────────────

class AccountsExtraTabs extends StatefulWidget {
  final NavCubit nav;
  const AccountsExtraTabs({super.key, required this.nav});
  @override
  State<AccountsExtraTabs> createState() => _AccountsExtraTabsState();
}

class _AccountsExtraTabsState extends State<AccountsExtraTabs> {
  late final SuperTabBarController _tabs = SuperTabBarController(
    tabs: const [
      BrowserTab(id: 1, title: 'Chart of Accounts', kind: GLTabKind.ledger, pinned: true),
      BrowserTab(id: 2, title: 'Account Detail', kind: GLTabKind.doc),
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
      pageBuilder: (context, tab) {
        switch (tab.id) {
          case 1:
            return AccountTreeScreen(nav: widget.nav);
          case 2:
            return AccountDetailFullScreen(nav: widget.nav);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Account detail (full)
// ════════════════════════════════════════════════════════════════

class AccountDetailFullScreen extends StatelessWidget {
  final NavCubit nav;
  const AccountDetailFullScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const tx = [
      ('JV-2024-0042', 'Dec 15, 14:22', 'Opening balance', '+5,000.00', true, '5,000.00'),
      ('JV-2024-0058', 'Dec 16, 09:14', 'Cash sale — Customer 102', '+1,250.00', true, '6,250.00'),
      ('TR-9042', 'Dec 17, 11:48', 'Transfer to NCB Bank', '-1,800.00', false, '4,450.00'),
      ('JV-2024-0071', 'Dec 18, 16:33', 'Petty cash reimbursement', '+650.00', true, '5,100.00'),
    ];
    return MScroll([
      MCard(marker: M.green, title: 'Current Balance', sub: 'As of Dec 18, 2025 16:33', right: const Pill('Active'), children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          const SizedBox(width: 8),
          Text('42,500.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, color: M.green, letterSpacing: -0.6)),
        ]),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.4, children: [
          const Mini(label: 'Total Debits', value: '148,920', sub: 'SAR'),
          const Mini(label: 'Total Credits', value: '106,420', sub: 'SAR'),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Account Information', children: [
        KV('Code', '1001', mono: true), KV('Type', 'Asset · Cash Equivalents'),
        KV('Name English', 'Cash Box'), KV('Name Arabic', 'الصندوق', ar: true),
        KV('Account Tree', 'Assets Tree (1)'), KV('Currency', 'SAR — Saudi Riyal'),
        KV('Parent Group', 'Current Assets (1000)'), KV('Tenant ID', '9', mono: true),
      ]),
      MCard(marker: M.green, title: 'Recent Transactions', sub: 'Latest entries · running balance', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < tx.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i < tx.length - 1 ? const Border(bottom: BorderSide(color: M.border)) : null),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(tx[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
                    Text(tx[i].$4, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: tx[i].$5 ? M.green : M.red)),
                  ]),
                  const SizedBox(height: 4),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text('${tx[i].$3} · ${tx[i].$2}', style: const TextStyle(fontSize: 12, color: M.fg3, fontFamily: M.body))),
                    Text('Bal ${tx[i].$6}', style: const TextStyle(fontFamily: M.mono, fontSize: 11.5, color: M.fg2)),
                  ]),
                ]),
              ),
          ]),
        ),
      ]),
      const MCard(marker: M.orange, title: 'Audit Information', children: [
        _AuditGrid(rows: [('Created By', 'Admin User (ID: 5)'), ('Created At', 'Apr 12, 2024 09:21'), ('Modified By', 'Layla A. (ID: 12)'), ('Modified At', 'Nov 02, 2025 15:48')]),
      ]),
      Row(children: [
        const Expanded(child: MBtn('Export', variant: MBtnVariant.secondary, icon: 'download', full: true)),
        const SizedBox(width: 10),
        Expanded(child: MBtn('Back', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('accounts'))),
      ]),
    ]);
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
            Eyebrow(r.$1, color: M.fg3, size: 9.5),
            const SizedBox(height: 5),
            Text(r.$2, style: const TextStyle(fontSize: 12.5, color: M.fg1, fontFamily: M.body)),
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
const Map<String, Color> _typeDot = {
  'Asset': M.blue,
  'Liability': M.orange,
  'Equity': M.green,
  'Income': M.green,
  'Expense': M.red,
};

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
  final NavCubit nav;
  const AccountTreeScreen({super.key, required this.nav});
  @override
  State<AccountTreeScreen> createState() => _AccountTreeScreenState();
}

class _AccountTreeScreenState extends State<AccountTreeScreen> {
  late final SuperTreeController<Account> _c = SuperTreeController<Account>(
    roots: _accountRoots,
    searchText: (n) => '${n.code} ${n.name} ${n.value?.type ?? ''}',
    onOpenLeaf: (node) => widget.nav.go('accountDetail'),
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
    return Padding(
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
    );
  }

  static Widget _leading(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    final color = _typeDot[node.value?.type];
    if (color == null) return const SizedBox.shrink();
    return Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  static Widget? _trailing(BuildContext context, TreeNode<Account> node, TreeRowInfo info) {
    return Text(
      _fmtAmount(_accTotal(node)),
      style: TextStyle(
        fontFamily: M.mono,
        fontSize: 12,
        fontWeight: info.depth == 0 ? FontWeight.w700 : FontWeight.w500,
        color: M.fg1,
      ),
    );
  }
}

double _accTotal(TreeNode<Account> node) {
  if (!node.hasChildren) return (node.value?.balance ?? 0).toDouble();
  return node.children!.fold<double>(0, (s, c) => s + _accTotal(c));
}
