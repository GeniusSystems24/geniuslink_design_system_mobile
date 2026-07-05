// ============================================================
// VIEW — Journal feature (ports MobileJournal)
// journalList · createJournalEntry · journalEntryDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import '../../../../design_system/adapters/inventory/m_inv_kit.dart';

// Chart-of-accounts corpus for the journal-line account picker (MSuggest).
const _coa = <(String, String)>[
  ('1100', 'Bank · NCB Main'), ('1101', 'Bank · Al Rajhi'), ('1200', 'Accounts Receivable'),
  ('1300', 'Inventory'), ('1500', 'Fixed Assets'), ('2100', 'Accounts Payable'),
  ('2200', 'VAT Payable'), ('3001', 'Owner Capital'), ('3100', 'Retained Earnings'),
  ('4001', 'Sales Revenue'), ('5001', 'Cost of Goods Sold'), ('6001', 'Salaries Expense'),
  ('6100', 'Rent Expense'), ('6200', 'Bank Charges'), ('6300', 'Depreciation Expense'),
];

const _entries = [
  ('JV-2024-0226', 'Mixed sale & revenue recognition', '3,400.00', 'Posted', 'Dec 18'),
  ('JV-2024-0225', 'Depreciation — December', '1,250.00', 'Draft', 'Dec 18'),
  ('JV-2024-0224', 'Payroll accrual', '48,900.00', 'Posted', 'Dec 17'),
  ('JV-2024-0223', 'FX revaluation — USD', '2,140.00', 'Posted', 'Dec 16'),
  ('JV-2024-0222', 'Bank charges', '320.00', 'Posted', 'Dec 15'),
];

class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});
  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  String _q = '';
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final ql = _q.trim().toLowerCase();
    final rows = _entries.where((e) {
      final hit = ql.isEmpty || '${e.$1} ${e.$2}'.toLowerCase().contains(ql);
      final fil = _filter == 'All' || e.$4 == _filter;
      return hit && fil;
    }).toList();

    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Journal Entries')),
      body: MScroll([
      SearchInput(placeholder: 'Search entries…', value: _q, onChange: (v) => setState(() => _q = v)),
      Segmented(options: const ['All', 'Posted', 'Draft'], value: _filter, onChange: (v) => setState(() => _filter = v)),
      MCard(pad: 8, children: [
        for (int i = 0; i < rows.length; i++)
          GestureDetector(
            onTap: () => context.goTo('journalEntryDetail'),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(border: i == rows.length - 1 ? null : const Border(bottom: BorderSide(color: M.border))),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(rows[i].$1, style: const TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
                      const SizedBox(width: 8),
                      Pill(rows[i].$4, tone: rows[i].$4 == 'Posted' ? PillTone.success : PillTone.warning),
                    ]),
                    const SizedBox(height: 4),
                    Text(rows[i].$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: M.fg2, fontFamily: M.body)),
                  ]),
                ),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(rows[i].$3, style: const TextStyle(fontFamily: M.mono, fontSize: 13, fontWeight: FontWeight.w600, color: M.fg1)),
                  const SizedBox(height: 2),
                  Text(rows[i].$5, style: const TextStyle(fontFamily: M.mono, fontSize: 10.5, color: M.fg3)),
                ]),
              ]),
            ),
          ),
        if (rows.isEmpty) const Padding(padding: EdgeInsets.symmetric(vertical: 28), child: Center(child: Text('No entries match.', style: TextStyle(color: M.fg3, fontFamily: M.body)))),
      ]),
    ]),
    );
  }
}

