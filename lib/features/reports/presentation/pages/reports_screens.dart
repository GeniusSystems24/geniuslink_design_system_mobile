// ============================================================
// VIEW — Reports & Dashboards (ports MobileReports)
// trialBalance · incomeStatement · balanceSheet
// inventoryValuation · auditLog
// ============================================================

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

String _money(num n) {
  final v = n.abs().toStringAsFixed(2);
  final parts = v.split('.');
  final buf = StringBuffer();
  for (int i = 0; i < parts[0].length; i++) {
    if (i > 0 && (parts[0].length - i) % 3 == 0) buf.write(',');
    buf.write(parts[0][i]);
  }
  return '$buf.${parts[1]}';
}

class _ReportMeta extends StatelessWidget {
  final String period;
  final ValueChanged<String> onPeriod;
  final List<(String, String)> badges;
  const _ReportMeta(
      {required this.period, required this.onPeriod, required this.badges});
  @override
  Widget build(BuildContext context) {
    return MCard(pad: 14, children: [
      Segmented(
          options: const ['Dec 2024', 'Nov 2024', 'Q4 2024', 'FY 2024'],
          value: period,
          onChange: onPeriod),
      Wrap(spacing: 16, runSpacing: 8, children: [
        for (final b in badges)
          Row(mainAxisSize: MainAxisSize.min, children: [
            Eyebrow(b.$1, color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
            const SizedBox(width: 7),
            Text(b.$2,
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          ]),
      ]),
    ]);
  }
}

class _RRow extends StatelessWidget {
  final String left;
  final String? sub;
  final String right;
  final Color? rightTone;
  final bool bold, last;
  const _RRow(
      {required this.left,
      this.sub,
      required this.right,
      this.rightTone,
      this.bold = false,
      this.last = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border:
              last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Row(children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(left,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                  color: SuperMaterialThemeData.of(context).superTheme.fg1,
                  fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
          if (sub != null)
            Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(sub!,
                    style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
        ])),
        Text(right,
            style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                fontSize: 13.5,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                color: rightTone ?? SuperMaterialThemeData.of(context).superTheme.fg1)),
      ]),
    );
  }
}

class _TotalBar extends StatelessWidget {
  final String label, value;
  final Color? tone;
  const _TotalBar({required this.label, required this.value, this.tone});
  @override
  Widget build(BuildContext context) {
    final resolvedTone = tone ?? SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
          color: superCoreTint(resolvedTone, 0x14),
          border: Border.all(color: superCoreTint(resolvedTone, 0x4D)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Eyebrow(label, color: resolvedTone, size: 11),
        Text(value,
            style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: SuperMaterialThemeData.of(context).superTheme.fg1)),
      ]),
    );
  }
}

class TrialBalanceScreen extends StatefulWidget {
  const TrialBalanceScreen({super.key});
  @override
  State<TrialBalanceScreen> createState() => _TrialBalanceScreenState();
}

class _TrialBalanceScreenState extends State<TrialBalanceScreen> {
  String _period = 'Dec 2024';
  @override
  Widget build(BuildContext context) {
    const rows = [
      ('1001', 'Cash Box', 42500, 0),
      ('1100', 'Bank · NCB Main', 186420, 0),
      ('1200', 'Inventory (WIP)', 54890, 0),
      ('2001', 'Accounts Payable', 0, 23140),
      ('3001', 'Owner Capital', 0, 260670),
      ('4001', 'Sales Revenue', 0, 89200),
      ('5001', 'Cost of Goods Sold', 34120, 0),
      ('5200', 'Operating Expense', 55080, 0)
    ];
    final totDr = rows.fold<int>(0, (s, r) => s + r.$3);
    final totCr = rows.fold<int>(0, (s, r) => s + r.$4);
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Trial Balance'),
      body: MScroll([
        _ReportMeta(
            period: _period,
            onPeriod: (v) => setState(() => _period = v),
            badges: const [
              ('Currency', 'SAR'),
              ('Basis', 'Accrual'),
              ('Status', 'Balanced')
            ]),
        MCard(
            accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
            title: 'All Accounts',
            subtitle: 'Debit & credit balances as of period end',
            pad: 8,
            children: [
              MTable(
                columns: [
                  const MCol('code', 'Code', fixed: 60, mono: true),
                  const MCol('account', 'Account', flex: 1, bold: true),
                  MCol('debit', 'Debit',
                      fixed: 110,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => switch (v) {
                            final int n when n != 0 => _money(n),
                            _ => '\u2014'
                          },
                      styles: {
                        (_, __, row, cell) => (cell.value as num?) != 0:
                            CellStyle(foreground: SuperMaterialThemeData.of(context).colorScheme.secondary),
                        (_, __, row, cell) => true:
                            CellStyle(foreground: SuperMaterialThemeData.of(context).superTheme.fg4),
                      }),
                  MCol('credit', 'Credit',
                      fixed: 110,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => switch (v) {
                            final int n when n != 0 => _money(n),
                            _ => '\u2014'
                          },
                      styles: {
                        (_, __, row, cell) => (cell.value as num?) != 0:
                            CellStyle(foreground: SuperMaterialThemeData.of(context).colorScheme.error),
                        (_, __, row, cell) => true:
                            CellStyle(foreground: SuperMaterialThemeData.of(context).superTheme.fg4),
                      }),
                ],
                rows: [
                  for (final r in rows)
                    {
                      'code': r.$1,
                      'account': r.$2,
                      'debit': r.$3,
                      'credit': r.$4
                    }
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [
                  Expanded(
                      child: Eyebrow('Totals · balanced',
                          color: SuperMaterialThemeData.of(context).colorScheme.secondary, size: 10)),
                  SizedBox(
                      width: 110,
                      child: Text(_money(totDr),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: SuperMaterialThemeData.of(context).colorScheme.secondary))),
                  SizedBox(
                      width: 110,
                      child: Text(_money(totCr),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: SuperMaterialThemeData.of(context).colorScheme.secondary))),
                ]),
              ),
            ]),
        const MBtn('Export PDF',
            variant: MBtnVariant.secondary, icon: 'download', full: true),
      ]),
    );
  }
}

