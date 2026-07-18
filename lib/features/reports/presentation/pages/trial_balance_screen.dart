part of 'reports_screens.dart';

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
        ReportMeta(
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