class CreateJournalEntryScreen extends StatelessWidget {
  const CreateJournalEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Create Journal Entry')),
      body: MScroll([
      const ISection(icon: 'doc', title: 'Entry Header', accentColor: M.blue, children: [
        IField(label: 'Serial No', value: 'JV-2024-0227', mono: true, locked: true),
        IField(label: 'Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Currency', value: 'SAR — Saudi Riyal', select: true),
        ITextarea(label: 'Description', placeholder: 'Describe this journal entry…'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Lines', accentColor: M.green, sub: '2 lines · balanced', children: [
        _LineEditor(account: 'Bank · NCB Main (1100)', side: 'Debit', amount: '6,600.00'),
        _LineEditor(account: 'Sales Revenue (4001)', side: 'Credit', amount: '6,600.00'),
        const AddLineBtn(),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: M.bg, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
          child: Row(children: const [
            Expanded(child: _Total('Debits', '6,600.00', M.fg1)),
            Expanded(child: _Total('Credits', '6,600.00', M.fg1)),
            Expanded(child: _Total('Diff', '0.00', M.green)),
          ]),
        ),
      ]),
      const ActionRow(primary: 'Post Entry'),
    ]),
    );
  }
}

class _LineEditor extends StatelessWidget {
  final String account, side, amount;
  const _LineEditor({required this.account, required this.side, required this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: M.bg, border: Border.all(color: M.border), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          // Account picker — type to filter the chart of accounts, free text
          // accepted (combo). Seeded with this line's current account.
          Expanded(
            child: MSuggest(
              value: account,
              placeholder: 'Search account…',
              icon: 'ledger',
              allowFreeText: true,
              items: [
                for (final a in _coa)
                  AutoSuggestion<String>(
                    value: '${a.$2} (${a.$1})',
                    label: a.$2,
                    description: a.$1,
                    group: switch (a.$1[0]) {
                      '1' => 'Assets',
                      '2' => 'Liabilities',
                      '3' => 'Equity',
                      '4' => 'Revenue',
                      _ => 'Expenses',
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.only(top: 4), child: Icon(MIcons.of('trash'), size: 15, color: M.fg3)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: tint(side == 'Debit' ? M.blue : M.red, 0x1F), borderRadius: BorderRadius.circular(6)),
            child: Text(side.toUpperCase(), style: TextStyle(fontFamily: M.body, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: side == 'Debit' ? M.blue : M.red)),
          ),
          const Spacer(),
          Text(amount, style: const TextStyle(fontFamily: M.mono, fontSize: 15, fontWeight: FontWeight.w700, color: M.fg1)),
        ]),
      ]),
    );
  }
}

class _Total extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Total(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, color: M.fg3, size: 9),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontFamily: M.mono, fontSize: 13.5, fontWeight: FontWeight.w700, color: color)),
        ],
      );
}

class JournalEntryDetailScreen extends StatelessWidget {
  const JournalEntryDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: M.bg,
      appBar: AppBar(backgroundColor: M.bg, elevation: 0, title: const Text('Journal Entry Detail')),
      body: MScroll([
      MCard(accentColor: M.green, title: 'Journal Entry', trailing: const Pill('Posted'), children: const [
        Text('JV-2024-0226 · Dec 18, 2025', style: TextStyle(fontFamily: M.mono, fontSize: 12, color: M.blue)),
        Text('Mixed sale & revenue recognition', style: TextStyle(fontSize: 14, color: M.fg1, fontFamily: M.body)),
      ]),
      const MCard(accentColor: M.green, title: 'Lines', pad: 16, children: [
        JournalPreview(numbered: true, rows: [
          ('Bank · NCB Main (1100)', '6,600.00', null),
          ('Sales Revenue (4001)', null, '6,000.00'),
          ('VAT Payable (2100)', null, '600.00'),
        ]),
      ]),
      const MCard(accentColor: M.blue, title: 'Audit', children: [
        AuditGrid(rows: [
          ('Created By', 'Layla Ahmed', false),
          ('Created At', 'Dec 18, 09:21', true),
          ('Posted By', 'Controller', false),
          ('Reference', 'INV-S-2291', true),
        ]),
      ]),
      MBtn('Back to Entries', variant: MBtnVariant.secondary, icon: 'back', full: true, onTap: () => context.goTo('journalList')),
    ]),
    );
  }
}
