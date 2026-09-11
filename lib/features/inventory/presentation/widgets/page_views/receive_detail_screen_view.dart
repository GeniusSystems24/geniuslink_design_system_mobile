// componentized-by: dismantle_config_contacts_dashboard_inventory_ledger_pages.py
import 'package:flutter/material.dart';
import '../../../../../app/router/navigation_extensions.dart';
import '../../../../../design_system/kit.dart';
import '../../pages/inventory_shared_widgets.dart';

import 'package:gl_mobile_app/features/accounts/presentation/widgets/audit_column.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

/// Renders the presentation for [ReceiveDetailScreen].
///
/// This widget contains the screen's existing layout and presentation
/// state while the corresponding `*Screen` file remains a small public
/// navigation/compatibility boundary. Business and data-layer behavior
/// is intentionally not introduced by this refactor.
///
/// Example:
///
/// ```dart
/// const ReceiveDetailView()
/// ```
class ReceiveDetailView extends StatelessWidget {
  const ReceiveDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('Portland Cement Type I', '400 BAG × 24.50', '9,800.00'),
      ('Structural Steel I-Beam', '32 PCS × 450.00', '14,400.00'),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = Pill(GeniusLinkLocalization.of(context).posted);
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(GeniusLinkLocalization.of(context).receiveDetail), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: GeniusLinkLocalization.of(context).receivedValue,
          subtitle: 'INV-REC-2024-0241 · Dec 16, 2025',
          initiallyExpanded: true,
          accentColor: accentColor2,

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
                    'SAR',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 14,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+24,200.00',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.secondary,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).receiptInformation,

          initiallyExpanded: true,
          accentColor: accentColor4,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyValueRow(GeniusLinkLocalization.of(context).serialNo, 'INV-REC-2024-0241', mono: true),
              KeyValueRow(GeniusLinkLocalization.of(context).receivingStore, 'King Fahd Warehouse'),
              KeyValueRow(GeniusLinkLocalization.of(context).supplier, 'ABC Trading Co.'),
              KeyValueRow(GeniusLinkLocalization.of(context).poReference, 'PO-2024-1182', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).items,
          subtitle: GeniusLinkLocalization.of(context).text2Lines432Units,
          initiallyExpanded: true,
          accentColor: accentColor3,

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
                      ItemLine(item: items[i], last: i == items.length - 1),
                  ],
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: GeniusLinkLocalization.of(context).auditInformation,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            connectIndictors: true,
            items: [
              AuditItem(
                title: GeniusLinkLocalization.of(context).received,
                doAt: DateTime(2025, 12, 16, 14, 32),
                doBy: 'Layla A. (ID: 12)',
                description:
                    'Linked Journal: JV-2024-0241\nAudit Hash: b3e1…a072',
              ),
            ],
          ),
        ),
        MBtn(
          GeniusLinkLocalization.of(context).backToList,
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}
