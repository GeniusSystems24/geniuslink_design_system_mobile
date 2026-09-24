// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// create account
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import '../widgets/widgets.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({
    super.key,
    this.theme = const CreateAccountScreenThemeData(),
  });

  final CreateAccountScreenThemeData theme;

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final colors = SuperMaterialThemeData.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor ?? colors.surface,
      appBar: SuperAppBar(
        title: Text(l10n.createAccount),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        AccountsFieldSection(
          title: l10n.accountDetails,
          subtitle: l10n.identifyAndPlaceInTree,
          accentColor: theme.detailsAccentColor ?? colors.primary,
          theme: theme.section,
          children: [
            SuperGrid(
              scope: SuperGridScope.current,
              children: [
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MField(
                    label: l10n.accountCode,
                    placeholder: l10n.example1102,
                    mono: true,
                    required: true,
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MField(label: l10n.accountType, value: l10n.asset),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MField(
                    label: l10n.nameEnglish,
                    placeholder: l10n.exampleEnglishAccountName,
                    required: true,
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MField(
                    label: l10n.nameArabic,
                    placeholder: l10n.exampleArabicAccountName,
                    ar: true,
                    required: true,
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MSuggest(
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
                ),
              ],
            ),
          ],
        ),
        AccountsFieldSection(
          title: l10n.settings,
          accentColor: theme.settingsAccentColor ?? colors.secondary,
          theme: theme.section,
          children: [
            SuperGrid(
              scope: SuperGridScope.current,
              children: [
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MSuggest(
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
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 3,
                  large: 3,
                  child: MField(
                    label: l10n.openingBalance,
                    placeholder: '0.00',
                    mono: true,
                  ),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 8,
                  desktop: 12,
                  large: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Eyebrow(l10n.normalBalance),
                      const SizedBox(height: 7),
                      AccountsChoicePair(
                        selected: AccountsChoicePosition.start,
                        theme: theme.normalBalanceChoice,
                        start: Text(l10n.debit.toUpperCase()),
                        end: Text(l10n.credit.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        AccountsPageActions(
          theme: theme.actions,
          start: MBtn(l10n.cancel, variant: MBtnVariant.secondary, full: true),
          end: MBtn(l10n.create, icon: 'check', full: true),
        ),
      ]),
    );
  }
}
