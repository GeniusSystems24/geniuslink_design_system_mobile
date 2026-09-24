part of '../../pages/currencies_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [CreateCurrencyScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const CreateCurrencyView()
/// ```
class CreateCurrencyView extends StatelessWidget {
  const CreateCurrencyView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var icon = MIcons.of('ledger');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('swap');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).addCurrency),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).currencyDefinition,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).isoCodeDisplayNamesAndSymbol,
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: icon2,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).isoCode,
                  placeholder: GeniusLinkLocalization.of(context).eGUsd,
                  mono: true,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).symbol,
                  placeholder: 'e.g. \$',
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).nameEnglish,
                  placeholder: GeniusLinkLocalization.of(context).eGUsDollar,
                  required: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).nameArabic,
                  placeholder: GeniusLinkLocalization.of(context).eGUsDollar,
                  ar: true,
                  required: true,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).precisionRate,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).decimalPlacesAndExchangeRateAgainstBase,
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: icon,
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).decimalPlaces,
                  value: '2',
                  select: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).exchangeRatePer1Sar,
                  placeholder: GeniusLinkLocalization.of(context).eG3750200,
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IToggle(
                  label: GeniusLinkLocalization.of(context).setAsBaseCurrency,
                  on: false,
                ),
              ),
            ],
          ),
        ),
        const ActionRow(primary: 'Add Currency'),
      ]),
    );
  }
}
