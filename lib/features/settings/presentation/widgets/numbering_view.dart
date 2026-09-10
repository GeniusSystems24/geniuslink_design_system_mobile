part of '../pages/settings_org_screens.dart';

/// Presentation view extracted from `NumberingScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const NumberingView()
/// ```
class NumberingView extends StatelessWidget {
  const NumberingView({super.key});
  @override
  Widget build(BuildContext context) {
    const seqs = [
      ('Sales Invoice', 'INV', '0412'),
      ('Journal Voucher', 'JV', '0227'),
      ('Deposit', 'DEP', '0183'),
      ('Purchase Order', 'PO', '0212'),
      ('Inventory Transfer', 'INV-TRF', '0118'),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).numbering),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).documentSequences,
          subtitle: GeniusLinkLocalization.of(context).formatPrefixYearNumber,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < seqs.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < seqs.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                )
                              : null,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  seqs[i].$1,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg1,
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                  ),
                                ),
                                Text(
                                  '${seqs[i].$2}-2024-${seqs[i].$3}',
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TInput(
                                    defaultValue: seqs[i].$2,
                                    mono: true,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 90,
                                  height: 46,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.inputBg,
                                    border: Border.all(
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.border,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Next ${seqs[i].$3}',
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 12,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MBtn(GeniusLinkLocalization.of(context).saveChanges, icon: 'check', full: true),
      ],
    );
  }
}
