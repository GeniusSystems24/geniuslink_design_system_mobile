// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import '../../../../../app/router/navigation_extensions.dart';
import '../../../../../design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Renders the presentation for [TransferListScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const TransferListView()
/// ```
class TransferListView extends StatefulWidget {
  const TransferListView({super.key});
  @override
  State<TransferListView> createState() => _TransferListScreenState();
}

class _TransferListScreenState extends State<TransferListView> {
  String _status = 'all';
  @override
  Widget build(BuildContext context) {
    const transfers = [
      (
        'INV-TRF-2024-0117',
        'ST-001',
        'ST-002',
        '20,970',
        'Dec 14',
        'in-transit',
      ),
      (
        'INV-TRF-2024-0116',
        'ST-002',
        'ST-003',
        '48,200',
        'Dec 12',
        'delivered',
      ),
      (
        'INV-TRF-2024-0115',
        'ST-004',
        'ST-001',
        '12,840',
        'Dec 10',
        'delivered',
      ),
      ('INV-TRF-2024-0114', 'ST-001', 'ST-005', '5,400', 'Dec 09', 'draft'),
      (
        'INV-TRF-2024-0113',
        'ST-002',
        'ST-001',
        '88,400',
        'Dec 07',
        'delivered',
      ),
      (
        'INV-TRF-2024-0112',
        'ST-003',
        'ST-002',
        '14,200',
        'Dec 05',
        'cancelled',
      ),
    ];
    final filters = <(String, String, Color)>[
      ('all', 'All', SuperMaterialThemeData.of(context).superTheme.fg2),
      ('draft', 'Draft', SuperMaterialThemeData.of(context).superTheme.fg2),
      (
        'in-transit',
        'Transit',
        SuperMaterialThemeData.of(context).colorScheme.tertiary,
      ),
      (
        'delivered',
        'Delivered',
        SuperMaterialThemeData.of(context).colorScheme.secondary,
      ),
      (
        'cancelled',
        'Cancelled',
        SuperMaterialThemeData.of(context).colorScheme.error,
      ),
    ];
    final visible = transfers
        .where((t) => _status == 'all' || t.$6 == _status)
        .toList();
    PillTone tone(String s) => s == 'delivered'
        ? PillTone.success
        : (s == 'in-transit'
              ? PillTone.warning
              : (s == 'cancelled' ? PillTone.danger : PillTone.neutral));
    String label(String s) =>
        s == 'in-transit' ? 'Transit' : (s[0].toUpperCase() + s.substring(1));
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).stockTransfers), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final f = filters[i];
              final on = _status == f.$1;
              return GestureDetector(
                onTap: () => setState(() => _status = f.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: on
                        ? superCoreTint(f.$3, 0x1F)
                        : SuperMaterialThemeData.of(context).superTheme.inputBg,
                    border: Border.all(
                      color: on
                          ? f.$3
                          : SuperMaterialThemeData.of(
                              context,
                            ).superTheme.border,
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    f.$2.toUpperCase(),
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: on
                          ? f.$3
                          : SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: SuperMaterialThemeData.of(context).superTheme.inputBg,
            border: Border.all(
              color: SuperMaterialThemeData.of(context).superTheme.border,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                MIcons.of('clock'),
                size: 13,
                color: SuperMaterialThemeData.of(context).superTheme.fg3,
              ),
              const SizedBox(width: 8),
              Text(
                'Dec 01 – Dec 31, 2025',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 12,
                  color: SuperMaterialThemeData.of(context).superTheme.fg2,
                ),
              ),
              const Spacer(),
              Icon(
                MIcons.of('chevD'),
                size: 13,
                color: SuperMaterialThemeData.of(context).superTheme.fg3,
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: '${visible.length} Transfers',

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < visible.length; i++)
                GestureDetector(
                  onTap: () => context.goTo('transferDetail'),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: i < visible.length - 1
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
                                visible[i].$1,
                                style: TextStyle(
                                  fontFamily: SuperMaterialThemeData.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                  fontSize: 11.5,
                                  color: SuperMaterialThemeData.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    visible[i].$2,
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
                                  Icon(
                                    MIcons.of('chevR'),
                                    size: 11,
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.fg4,
                                  ),
                                  Text(
                                    visible[i].$3,
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
                                  Text(
                                    '  · ${visible[i].$5}',
                                    style: TextStyle(
                                      color: SuperMaterialThemeData.of(
                                        context,
                                      ).superTheme.fg4,
                                      fontSize: 12,
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
                            Text(
                              visible[i].$4,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).superTheme.fg1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Pill(
                              label(visible[i].$6),
                              tone: tone(visible[i].$6),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
