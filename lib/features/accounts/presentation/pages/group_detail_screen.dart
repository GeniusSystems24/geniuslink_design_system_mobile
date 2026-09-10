// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import 'package:gl_mobile_app/features/accounts/presentation/widgets/audit_column.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);

    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.tertiary;
    var trailing = Pill(l10n.active);
    var accentColor3 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.groupDetail), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          trailing: trailing,
          title: l10n.groupInformation,

          initiallyExpanded: true,
          accentColor: accentColor3,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              KV(l10n.id, '1042', mono: true),
              KV(l10n.nameEnglish, 'Current Assets'),
              KV(l10n.nameArabic, 'الأصول المتداولة', ar: true),
              KV(l10n.accountTree, 'Assets Tree (1)'),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.notes,

          initiallyExpanded: true,
          accentColor: accentColor2,

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
          title: l10n.audit,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: AuditColumn(
            connectIndictors: true,
            items: [
              AuditItem(
                title: l10n.created,
                doAt: DateTime(2025, 12, 4, 23, 58),
                doBy: 'Admin User (ID: 5)',
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