class IncomeStatementScreen extends StatefulWidget {
  const IncomeStatementScreen({super.key});
  @override
  State<IncomeStatementScreen> createState() => _IncomeStatementScreenState();
}

class _IncomeStatementScreenState extends State<IncomeStatementScreen> {
  String _period = 'Dec 2024';
  @override
  Widget build(BuildContext context) {
    final sections = [
      (
        'Revenue',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        [('4001', 'Sales Revenue', 89200), ('4002', 'Service Revenue', 14600)],
        103800
      ),
      (
        'Cost of Sales',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [('5001', 'Cost of Goods Sold', -34120)],
        -34120
      ),
      (
        'Operating Expenses',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [
          ('5200', 'Operating Expense', -55080),
          ('5300', 'Bank Charges', -1240)
        ],
        -56320
      ),
    ];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Income Statement'),
      body: MScroll([
        _ReportMeta(
            period: _period,
            onPeriod: (v) => setState(() => _period = v),
            badges: const [('Currency', 'SAR'), ('Basis', 'Accrual')]),
        for (final s in sections)
          ISection(icon: 'ledger', title: s.$1, marker: s.$2, children: [
            for (int i = 0; i < s.$3.length; i++)
              _RRow(
                  left: s.$3[i].$2,
                  sub: s.$3[i].$1,
                  right: s.$3[i].$3 < 0
                      ? '(${_money(s.$3[i].$3)})'
                      : _money(s.$3[i].$3),
                  rightTone: s.$3[i].$3 < 0 ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg1,
                  last: i == s.$3.length - 1),
            _TotalBar(
                label: 'Total ${s.$1}',
                value: s.$4 < 0 ? '(${_money(s.$4)})' : _money(s.$4),
                tone: s.$2),
          ]),
        MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('Net Income',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: SuperMaterialThemeData.of(context).superTheme.fg1,
                        fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '13,360.00 ',
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(context).colorScheme.secondary)),
                  TextSpan(
                      text: 'SAR',
                      style: TextStyle(fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ])),
              ]),
        ]),
      ]),
    );
  }
}

class BalanceSheetScreen extends StatefulWidget {
  const BalanceSheetScreen({super.key});
  @override
  State<BalanceSheetScreen> createState() => _BalanceSheetScreenState();
}

class _BalanceSheetScreenState extends State<BalanceSheetScreen> {
  String _period = 'Dec 2024';
  @override
  Widget build(BuildContext context) {
    final blocks = [
      (
        'Assets',
        SuperMaterialThemeData.of(context).colorScheme.primary,
        [('Current Assets', 283790), ('Fixed Assets', 142000)],
        425790
      ),
      (
        'Liabilities',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [('Accounts Payable', 23140), ('Long-Term Debt', 80000)],
        103140
      ),
      (
        'Equity',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        [('Owner Capital', 260670), ('Retained Earnings', 61980)],
        322650
      ),
    ];
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Balance Sheet'),
      body: MScroll([
        _ReportMeta(
            period: _period,
            onPeriod: (v) => setState(() => _period = v),
            badges: const [('Currency', 'SAR'), ('Check', 'A = L + E')]),
        for (final b in blocks)
          MCard(accentColor: b.$2, title: b.$1, pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < b.$3.length; i++)
                  _RRow(
                      left: b.$3[i].$1,
                      right: _money(b.$3[i].$2),
                      last: i == b.$3.length - 1),
                _TotalBar(
                    label: 'Total ${b.$1}', value: _money(b.$4), tone: b.$2),
              ]),
            ),
          ]),
        MCard(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Eyebrow('Balance Check', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 12),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(MIcons.of('check'), size: 15, color: SuperMaterialThemeData.of(context).colorScheme.secondary),
              const SizedBox(width: 7),
              Text('425,790 = 425,790',
                  style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: SuperMaterialThemeData.of(context).colorScheme.secondary)),
            ]),
          ]),
        ]),
      ]),
    );
  }
}

class InventoryValuationScreen extends StatefulWidget {
  const InventoryValuationScreen({super.key});
  @override
  State<InventoryValuationScreen> createState() =>
      _InventoryValuationScreenState();
}

