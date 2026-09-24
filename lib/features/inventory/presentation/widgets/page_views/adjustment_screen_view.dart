// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class _AdjLine extends StatelessWidget {
  final (String, String, int, int, String) item;
  final bool last;
  const _AdjLine({required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final delta = item.$4 - item.$3;
    final pos = delta > 0;
    final tone = delta == 0
        ? SuperMaterialThemeData.of(context).superTheme.fg2
        : (pos
              ? SuperMaterialThemeData.of(context).colorScheme.secondary
              : SuperMaterialThemeData.of(context).colorScheme.error);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: SuperMaterialThemeData.of(context).superTheme.border,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.$2,
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
                      '${item.$1} · ${item.$5}',
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
                '${pos ? '+' : ''}$delta',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: tone,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'System ',
                      style: TextStyle(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                    TextSpan(
                      text: '${item.$3}',
                      style: TextStyle(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg2,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Counted ',
                      style: TextStyle(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg3,
                      ),
                    ),
                    TextSpan(
                      text: '${item.$4}',
                      style: TextStyle(
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontFamily: SuperMaterialThemeData.of(
                      context,
                    ).textTheme.bodyMedium?.fontFamily,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Renders the presentation for [AdjustmentScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const AdjustmentView()
/// ```
class AdjustmentView extends StatelessWidget {
  const AdjustmentView({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('STL-44021', 'Structural Steel I-Beam', 142, 140, 'Damaged · 2 units'),
      (
        'CMT-90112',
        'Portland Cement Type I',
        1820,
        1834,
        'Receiving miscount · +14',
      ),
      ('AGG-21044', 'Coarse Aggregate 20mm', 48, 46, 'Spillage · 2 tons'),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var marker = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var icon = MIcons.of('doc');
    var marker2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var icon2 = MIcons.of('box');
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(
        title: Text(GeniusLinkLocalization.of(context).inventoryAdjustment),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).adjustmentDetails,

          initiallyExpanded: true,
          accentColor: marker2,
          icon: icon2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              IField(
                label: GeniusLinkLocalization.of(context).serialNo,
                value: 'INV-ADJ-2024-0058',
                mono: true,
                locked: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).reason,
                value: 'Physical Stock Count',
                select: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).store,
                placeholder: GeniusLinkLocalization.of(context).searchStore,
                icon: 'store',
                required: true,
              ),
              IField(
                label: GeniusLinkLocalization.of(context).countDate,
                placeholder: 'mm/dd/yyyy',
                mono: true,
                icon: 'calendar',
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).varianceSummary,
          subtitle: GeniusLinkLocalization.of(
            context,
          ).netFinancialImpactOfThisReconciliation,
          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Mini(label: 'Lines Adjusted', value: '3'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Mini(
                      label: GeniusLinkLocalization.of(context).netAdjustment,
                      value: '-307.00',
                      sub: 'SAR',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).adjustmentLines,

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
                    for (int i = 0; i < items.length; i++)
                      _AdjLine(item: items[i], last: i == items.length - 1),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).documentationApproval,

          initiallyExpanded: true,
          accentColor: marker,
          icon: icon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ITextarea(
                label: GeniusLinkLocalization.of(context).adjustmentNotes,
                placeholder: GeniusLinkLocalization.of(
                  context,
                ).auditorNameWitnessCountSessionReference,
              ),
              UploadBox(),
              InfoNote(
                GeniusLinkLocalization.of(
                  context,
                ).adjustmentsAbove1000SarRequireDualApprovalThisEntryPostsToTheAuditLogImmediatelyAndNotifiesTheContro,
              ),
            ],
          ),
        ),
        const ActionRow(primary: 'Post Adjustment'),
      ]),
    );
  }
}
