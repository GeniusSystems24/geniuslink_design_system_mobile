// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import '../../../../../app/router/navigation_extensions.dart';
import '../../../../../design_system/kit.dart';
import '../../pages/inventory_shared_widgets.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Renders the presentation for [IssueDetailScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const IssueDetailView()
/// ```
class IssueDetailView extends StatelessWidget {
  const IssueDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var trailing = Pill(GeniusLinkLocalization.of(context).posted);
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).issueDetail),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).issuedValue,
          subtitle: 'INV-ISS-2024-0089 · Dec 18, 2025',
          initiallyExpanded: true,
          accentColor: accentColor,

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
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'USD',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 14,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '5,400.00',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg1,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).issueInformation,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).serialNo,
                  'INV-ISS-2024-0089',
                  mono: true,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).store,
                  'Downtown Central',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).customer,
                  'Project A-92',
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 4,
                desktop: 6,
                large: 6,
                child: KeyValueRow(
                  GeniusLinkLocalization.of(context).currency,
                  'USD — US Dollar',
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).accountingDistribution,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: SuperGrid(
            scope: SuperGridScope.current,
            children: [
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: DistRow(
                  account: '1200 — Inventory (WIP)',
                  side: 'Debit',
                  amount: '+5,400.00',
                  last: false,
                ),
              ),
              SuperGridCell(
                mobile: 4,
                tablet: 8,
                desktop: 12,
                large: 12,
                child: DistRow(
                  account: '5001 — Cost of Goods Sold',
                  side: 'Credit',
                  amount: '-5,400.00',
                  last: true,
                ),
              ),
            ],
          ),
        ),

        MBtn(
          GeniusLinkLocalization.of(context).backToOperations,
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}
