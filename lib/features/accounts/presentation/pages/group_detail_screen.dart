// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// group detail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import '../widgets/widgets.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({
    super.key,
    this.theme = const GroupDetailScreenThemeData(),
  });

  final GroupDetailScreenThemeData theme;

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final noteTextStyle = TextStyle(
      fontFamily: materialTheme.textTheme.bodyMedium?.fontFamily,
      fontSize: 14,
      color: materialTheme.superTheme.fg2,
    );

    return Scaffold(
      backgroundColor: theme.backgroundColor ?? colors.surface,
      appBar: SuperAppBar(
        title: Text(l10n.groupDetail),
        actions: const [
          AppLanguageToggleButton(),
          AppThemeToggleButton(),
        ],
      ),
      body: MScroll([
        AccountsFieldSection(
          title: l10n.groupInformation,
          trailing: Pill(l10n.active),
          accentColor: theme.informationAccentColor ?? colors.primary,
          theme: theme.section,
          children: [
              KeyValueRow(l10n.id, '1042', mono: true),
              KeyValueRow(l10n.nameEnglish, 'Current Assets'),
              KeyValueRow(l10n.nameArabic, 'الأصول المتداولة', ar: true),
              KeyValueRow(l10n.accountTree, 'Assets Tree (1)'),
            ],
        ),
        AccountsSection(
          title: l10n.notes,
          accentColor: theme.notesAccentColor ?? colors.tertiary,
          theme: theme.section,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AccountsNoteSurface(
              theme: theme.note,
              child: Text(
                'تشمل النقدية والحسابات المدينة والمخزون',
                style: noteTextStyle,
              ),
            ),
          ),
        ),
        AccountsSection(
          title: l10n.audit,
          accentColor: theme.auditAccentColor ?? colors.secondary,
          theme: theme.section,
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
