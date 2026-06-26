// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/nav_cubit.dart';

const _accounts = [
  ('1001', 'Cash Box', 'الصندوق', '42,500.00', false),
  ('1100', 'Bank · NCB Main', 'البنك الأهلي', '186,420.00', false),
  ('1200', 'Inventory (WIP)', 'مخزون', '54,890.00', false),
  ('2001', 'Accounts Payable', 'الموردون', '-23,140.00', true),
  ('4001', 'Sales Revenue', 'المبيعات', '-89,200.00', true),
];

class AccountsScreen extends StatelessWidget {
  final NavCubit nav;
  const AccountsScreen({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return MScroll([
      Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: M.input, border: Border.all(color: M.borderStrong), borderRadius: BorderRadius.circular(10)),
        child: const Row(children: [
          Icon(Icons.search_rounded, size: 16, color: M.fg3),
          SizedBox(width: 10),
          Text('Search accounts…', style: TextStyle(color: M.fg3, fontSize: 14, fontFamily: M.body)),
        ]),
      ),
      MCard(pad: 8, children: [
        for (int i = 0; i < _accounts.length; i++)
          _AccountRow(row: _accounts[i], last: i == _accounts.length - 1, onTap: () => nav.go('accountDetail')),
      ]),
    ]);
  }
}

class _AccountRow extends StatelessWidget {
  final (String, String, String, String, bool) row;
  final bool last;
  final VoidCallback onTap;
  const _AccountRow({required this.row, required this.last, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: M.border))),
        child: Row(
          children: [
            SizedBox(width: 36, child: Text(row.$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.fg3))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.$2, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: M.fg1, fontFamily: M.body)),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(row.$3, style: const TextStyle(fontFamily: M.arabic, fontSize: 12, color: M.fg3)),
                  ),
                ],
              ),
            ),
            Text(row.$4, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: row.$5 ? M.red : M.fg1)),
            const SizedBox(width: 6),
            Icon(MIcons.of('chevR'), size: 15, color: M.fg4),
          ],
        ),
      ),
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      MCard(marker: M.blue, title: 'Account Details', sub: 'Identify and place in the tree', children: [
        const MField(label: 'Account Code', placeholder: 'e.g. 1102', mono: true, required: true),
        const MField(label: 'Account Type', value: 'Asset'),
        const MField(label: 'Name English', placeholder: 'e.g. Bank · Al Rajhi', required: true),
        const MField(label: 'الاسم بالعربية', placeholder: 'مثال: بنك الراجحي', ar: true, required: true),
        MSuggest(
          label: 'Parent Group',
          value: 'Current Assets (1000)',
          placeholder: 'Search a parent group…',
          icon: 'briefcase',
          items: mSuggestions(const ['Current Assets (1000)', 'Fixed Assets (1500)', 'Liabilities (2000)', 'Equity (3000)']),
        ),
      ]),
      MCard(marker: M.green, title: 'Settings', children: [
        MSuggest(
          label: 'Currency',
          value: 'SAR — Saudi Riyal',
          placeholder: 'Search currency…',
          icon: 'globe',
          items: mSuggestions(const ['SAR — Saudi Riyal', 'USD — US Dollar', 'EUR — Euro']),
        ),
        const MField(label: 'Opening Balance', placeholder: '0.00', mono: true),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Eyebrow('Normal Balance'),
          const SizedBox(height: 7),
          Row(children: [
            Expanded(child: _toggleBox('Debit', true)),
            const SizedBox(width: 8),
            Expanded(child: _toggleBox('Credit', false)),
          ]),
        ]),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Create', icon: 'check', full: true)),
      ]),
    ]);
  }

  static Widget _toggleBox(String label, bool on) => Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on ? tint(M.green, 0x14) : M.input,
          border: Border.all(color: on ? M.green : M.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label.toUpperCase(),
            style: TextStyle(color: on ? M.green : M.fg2, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.4, fontFamily: M.body)),
      );
}

class AccountDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const AccountDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    const tx = [('JV-2024-0042', '+5,000.00', true), ('TR-9042', '-1,800.00', false), ('JV-2024-0071', '+650.00', true)];
    return MScroll([
      MCard(marker: M.green, title: 'Current Balance', right: const Pill('Active'), children: const [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('SAR', style: TextStyle(fontFamily: M.mono, fontSize: 14, color: M.fg3)),
          SizedBox(width: 8),
          Text('42,500.00', style: TextStyle(fontFamily: M.mono, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: M.green)),
        ]),
      ]),
      const MCard(marker: M.blue, title: 'Information', children: [
        KV('Code', '1001', mono: true), KV('Type', 'Asset · Cash'),
        KV('Tree', 'Assets Tree (1)'), KV('Currency', 'SAR'),
      ]),
      MCard(marker: M.green, title: 'Recent Transactions', pad: 8, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            for (int i = 0; i < tx.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: i == tx.length - 1 ? null : const Border(bottom: BorderSide(color: M.border))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(tx[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12.5, color: M.blue)),
                  Text(tx[i].$2, style: TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: tx[i].$3 ? M.green : M.red)),
                ]),
              ),
          ]),
        ),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('accounts')),
    ]);
  }
}

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Group Details', sub: 'Name and tree association', children: [
        MField(label: 'Name English', placeholder: 'e.g. Current Assets', required: true),
        MField(label: 'الاسم بالعربية', placeholder: 'مثال: الأصول المتداولة', ar: true, required: true),
        MField(label: 'Account Tree', value: 'Assets Tree (1)'),
      ]),
      const MCard(marker: M.orange, title: 'Additional Information', children: [
        MField(label: 'Note', placeholder: 'Add any notes about this group…'),
      ]),
      const Row(children: [
        Expanded(child: MBtn('Cancel', variant: MBtnVariant.secondary, full: true)),
        SizedBox(width: 10),
        Expanded(child: MBtn('Create', icon: 'check', full: true)),
      ]),
    ]);
  }
}

class GroupDetailScreen extends StatelessWidget {
  final NavCubit nav;
  const GroupDetailScreen({super.key, required this.nav});
  @override
  Widget build(BuildContext context) {
    return MScroll([
      const MCard(marker: M.blue, title: 'Group Information', right: Pill('Active'), children: [
        KV('ID', '1042', mono: true), KV('Name English', 'Current Assets'),
        KV('Name Arabic', 'الأصول المتداولة', ar: true), KV('Account Tree', 'Assets Tree (1)'),
      ]),
      MCard(marker: M.orange, title: 'Notes', children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: M.input, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
            child: const Text('تشمل النقدية والحسابات المدينة والمخزون', style: TextStyle(fontFamily: M.arabic, fontSize: 14, color: M.fg2)),
          ),
        ),
      ]),
      const MCard(marker: M.green, title: 'Audit', children: [
        KV('Created By', 'Admin User (ID: 5)'), KV('Created At', 'Dec 04, 2025 11:58 PM'),
      ]),
      MBtn('Back to List', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => nav.back('accounts')),
    ]);
  }
}
