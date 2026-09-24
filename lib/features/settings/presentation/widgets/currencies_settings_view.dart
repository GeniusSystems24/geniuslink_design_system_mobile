part of '../pages/settings_org_screens.dart';

/// Presentation view extracted from `CurrenciesSettingsScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const CurrenciesSettingsView()
/// ```
class CurrenciesSettingsView extends StatelessWidget {
  const CurrenciesSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    const pairs = [
      ('USD', 'US Dollar', '3.750200', true),
      ('EUR', 'Euro', '4.082100', true),
      ('GBP', 'British Pound', '4.761000', true),
      ('AED', 'UAE Dirham', '1.020800', false),
      ('KWD', 'Kuwaiti Dinar', '12.18000', false),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).currencies),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).baseCurrency,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'SAR',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: superCoreTint(
                              SuperMaterialThemeData.of(
                                context,
                              ).colorScheme.primary,
                              0x24,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'BASE',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: SuperMaterialThemeData.of(
                                context,
                              ).colorScheme.primary,
                              fontFamily: SuperMaterialThemeData.of(
                                context,
                              ).textTheme.bodyMedium?.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Eff. Dec 18, 2025',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 11,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                  ],
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: MBtn(
                  GeniusLinkLocalization.of(context).pullEcbFeed,
                  variant: MBtnVariant.secondary,
                  icon: 'refresh',
                  full: true,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).ratesPer1Sar,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).autoPairsSyncDailyManualEditable,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(8),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      for (int i = 0; i < pairs.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: i < pairs.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.border,
                                    ),
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          pairs[i].$1,
                                          style: TextStyle(
                                            fontFamily:
                                                SuperMaterialThemeData.of(
                                                      context,
                                                    )
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontFamily,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: SuperMaterialThemeData.of(
                                              context,
                                            ).superTheme.fg1,
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        Pill(
                                          pairs[i].$4 ? 'Auto' : 'Manual',
                                          tone: pairs[i].$4
                                              ? PillTone.info
                                              : PillTone.neutral,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      pairs[i].$2,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.fg3,
                                        fontFamily: SuperMaterialThemeData.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: pairs[i].$4
                                    ? EdgeInsets.zero
                                    : const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                decoration: pairs[i].$4
                                    ? null
                                    : BoxDecoration(
                                        color: SuperMaterialThemeData.of(
                                          context,
                                        ).superTheme.inputBg,
                                        border: Border.all(
                                          color: SuperMaterialThemeData.of(
                                            context,
                                          ).superTheme.borderStrong,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                child: Text(
                                  pairs[i].$3,
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        MBtn(
          GeniusLinkLocalization.of(context).saveRates,
          icon: 'check',
          full: true,
        ),
      ],
    );
  }
}
