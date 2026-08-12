import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import 'inventory_shared_widgets.dart';

import 'package:gl_mobile_app/features/accounts/presentation/widgets/audit_column.dart';
class ReceiveDetailScreen extends StatelessWidget {
  const ReceiveDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      ('Portland Cement Type I', '400 BAG × 24.50', '9,800.00'),
      ('Structural Steel I-Beam', '32 PCS × 450.00', '14,400.00'),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = const Pill('Posted');
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor4 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Receive Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Received Value',
          subtitle: 'INV-REC-2024-0241 · Dec 16, 2025',
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: null,
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
          trailing: (null),
          title: 'Receipt Information',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor4,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('Serial No', 'INV-REC-2024-0241', mono: true),
              KV('Receiving Store', 'King Fahd Warehouse'),
              KV('Supplier', 'ABC Trading Co.'),
              KV('PO Reference', 'PO-2024-1182', mono: true),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Items',
          subtitle: '2 lines · 432 units',
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: null,
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
          trailing: (null),
          title: 'Audit Information',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: AuditColumn(
            connectIndictors: true,
            items: [
              AuditItem(
                title: 'Received',
                doAt: DateTime(2025, 12, 16, 14, 32),
                doBy: 'Layla A. (ID: 12)',
                description: 'Linked Journal: JV-2024-0241\nAudit Hash: b3e1…a072',
              ),
            ],
          ),
        ),
        MBtn(
          'Back to List',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}

