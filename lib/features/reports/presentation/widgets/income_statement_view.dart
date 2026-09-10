part of '../pages/reports_screens.dart';

/// Presentation view extracted from `IncomeStatementScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const IncomeStatementView()
/// ```
class IncomeStatementView extends StatefulWidget {
  const IncomeStatementView({super.key});
  @override
  State<IncomeStatementView> createState() => _IncomeStatementViewState();
}

class _IncomeStatementViewState extends State<IncomeStatementView> {
  String _period = 'Dec 2024';
  @override
  Widget build(BuildContext context) {
    final sections = [
      (
        'Revenue',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        [('4001', 'Sales Revenue', 89200), ('4002', 'Service Revenue', 14600)],
        103800,
      ),
      (
        'Cost of Sales',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [('5001', 'Cost of Goods Sold', -34120)],
        -34120,
      ),
      (
        'Operating Expenses',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [
          ('5200', 'Operating Expense', -55080),
          ('5300', 'Bank Charges', -1240),
        ],
        -56320,
      ),
    ];
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).incomeStatement),
      automaticallyImplyLeading: true,
      children: [
        ReportMeta(
          period: _period,
          onPeriod: (v) => setState(() => _period = v),
          badges: const [('Currency', 'SAR'), ('Basis', 'Accrual')],
        ),
        for (final s in sections)
          SuperSectionCard2(
            title: s.$1,

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
                    rightTone: s.$3[i].$3 < 0
                        ? SuperMaterialThemeData.of(context).colorScheme.error
                        : SuperMaterialThemeData.of(context).superTheme.fg1,
                    last: i == s.$3.length - 1,
                  ),
                ReportTotalBar(
                  label: 'Total ${s.$1}',
                  value: s.$4 < 0 ? '(${_money(s.$4)})' : _money(s.$4),
                  tone: s.$2,
                ),
              ],
            ),
          ),
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,

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
                  Text(
                    GeniusLinkLocalization.of(context).netIncome,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '13,360.00 ',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.secondary,
                          ),
                        ),
                        TextSpan(
                          text: 'SAR',
                          style: TextStyle(
                            fontSize: 12,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
