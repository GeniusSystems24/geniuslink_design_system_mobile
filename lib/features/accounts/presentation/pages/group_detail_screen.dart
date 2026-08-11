// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = const Pill('Active');
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: const Text('Group Detail')),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: 'Group Information',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor3,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('ID', '1042', mono: true),
              KV('Name English', 'Current Assets'),
              KV('Name Arabic', 'الأصول المتداولة', ar: true),
              KV('Account Tree', 'Assets Tree (1)'),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Notes',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor2,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: SuperMaterialThemeData.of(
                      context,
                    ).superTheme.inputBg,
                    border: Border.all(
                      color: SuperMaterialThemeData.of(
                        context,
                      ).superTheme.border,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'تشمل النقدية والحسابات المدينة والمخزون',
                    style: TextStyle(
                      fontFamily: SuperMaterialThemeData.of(
                        context,
                      ).textTheme.bodyMedium?.fontFamily,
                      fontSize: 14,
                      color: SuperMaterialThemeData.of(context).superTheme.fg2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          trailing: (null),
          title: 'Audit',
          subtitle: (null),
          initiallyExpanded: true,
          accentColor: accentColor,
          icon: null,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              KV('Created By', 'Admin User (ID: 5)'),
              KV('Created At', 'Dec 04, 2025 11:58 PM'),
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
