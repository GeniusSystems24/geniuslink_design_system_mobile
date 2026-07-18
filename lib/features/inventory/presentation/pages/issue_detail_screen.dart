import 'package:flutter/material.dart';
import '../../../../app/router/navigation_extensions.dart';
import '../../../../design_system/kit.dart';
import 'inventory_shared_widgets.dart';

class IssueDetailScreen extends StatelessWidget {
  const IssueDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: const SuperAppBar(title: 'Issue Detail'),
      body: MScroll([
      MCard(
          accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
          title: 'Issued Value',
          subtitle: 'INV-ISS-2024-0089 · Dec 18, 2025',
          trailing: Pill('Posted'),
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('USD',
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  SizedBox(width: 8),
                  Text('5,400.00',
                      style: TextStyle(
                          fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: SuperMaterialThemeData.of(context).superTheme.fg1,
                          letterSpacing: -0.6)),
                ]),
          ]),
      MCard(accentColor: SuperMaterialThemeData.of(context).colorScheme.primary, title: 'Issue Information', children: [
        KV('Serial No', 'INV-ISS-2024-0089', mono: true),
        KV('Store', 'Downtown Central'),
        KV('Customer', 'Project A-92'),
        KV('Currency', 'USD — US Dollar'),
      ]),
      MCard(
          accentColor: SuperMaterialThemeData.of(context).colorScheme.secondary,
          title: 'Accounting Distribution',
          pad: 16,
          children: [
            DistRow(
                account: '1200 — Inventory (WIP)',
                side: 'Debit',
                amount: '+5,400.00',
                last: false),
            DistRow(
                account: '5001 — Cost of Goods Sold',
                side: 'Credit',
                amount: '-5,400.00',
                last: true),
          ]),

      MBtn('Back to Operations',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('more')),
    ]),
    );
  }
}
