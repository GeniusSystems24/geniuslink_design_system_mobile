// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// list · createAccount · accountDetail · createGroup · groupDetail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);

    var accentColor = SuperMaterialThemeData.of(context).colorScheme.secondary;
    var accentColor2 = SuperMaterialThemeData.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).colorScheme.surface,
      appBar: SuperAppBar(title: Text(l10n.createAccount), actions: const [AppLanguageToggleButton(), AppThemeToggleButton()]),
      body: MScroll([
        SuperSectionCard2(
          title: l10n.accountDetails,
          subtitle: l10n.identifyAndPlaceInTree,
          initiallyExpanded: true,
          accentColor: accentColor2,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MField(
                label: l10n.accountCode,
                placeholder: l10n.example1102,
                mono: true,
                required: true,
              ),
              MField(label: l10n.accountType, value: l10n.asset),
              MField(
                label: l10n.nameEnglish,
                placeholder: l10n.exampleEnglishAccountName,
                required: true,
              ),
              MField(
                label: l10n.nameArabic,
                placeholder: l10n.exampleArabicAccountName,
                ar: true,
                required: true,
              ),
              MSuggest(
                label: l10n.parentGroup,
                value: 'Current Assets (1000)',
                placeholder: l10n.searchParentGroup,
                icon: 'briefcase',
                items: mSuggestions(const [
                  'Current Assets (1000)',
                  'Fixed Assets (1500)',
                  'Liabilities (2000)',
                  'Equity (3000)',
                ]),
              ),
            ],
          ),
        ),
        SuperSectionCard2(
          title: l10n.settings,

          initiallyExpanded: true,
          accentColor: accentColor,

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MSuggest(
                label: l10n.currency,
                value: 'SAR — Saudi Riyal',
                placeholder: l10n.searchCurrency,
                icon: 'globe',
                items: mSuggestions(const [
                  'SAR — Saudi Riyal',
                  'USD — US Dollar',
                  'EUR — Euro',
                ]),
              ),
              MField(
                label: l10n.openingBalance,
                placeholder: '0.00',
                mono: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(l10n.normalBalance),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(child: _toggleBox(context, l10n.debit, true)),
                      const SizedBox(width: 8),
                      Expanded(child: _toggleBox(context, l10n.credit, false)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MBtn(l10n.cancel, variant: MBtnVariant.secondary, full: true),
            ),
            SizedBox(width: 10),
            Expanded(child: MBtn(l10n.create, icon: 'check', full: true)),
          ],
        ),
      ]),
    );
  }

  static Widget _toggleBox(BuildContext context, String label, bool on) =>
      Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on
              ? superCoreTint(
                  SuperMaterialThemeData.of(context).colorScheme.secondary,
                  0x14,
                )
              : SuperMaterialThemeData.of(context).superTheme.inputBg,
          border: Border.all(
            color: on
                ? SuperMaterialThemeData.of(context).colorScheme.secondary
                : SuperMaterialThemeData.of(context).superTheme.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: on
                ? SuperMaterialThemeData.of(context).colorScheme.secondary
                : SuperMaterialThemeData.of(context).superTheme.fg2,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.4,
            fontFamily: SuperMaterialThemeData.of(
              context,
            ).textTheme.bodyMedium?.fontFamily,
          ),
        ),
      );
}
