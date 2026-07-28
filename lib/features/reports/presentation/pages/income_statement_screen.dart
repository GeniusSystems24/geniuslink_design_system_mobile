part of 'reports_screens.dart';

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
      appBar: SuperAppBar(title: const Text('Income Statement')),
      body: MScroll([
        ReportMeta(
            period: _period,
            onPeriod: (v) => setState(() => _period = v),
            badges: const [('Currency', 'SAR'), ('Basis', 'Accrual')]),
        for (final s in sections)
          SuperSectionCard2(
      trailing: (null),
      title: s.$1,
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: s.$2,
      icon: MIcons.of('ledger'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
              for (int i = 0; i < s.$3.length; i++)
                ReportRow(
                    left: s.$3[i].$2,
                    sub: s.$3[i].$1,
                    right: s.$3[i].$3 < 0
                        ? '(${_money(s.$3[i].$3)})'
                        : _money(s.$3[i].$3),
                    rightTone: s.$3[i].$3 < 0 ? SuperMaterialThemeData.of(context).colorScheme.error : SuperMaterialThemeData.of(context).superTheme.fg1,
                    last: i == s.$3.length - 1),
              ReportTotalBar(
                  label: 'Total ${s.$1}',
                  value: s.$4 < 0 ? '(${_money(s.$4)})' : _money(s.$4),
                  tone: s.$2),
            ],
      ),
    ),
        SuperSectionCard2(
      trailing: (null),
      title: "",
      subtitle: (null),
      initiallyExpanded: true,
      accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
      icon: null,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          ],
      ),
    ),
      ]),
    );
  }
}
