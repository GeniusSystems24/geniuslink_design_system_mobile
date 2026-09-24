// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import '../../../../../design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class _CountRow extends StatelessWidget {
  final (String, String, int, int) item;
  final bool last;
  const _CountRow({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final pending = item.$4 == -1;
    final delta = pending ? 0 : item.$4 - item.$3;
    final tone = pending
        ? SuperMaterialThemeData.of(context).superTheme.fg3
        : (delta == 0
              ? SuperMaterialThemeData.of(context).colorScheme.secondary
              : (delta < 0
                    ? SuperMaterialThemeData.of(context).colorScheme.error
                    : SuperMaterialThemeData.of(context).colorScheme.tertiary));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: SuperMaterialThemeData.of(context).superTheme.border,
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$2,
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
                  '${item.$1} · exp ${item.$3}',
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                    color: SuperMaterialThemeData.of(context).superTheme.fg3,
                  ),
                ),
              ],
            ),
          ),
          if (pending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: SuperMaterialThemeData.of(context).superTheme.inputBg,
                border: Border.all(
                  color: SuperMaterialThemeData.of(context).superTheme.border,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                GeniusLinkLocalization.of(context).count,
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: SuperMaterialThemeData.of(context).superTheme.fg3,
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.$4}',
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: SuperMaterialThemeData.of(context).superTheme.fg1,
                  ),
                ),
                Text(
                  '${delta > 0 ? '+' : ''}$delta',
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: tone,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Renders the presentation for [StockTakeScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const StockTakeView()
/// ```
class StockTakeView extends StatelessWidget {
  const StockTakeView({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140),
      ('CMT-90112', 'Portland Cement Type I', 1820, 1820),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46),
      ('PLY-30022', 'Plywood Sheet 18mm', 312, -1),
      ('PNT-55310', 'Epoxy Floor Coating', 88, -1),
      ('RBR-71203', 'Reinforcement Bar #6', 0, -1),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = Pill(
      GeniusLinkLocalization.of(context).inProgress,
      tone: PillTone.warning,
    );
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).stockTake),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'STK-2024-0014',
          subtitle: 'King Fahd Warehouse · Started Dec 18, 09:14',
          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Eyebrow(
                        GeniusLinkLocalization.of(context).text3Of6Counted,
                        size: 10,
                      ),
                      Text(
                        '50%',
                        style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(
                            context,
                          ).textTheme.bodyMedium?.fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          color: SuperMaterialThemeData.of(
                            context,
                          ).superTheme.inputBg,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 8,
                            color: SuperMaterialThemeData.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SuperGrid(
                scope: SuperGridScope.current,
                gutter: 10,
                rowSpacing: 10,
                children: [
                  SuperGridCell(
                    mobile: 4,
                    tablet: 4,
                    desktop: 4,
                    large: 4,
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: Mini(
                        label: GeniusLinkLocalization.of(context).match,
                        value: '1',
                      ),
                    ),
                  ),
                  SuperGridCell(
                    mobile: 4,
                    tablet: 4,
                    desktop: 4,
                    large: 4,
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: Mini(
                        label: GeniusLinkLocalization.of(context).short,
                        value: '2',
                      ),
                    ),
                  ),
                  SuperGridCell(
                    mobile: 4,
                    tablet: 4,
                    desktop: 4,
                    large: 4,
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: Mini(
                        label: GeniusLinkLocalization.of(context).over,
                        value: '0',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).countSheet,

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
                      for (int i = 0; i < items.length; i++)
                        _CountRow(item: items[i], last: i == items.length - 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const ActionRow(primary: 'Post Stock Take'),
      ]),
    );
  }
}