class _InventoryValuationScreenState extends State<InventoryValuationScreen> {
  String _store = 'All';
  @override
  Widget build(BuildContext context) {
    const rows = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 450.0, 'Downtown'),
      ('CMT-90112', 'Portland Cement Type I', 1820, 24.5, 'King Fahd'),
      ('AGG-21044', 'Coarse Aggregate 20mm', 46, 125.0, 'Downtown'),
      ('PLY-30022', 'Plywood Sheet 18mm', 312, 92.0, 'Jeddah'),
      ('RBR-71203', 'Reinforcement Bar #6', 0, 78.0, 'Downtown')
    ];
    final visible =
        _store == 'All' ? rows : rows.where((r) => r.$5 == _store).toList();
    final total = visible.fold<double>(0, (s, r) => s + r.$3 * r.$4);
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Inventory Valuation'),
      body: MScroll([
        MCard(pad: 14, children: [
          Segmented(
              options: const ['All', 'Downtown', 'King Fahd', 'Jeddah'],
              value: _store,
              onChange: (v) => setState(() => _store = v)),
          Row(children: [
            Eyebrow('Method', color: SuperMaterialThemeData.of(context).superTheme.fg3, size: 9.5),
            SizedBox(width: 7),
            Text('Weighted Avg',
                style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          ]),
        ]),
        MCard(
            accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
            title: 'Stock Valuation',
            subtitle: 'Quantity × weighted-average unit cost',
            pad: 8,
            children: [
              MTable(
                showSearch: true,
                searchHint: 'Search SKU, product or store…',
                itemNoun: 'item',
                itemNounPlural: 'items',
                columns: [
                  const MCol('item', 'Item', flex: 1),
                  MCol('qty', 'Qty',
                      fixed: 70,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => switch (v) {
                            final int n when n != 0 => '$n',
                            _ => '\u2014'
                          }),
                  MCol('value', 'Value',
                      fixed: 110,
                      align: TextAlign.right,
                      numeric: true,
                      format: (v) => _money((v as num?) ?? 0)),
                ],
                rows: [
                  for (final r in visible)
                    {
                      'item': '${r.$2}\n${r.$1} · ${r.$5} · ${_money(r.$4)}',
                      'qty': r.$3,
                      'value': r.$3 * r.$4
                    }
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _TotalBar(
                    label: 'Total Inventory Value', value: _money(total)),
              ),
            ]),
      ]),
    );
  }
}

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});
  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  String _act = 'All';
  @override
  Widget build(BuildContext context) {
    const logs = [
      (
        '2025-12-19 10:14:02',
        'Layla A.',
        'POST',
        'JV-2024-0226',
        '10.4.22.18',
        PillTone.success
      ),
      (
        '2025-12-18 11:02:55',
        'Layla A.',
        'CREATE',
        'EXT-2024-0311',
        '10.4.22.18',
        PillTone.info
      ),
      (
        '2025-12-18 10:05:31',
        'Controller',
        'APPROVE',
        'DEP-2024-0182',
        '10.4.22.03',
        PillTone.success
      ),
      (
        '2025-12-18 09:42:10',
        'Layla A.',
        'CREATE',
        'DEP-2024-0182',
        '10.4.22.18',
        PillTone.info
      ),
      (
        '2025-12-17 16:20:44',
        'Layla A.',
        'EDIT',
        'Account 1200',
        '10.4.22.18',
        PillTone.warning
      ),
      (
        '2025-12-12 14:08:09',
        'Admin',
        'VOID',
        'JV-2024-0150',
        '10.4.22.01',
        PillTone.danger
      ),
      (
        '2025-12-01 00:00:01',
        'System',
        'LOCK',
        'Period Nov 2024',
        'internal',
        PillTone.neutral
      ),
    ];
    final visible = logs.where((l) => _act == 'All' || l.$3 == _act).toList();
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Audit Log'),
      body: MScroll([
        Segmented(options: const [
          'All',
          'POST',
          'CREATE',
          'APPROVE',
          'EDIT',
          'VOID',
          'LOCK'
        ], value: _act, onChange: (v) => setState(() => _act = v)),
        MCard(
            accentColor: SuperMaterialThemeData.of(context).colorScheme.tertiary,
            title: 'Immutable Activity Trail',
            subtitle: 'Every state-changing action · 7-year retention',
            pad: 8,
            children: [
              MTable(
                showSearch: true,
                searchHint: 'Search entity or user…',
                itemNoun: 'event',
                itemNounPlural: 'events',
                columns: const [
                  MCol('entity', 'Entity', flex: 1),
                  MCol('action', 'Action', fixed: 100),
                ],
                rows: [
                  for (final l in visible)
                    {
                      'entity': '${l.$4}\n${l.$2} · ${l.$5} · ${l.$1}',
                      'action': l.$3
                    },
                ],
              ),
              if (visible.isEmpty)
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                        child: Text('No log entries match.',
                            style: TextStyle(
                                color: SuperMaterialThemeData.of(context).superTheme.fg3,
                                fontSize: 13,
                                fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily)))),
            ]),
      ]),
    );
  }
}
