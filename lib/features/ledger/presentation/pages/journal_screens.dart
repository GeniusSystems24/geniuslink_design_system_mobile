// ============================================================
// VIEW — Journal feature (ports MobileJournal)
// journalList · createJournalEntry · journalEntryDetail
// ============================================================

import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';

// Chart-of-accounts corpus for the journal-line account picker (MSuggest).
final _coa = <(String, String)>[
  ('1100', 'Bank · NCB Main'), ('1101', 'Bank · Al Rajhi'), ('1200', 'Accounts Receivable'),
  ('1300', 'Inventory'), ('1500', 'Fixed Assets'), ('2100', 'Accounts Payable'),
  ('2200', 'VAT Payable'), ('3001', 'Owner Capital'), ('3100', 'Retained Earnings'),
  ('4001', 'Sales Revenue'), ('5001', 'Cost of Goods Sold'), ('6001', 'Salaries Expense'),
  ('6100', 'Rent Expense'), ('6200', 'Bank Charges'), ('6300', 'Depreciation Expense'),
];

final _entries = [
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
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Journal Entries')),
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
              decoration: BoxDecoration(border: i == rows.length - 1 ? null : Border(bottom: BorderSide(color: SuperThemeData.dark.border))),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(rows[i].$1, style: const TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent)),
                      const SizedBox(width: 8),
                      Pill(rows[i].$4, tone: rows[i].$4 == 'Posted' ? PillTone.success : PillTone.warning),
                    ]),
                    const SizedBox(height: 4),
                    Text(rows[i].$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: SuperThemeData.dark.fg2, fontFamily: SuperTokens.bodyFont)),
                  ]),
                ),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(rows[i].$3, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13, fontWeight: FontWeight.w600, color: SuperThemeData.dark.fg1)),
                  const SizedBox(height: 2),
                  Text(rows[i].$5, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 10.5, color: SuperThemeData.dark.fg3)),
                ]),
              ]),
            ),
          ),
        if (rows.isEmpty) Padding(padding: EdgeInsets.symmetric(vertical: 28), child: Center(child: Text('No entries match.', style: TextStyle(color: SuperThemeData.dark.fg3, fontFamily: SuperTokens.bodyFont)))),
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
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Create Journal Entry')),
      body: MScroll([
      const ISection(icon: 'doc', title: 'Entry Header', accentColor: SuperTokens.accent, children: [
        IField(label: 'Serial No', value: 'JV-2024-0227', mono: true, locked: true),
        IField(label: 'Date', value: 'Dec 19, 2025', icon: 'calendar'),
        IField(label: 'Currency', value: 'SAR — Saudi Riyal', select: true),
        ITextarea(label: 'Description', placeholder: 'Describe this journal entry…'),
      ]),
      ISection(icon: 'ledger', title: 'Journal Lines', accentColor: SuperTokens.success, sub: '2 lines · balanced', children: [
        const _LineEditor(account: 'Bank · NCB Main (1100)', side: 'Debit', amount: '6,600.00'),
        const _LineEditor(account: 'Sales Revenue (4001)', side: 'Credit', amount: '6,600.00'),
        const AddLineBtn(),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: SuperThemeData.dark.bg, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            Expanded(child: _Total('Debits', '6,600.00', SuperThemeData.dark.fg1)),
            Expanded(child: _Total('Credits', '6,600.00', SuperThemeData.dark.fg1)),
            Expanded(child: _Total('Diff', '0.00', SuperTokens.success)),
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
      decoration: BoxDecoration(color: SuperThemeData.dark.bg, border: Border.all(color: SuperThemeData.dark.border), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          // Searchable account picker seeded with this line's current account.
          Expanded(
            child: MSuggest(
              value: account,
              placeholder: 'Search account…',
              icon: 'ledger',
              items: [
                for (final a in _coa)
                  AutoSuggestion<String>(
                    value: '${a.$2} (${a.$1})',
                    label: a.$2,
                    description: '${a.$1} · ${switch (a.$1[0]) {
                      '1' => 'Assets',
                      '2' => 'Liabilities',
                      '3' => 'Equity',
                      '4' => 'Revenue',
                      _ => 'Expenses',
                    }}',
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.only(top: 4), child: Icon(MIcons.of('trash'), size: 15, color: SuperThemeData.dark.fg3)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: superCoreTint(side == 'Debit' ? SuperTokens.accent : SuperTokens.danger, 0x1F), borderRadius: BorderRadius.circular(6)),
            child: Text(side.toUpperCase(), style: TextStyle(fontFamily: SuperTokens.bodyFont, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: side == 'Debit' ? SuperTokens.accent : SuperTokens.danger)),
          ),
          const Spacer(),
          Text(amount, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 15, fontWeight: FontWeight.w700, color: SuperThemeData.dark.fg1)),
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
          Eyebrow(label, color: SuperThemeData.dark.fg3, size: 9),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 13.5, fontWeight: FontWeight.w700, color: color)),
        ],
      );
}

class JournalEntryDetailScreen extends StatelessWidget {
  const JournalEntryDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperThemeData.dark.bg,
      appBar: AppBar(backgroundColor: SuperThemeData.dark.bg, elevation: 0, title: const Text('Journal Entry Detail')),
      body: MScroll([
      MCard(accentColor: SuperTokens.success, title: 'Journal Entry', trailing: Pill('Posted'), children: [
        Text('JV-2024-0226 · Dec 18, 2025', style: TextStyle(fontFamily: SuperTokens.monoFont, fontSize: 12, color: SuperTokens.accent)),
        Text('Mixed sale & revenue recognition', style: TextStyle(fontSize: 14, color: SuperThemeData.dark.fg1, fontFamily: SuperTokens.bodyFont)),
      ]),
      const MCard(accentColor: SuperTokens.success, title: 'Lines', pad: 16, children: [
        JournalPreview(numbered: true, rows: [
          ('Bank · NCB Main (1100)', '6,600.00', null),
          ('Sales Revenue (4001)', null, '6,000.00'),
          ('VAT Payable (2100)', null, '600.00'),
        ]),
      ]),
      const MCard(accentColor: SuperTokens.accent, title: 'Audit', children: [
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
