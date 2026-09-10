part of '../pages/stores_screens.dart';

/// Presentation view extracted from `IssueInventoryScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const IssueInventoryView()
/// ```
class IssueInventoryView extends StatelessWidget {
  const IssueInventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).issueInventory),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).issueDetails,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MField(
                label: GeniusLinkLocalization.of(context).serialNo,
                value: 'INV-ISS-2024-0089',
                mono: true,
              ),
              MField(
                label: GeniusLinkLocalization.of(context).store,
                placeholder: GeniusLinkLocalization.of(context).searchStore,
                required: true,
              ),
              MField(label: GeniusLinkLocalization.of(context).currency, value: 'USD — US Dollar'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).items,
          subtitle: GeniusLinkLocalization.of(context).text1Line12Units,
          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: SuperMaterialThemeData.of(context).superTheme.bg,
                  border: Border.all(
                    color: SuperMaterialThemeData.of(context).superTheme.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Structural Steel',
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
                          const SizedBox(height: 2),
                          Text(
                            '12 PCS × 450.00',
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
                    Text(
                      '5,400.00',
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg1,
                      ),
                    ),
                  ],
                ),
              ),
              _dashedAdd(context, 'scan', 'Scan to Add Item'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).total,

          initiallyExpanded: true,
          accentColor: accentColor,

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
                  Eyebrow(
                    GeniusLinkLocalization.of(context).totalValue,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    size: 12,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '5,400.00 ',
                          style: TextStyle(
                            fontFamily: SuperMaterialThemeData.of(
                              context,
                            ).textTheme.bodyMedium?.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).superTheme.fg1,
                          ),
                        ),
                        TextSpan(
                          text: 'USD',
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        MBtn(GeniusLinkLocalization.of(context).issueInventory, icon: 'check', full: true),
      ],
    );
  }

  static Widget _dashedAdd(BuildContext context, String icon, String label) =>
      Container(
        height: 44,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: DottedBorderBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MIcons.of(icon),
                size: 16,
                color: SuperMaterialThemeData.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: SuperMaterialThemeData.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                ),
              ),
            ],
          ),
        ),
      );
}
