// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const tx = [
      ('JV-2024-0042', '+5,000.00', true),
      ('TR-9042', '-1,800.00', false),
      ('JV-2024-0071', '+650.00', true),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = const Pill('Active');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Account Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Current Balance',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor3,
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
                    '42,500.00',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      color: SuperMaterialThemeData.of(
                        context,
                      ).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Information',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('Code', '1001', mono: true),
              KV('Type', 'Asset · Cash'),
              KV('Tree', 'Assets Tree (1)'),
              KV('Currency', 'SAR'),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Recent Transactions',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
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
                    for (int i = 0; i < tx.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: i == tx.length - 1
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: SuperMaterialThemeData.of(
                                      context,
                                    ).superTheme.border,
                                  ),
                                ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tx[i].$1,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 12.5,
                                color: SuperMaterialThemeData.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                            ),
                            Text(
                              tx[i].$2,
                              style: TextStyle(
                                fontFamily: SuperMaterialThemeData.of(
                                  context,
                                ).textTheme.bodyMedium?.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: tx[i].$3
                                    ? SuperMaterialThemeData.of(
                                        context,
                                      ).colorScheme.secondary
                                    : SuperMaterialThemeData.of(
                                        context,
                                      ).colorScheme.error,
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
        MBtn(
          'Back to List',
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('accounts'),
        ),
      ]),
    );
  }
}
