part of '../pages/reports_screens.dart';

/// Presentation view extracted from `BalanceSheetScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const BalanceSheetView()
/// ```
class BalanceSheetView extends StatefulWidget {
  const BalanceSheetView({super.key});
  @override
  State<BalanceSheetView> createState() => _BalanceSheetViewState();
}

class _BalanceSheetViewState extends State<BalanceSheetView> {
  String _period = 'Dec 2024';
  @override
  Widget build(BuildContext context) {
    final blocks = [
      (
        'Assets',
        SuperMaterialThemeData.of(context).colorScheme.primary,
        [('Current Assets', 283790), ('Fixed Assets', 142000)],
        425790,
      ),
      (
        'Liabilities',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
        [('Accounts Payable', 23140), ('Long-Term Debt', 80000)],
        103140,
      ),
      (
        'Equity',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
        [('Owner Capital', 260670), ('Retained Earnings', 61980)],
        322650,
      ),
    ];
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).balanceSheet),
      automaticallyImplyLeading: true,
      children: [
        ReportMeta(
          period: _period,
          onPeriod: (v) => setState(() => _period = v),
          badges: const [('Currency', 'SAR'), ('Check', 'A = L + E')],
        ),
        for (final b in blocks)
          SuperSectionCard2(
            title: b.$1,

            initiallyExpanded: true,
            accentColor: b.$2,

            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      for (int i = 0; i < b.$3.length; i++)
                        ReportRow(
                          left: b.$3[i].$1,
                          right: _money(b.$3[i].$2),
                          last: i == b.$3.length - 1,
                        ),
                      ReportTotalBar(
                        label: 'Total ${b.$1}',
                        value: _money(b.$4),
                        tone: b.$2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: (null),

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Eyebrow(
                    GeniusLinkLocalization.of(context).balanceCheck,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    size: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        MIcons.of('check'),
                        size: 15,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).colorScheme.secondary,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '425,790 = 425,790',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.secondary,
                        ),
                      ),
                    ],
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
