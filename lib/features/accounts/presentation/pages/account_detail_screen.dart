// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);

    const tx = [
      ('JV-2024-0042', '+5,000.00', true),
      ('TR-9042', '-1,800.00', false),
      ('JV-2024-0071', '+650.00', true),
    ];
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.primary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var trailing = Pill(l10n.active);
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.accountDetail), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: l10n.currentBalance,

          initiallyExpanded: true,
          accentColor: accentColor3,

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
          title: l10n.information,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              KV(l10n.code, '1001', mono: true),
              KV(l10n.accountType, l10n.assetCash),
              KV(l10n.tree, l10n.assetsTreeOne),
              KV(l10n.currency, 'SAR'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.recentTransactions,

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
          l10n.backToList,
          variant: MBtnVariant.secondary,
          icon: 'back',
          full: true,
          onTap: () => context.goTo('accounts'),
        ),
      ]),
    );
  }
}
