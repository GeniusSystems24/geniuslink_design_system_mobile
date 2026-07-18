part of 'reports_screens.dart';

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
        ReportMeta(
            period: _period,
            onPeriod: (v) => setState(() => _period = v),
            badges: const [('Currency', 'SAR'), ('Check', 'A = L + E')]),
        for (final b in blocks)
          MCard(accentColor: b.$2, title: b.$1, pad: 8, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(children: [
                for (int i = 0; i < b.$3.length; i++)
                  ReportRow(
                      left: b.$3[i].$1,
                      right: _money(b.$3[i].$2),
                      last: i == b.$3.length - 1),
                ReportTotalBar(
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
