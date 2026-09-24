part of '../../pages/currencies_screens.dart';

// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py

/// Renders the presentation for [FiscalYearSetupScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const FiscalYearSetupView()
/// ```
class FiscalYearSetupView extends StatelessWidget {
  const FiscalYearSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = Pill(GeniusLinkLocalization.of(context).open);
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon = MIcons.of('calendar');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).fiscalYear),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Year Definition',
          subtitle: GeniusLinkLocalization.of(
            context,
          ).defineTheActiveFiscalYearBoundaries,
          initiallyExpanded: true,
          accentColor: accentColor2,
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
                  label: GeniusLinkLocalization.of(context).fiscalYear,
                  value: '2024',
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).startDate,
                  value: '01/01/2024',
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 3,
                large: 3,
                child: IField(
                  label: GeniusLinkLocalization.of(context).endDate,
                  value: '12/31/2024',
                  mono: true,
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).accountingPeriods,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).text12MonthlyPeriodsLockToPreventBackDatedPostings,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SuperGrid(
                scope: SuperGridScope.current,
                gutter: 10,
                rowSpacing: 10,
                children: [
                  for (int i = 0; i < months.length; i++)
                    SuperGridCell(
                      mobile: 4,
                      tablet: 4,
                      desktop: 4,
                      large: 4,
                      child: AspectRatio(
                        aspectRatio: 1.7,
                        child: FiscalPeriodTile(
                          month: months[i],
                          state: i < 11
                              ? 'closed'
                              : (i == 11 ? 'open' : 'future'),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        InfoNote(
          GeniusLinkLocalization.of(
            context,
          ).closingAPeriodLocksAllPostingsDatedWithinItALockedPeriodCanOnlyBeReopenedByAControllerWithAuditJusti,
        ),
        const ActionRow(primary: 'Save Configuration'),
      ]),
    );
  }
}
