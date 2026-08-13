import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import 'inventory_shared_widgets.dart';

class IssueDetailScreen extends StatelessWidget {
  const IssueDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var trailing = const Pill('Posted');
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Issue Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Issued Value',
          subtitle: 'INV-ISS-2024-0089 · Dec 18, 2025',
          initiallyExpanded: true,
          accentColor: accentColor,
          
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
                    'USD',
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
                    '5,400.00',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: SuperMaterialThemeData.of(context).superTheme.fg1,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Issue Information',
          
          initiallyExpanded: true,
          accentColor: accentColor2,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('Serial No', 'INV-ISS-2024-0089', mono: true),
              KV('Store', 'Downtown Central'),
              KV('Customer', 'Project A-92'),
              KV('Currency', 'USD — US Dollar'),
            ],
          ),
        ),
        SuperSectionCard2(
          
          title: 'Accounting Distribution',
          
          initiallyExpanded: true,
          accentColor: accentColor3,
          
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              DistRow(
                account: '1200 — Inventory (WIP)',
                side: 'Debit',
                amount: '+5,400.00',
                last: false,
              ),
              DistRow(
                account: '5001 — Cost of Goods Sold',
                side: 'Credit',
                amount: '-5,400.00',
                last: true,
              ),
            ],
          ),
        ),

        MBtn(
          'Back to Operations',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more'),
        ),
      ]),
    );
  }
}
