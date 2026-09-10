part of 'currencies_screens.dart';

class CurrencyDetailScreen extends StatelessWidget {
  final CurrencyDefinition currency;

  const CurrencyDetailScreen({required this.currency, super.key});

  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var trailing = Pill(
      currency.status.name,
      tone: currency.status == CurrencyStatus.active
          ? PillTone.success
          : PillTone.neutral,
    );
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).currencyDetail), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).currentRate,
          subtitle: GeniusLinkLocalization.of(context).per1BaseCurrency,
          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    currency.code,
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 14,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    currency.exchangeRate.toStringAsFixed(6),
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).definition,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              KV(GeniusLinkLocalization.of(context).isoCode, currency.code, mono: true),
              KV(GeniusLinkLocalization.of(context).symbol, currency.symbol),
              KV(GeniusLinkLocalization.of(context).nameEnglish, currency.name),
              if (currency.localizedName case final localizedName?)
                KV(GeniusLinkLocalization.of(context).localizedName, localizedName, ar: true),
              KV(GeniusLinkLocalization.of(context).decimalPlaces, '${currency.decimalPlaces}', mono: true),
              KV(GeniusLinkLocalization.of(context).source, currency.source),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).rateHistory,
          subtitle: GeniusLinkLocalization.of(context).recentUpdates,
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
                    for (int i = 0; i < currency.rateHistory.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < currency.rateHistory.length - 1
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
                            SizedBox(
                              width: 92,
                              child: Text(
                                _formatDate(
                                  currency.rateHistory[i].effectiveAt,
                                ),
                                style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 12,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                currency.rateHistory[i].rate.toStringAsFixed(6),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 112,
                              child: Text(
                                currency.rateHistory[i].source,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).superTheme.fg3,
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (currency.rateHistory.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          GeniusLinkLocalization.of(context).noRateHistoryAvailable,
                          style: TextStyle(
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg3,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MBtn(
          GeniusLinkLocalization.of(context).backToList,
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('currenciesList'),
        ),
      ]),
    );
  }

  String _formatDate(DateTime value) =>
      '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
