// ============================================================
// VIEW — Accounts parity (ports MobileAccountsExtra)
// accountDetail (full, overrides the simple one) · accountTree
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import 'package:geniuslink_design_system/geniuslink_tree.dart';
import '../../../../workspace/presentation/controllers/nav_controller.dart';

class AccountDetailFullScreen extends StatelessWidget {
  final NavController nav;
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
      MCard(marker: M.green, title: 'Current Balance', sub: 'As of Dec 18, 2025 16:33', right: const Pill('Active'), children:  [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          SizedBox(width: 8),
          Text('42,500.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, color: M.green, letterSpacing: -0.6)),
        ]),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.4, children: [
          Mini(label: 'Total Debits', value: '148,920', sub: 'SAR'),
          Mini(label: 'Total Credits', value: '106,420', sub: 'SAR'),
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
// Account tree — built on the design-system `Tree<Account>`.
// ------------------------------------------------------------
// The chart of accounts is modelled as a typed `TreeNode<Account>` forest and
// rendered by the shared `Tree` widget (search · expand/collapse · keyboard ·
// indent guides). Group balances roll up from the leaves; a colour-coded type
// dot + roll-up amount ride the trailing edge of every row. Single-tap toggles
// a group or opens a posting account (→ accountDetail). Read-only: structural
// editing is disabled.
// ════════════════════════════════════════════════════════════

/// Account-type colour key (matches the rest of the mobile app).
const Map<String, Color> _typeDot = {
  'Asset': M.blue,
  'Liability': M.orange,
  'Equity': M.green,
  'Income': M.green,
  'Expense': M.red,
};
const List<(String, Color)> _typeLegend = [
  ('Asset', M.blue),
  ('Liability', M.orange),
  ('Equity', M.green),
  ('Income', M.green),
  ('Expense', M.red),
];

/// Strongly-typed payload carried by every account node.
class Account {
  final String code, nameEn, type;
  final int? balance; // posting balance for leaves; null for roll-up groups
  const Account({required this.code, required this.nameEn, required this.type, this.balance});
}

/// Compact authoring helper for the sample chart of accounts.
TreeNode<Account> _acc(String code, String en, String type, {int? bal, List<TreeNode<Account>> children = const []}) =>
    TreeNode<Account>(
      id: code,
      label: en,
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

/// Roll-up: a leaf's own balance, or the sum of its descendants' balances.
int _rollup(TreeNode<Account> n) =>
    n.children.isEmpty ? (n.value?.balance ?? 0) : n.children.fold(0, (s, c) => s + _rollup(c));

/// Thousands-grouped amount with two decimals (no intl dependency).
String _fmtAmount(int n) {
  final s = n.abs().toString();
  final b = StringBuffer(n < 0 ? '-' : '');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return '${b.toString()}.00';
}

class AccountTreeScreen extends StatefulWidget {
  final NavController nav;
  const AccountTreeScreen({super.key, required this.nav});
  @override
  State<AccountTreeScreen> createState() => _AccountTreeScreenState();
}

class _AccountTreeScreenState extends State<AccountTreeScreen> {
  // Drive the shared Tree from our own controller so a single tap on a group
  // row toggles it (the default gesture for folders is double-tap).
  late final TreeController<Account> _c = TreeController<Account>(
    roots: _accountRoots,
    expanded: {for (final n in _accountRoots) n.id}, // top-level groups open
    selectionMode: TreeSelectionMode.single,
  );

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _onSelected(TreeNode<Account> n) {
    if (n.isFolder) {
      _c.toggle(n.id);
    } else {
      widget.nav.go('accountDetail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Type-colour legend.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Wrap(spacing: 16, runSpacing: 8, children: [
            for (final e in _typeLegend)
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: e.$2, shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Text(e.$1, style: const TextStyle(fontSize: 11.5, color: M.fg2, fontFamily: M.body)),
              ]),
          ]),
        ),
        // The design-system Tree fills the remaining height and scrolls
        // internally; rows are themed by the registered TreeThemeData.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Tree<Account>(
              controller: _c,
              dense: true,
              editable: false,
              showCheckboxes: false,
              showToolbar: true,
              showSearch: true,
              showFooter: true,
              onSelected: _onSelected,
              onActivated: (_) => widget.nav.go('accountDetail'),
              // Leading edge: monospace ledger code before the name.
              labelBuilder: (context, row) {
                final n = row.node;
                final isGroup = n.isFolder;
                return Row(children: [
                  Text(n.value?.code ?? n.id, style: const TextStyle(fontFamily: M.mono, fontSize: 11, color: M.fg3)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      n.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isGroup ? (row.depth == 0 ? FontWeight.w700 : FontWeight.w600) : FontWeight.w400,
                        color: M.fg1,
                        fontFamily: M.body,
                      ),
                    ),
                  ),
                ]);
              },
              // Trailing edge: type dot + roll-up balance.
              trailingBuilder: (context, row) {
                final n = row.node;
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(color: _typeDot[n.value?.type] ?? M.fg3, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _fmtAmount(_rollup(n)),
                    style: TextStyle(
                      fontFamily: M.mono,
                      fontSize: 12,
                      fontWeight: row.depth == 0 ? FontWeight.w700 : FontWeight.w500,
                      color: M.fg1,
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
