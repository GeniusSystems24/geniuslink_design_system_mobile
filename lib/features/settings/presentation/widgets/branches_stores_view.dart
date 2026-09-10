part of '../pages/settings_org_screens.dart';

/// Presentation view extracted from `BranchesStoresScreen`.
///
/// The route/page boundary remains in `presentation/pages`, while this widget
/// owns the visual composition. Keeping presentation widgets separate makes
/// the view easier to reuse, test, and break down further without coupling
/// navigation to rendering details.
///
/// Example:
///
/// ```dart
/// const BranchesStoresView()
/// ```
class BranchesStoresView extends StatelessWidget {
  const BranchesStoresView({super.key});
  @override
  Widget build(BuildContext context) {
    const rows = [
      (
        'ST-001',
        'Downtown Central',
        'وسط المدينة',
        'Riyadh',
        'Store',
        'active',
      ),
      (
        'ST-002',
        'King Fahd Warehouse',
        'مستودع الملك فهد',
        'Riyadh',
        'Warehouse',
        'active',
      ),
      (
        'ST-003',
        'Jeddah Showroom',
        'صالة عرض جدة',
        'Jeddah',
        'Store',
        'active',
      ),
      ('BR-010', 'Dammam Branch', 'فرع الدمام', 'Dammam', 'Branch', 'inactive'),
    ];
    return FeaturePageScaffold(
      title: Text(GeniusLinkLocalization.of(context).branchesStores),
      automaticallyImplyLeading: true,
      children: [
        SuperSectionCard2(
          title: "",

          initiallyExpanded: true,
          accentColor: (null),

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    border: i < rows.length - 1
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
                            Text(
                              rows[i].$2,
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
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                rows[i].$3,
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
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  rows[i].$1,
                                  style: TextStyle(
                                    fontFamily: SuperMaterialThemeData.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontFamily,
                                    fontSize: 10.5,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg3,
                                  ),
                                ),
                                Text(
                                  '  ·  ',
                                  style: TextStyle(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg4,
                                    fontSize: 10.5,
                                  ),
                                ),
                                Text(
                                  rows[i].$4,
                                  style: TextStyle(
                                    fontSize: 10.5,
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
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Pill(
                            rows[i].$5,
                            tone: rows[i].$5 == 'Warehouse'
                                ? PillTone.info
                                : (rows[i].$5 == 'Branch'
                                      ? PillTone.warning
                                      : PillTone.neutral),
                          ),
                          const SizedBox(height: 5),
                          Pill(
                            rows[i].$6,
                            tone: rows[i].$6 == 'active'
                                ? PillTone.success
                                : PillTone.neutral,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        MBtn(GeniusLinkLocalization.of(context).addBranch, icon: 'plus', full: true),
      ],
    );
  }
}
