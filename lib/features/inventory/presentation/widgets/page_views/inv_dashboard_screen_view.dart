// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class _ReorderBar extends StatelessWidget {
  final (String, String, int, int, int) p;
  const _ReorderBar({required this.p});
  @override
  Widget build(BuildContext context) {
    final tone = p.$3 == 0
        ? SuperMaterialThemeData.of(context).colorScheme.error
        : (p.$5 < 50
              ? SuperMaterialThemeData.of(context).colorScheme.tertiary
              : SuperMaterialThemeData.of(context).colorScheme.secondary);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.$2,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    p.$1,
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 10.5,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${p.$3}/${p.$4}',
              style: TextStyle(
                fontFamily: SuperMaterialThemeData.of(
                  context,
                ).textTheme.bodyMedium?.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: tone,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Stack(
            children: [
              Container(
                height: 5,
                color: SuperMaterialThemeData.of(context).superTheme.inputBg,
              ),
              FractionallySizedBox(
                widthFactor: p.$5 / 100,
                child: Container(height: 5, color: tone),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Renders the presentation for [InvDashboardScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const InvDashboardView()
/// ```
class InvDashboardView extends StatelessWidget {
  const InvDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final kpis = [
      (
        'Stock Value',
        '2.82M',
        'SAR · 5 stores',
        SuperMaterialThemeData.of(context).colorScheme.primary,
      ),
      (
        'SKUs',
        '4,891',
        '+18 this week',
        SuperMaterialThemeData.of(context).colorScheme.primary,
      ),
      (
        'Low Stock',
        '47',
        'reorder needed',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
      ),
      (
        'Out of Stock',
        '12',
        'urgent',
        SuperMaterialThemeData.of(context).colorScheme.error,
      ),
    ];
    final ops = [
      (
        'INV-REC-0241',
        'Receive',
        '+24,200',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
      ),
      (
        'INV-ISS-0089',
        'Issue',
        '-5,400',
        SuperMaterialThemeData.of(context).colorScheme.error,
      ),
      (
        'INV-TRF-0117',
        'Transfer',
        '+20,970',
        SuperMaterialThemeData.of(context).colorScheme.primary,
      ),
      (
        'INV-ADJ-0058',
        'Adjustment',
        '-307',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
      ),
    ];
    const low = [
      ('AGG-21044', 'Coarse Aggregate 20mm', 46, 80, 58),
      ('TMR-19080', 'Timber 2×4 Treated', 24, 60, 40),
      ('RBR-71203', 'Reinforcement Bar #6', 0, 100, 0),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).inventory),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.8,
          children: [
            for (final k in kpis)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: SuperMaterialThemeData.of(context).superTheme.surface,
                  border: Border.all(
                    color: SuperMaterialThemeData.of(context).superTheme.border,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Eyebrow(
                      k.$1,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                      size: 9.5,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      k.$2,
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: k.$4,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      k.$3,
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
                  ],
                ),
              ),
          ],
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).recentOperations,

          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (int i = 0; i < ops.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i < ops.length - 1
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
                                    ops[i].$1,
                                    style: TextStyle(
                                      fontFamily: SuperMaterialThemeData.of(
                                        context,
                                      ).textTheme.bodyMedium?.fontFamily,
                                      fontSize: 11,
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ops[i].$2,
                                    style: TextStyle(
                                      fontSize: 12,
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
                            Text(
                              ops[i].$3,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: ops[i].$4,
                              ),
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
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).reorderAlerts,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).text3ProductsAtOrBelowReorderLevel,
          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final p in low) _ReorderBar(p: p),
              MBtn(
                GeniusLinkLocalization.of(context).generatePurchaseOrder,
                icon: 'paperclip',
                full: true,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
