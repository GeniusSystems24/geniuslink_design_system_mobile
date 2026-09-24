// ============================================================
// VIEW — Accounts feature (ports MobileAccounts)
// account detail
// ============================================================

import 'package:flutter/material.dart';
import 'package:gl_mobile_app/app/router/navigation_extensions.dart';
import 'package:gl_mobile_app/app/widgets/app_preference_actions.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/localization/generated/l10n.dart';

import '../widgets/widgets.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({
    super.key,
    this.theme = const AccountDetailScreenThemeData(),
  });

  final AccountDetailScreenThemeData theme;

  @override
  Widget build(BuildContext context) {
    final l10n = GeniusLinkLocalization.of(context);
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final superTheme = materialTheme.superTheme;
    final fontFamily = materialTheme.textTheme.bodyMedium?.fontFamily;

    const transactions = [
      ('JV-2024-0042', '+5,000.00', true),
      ('TR-9042', '-1,800.00', false),
      ('JV-2024-0071', '+650.00', true),
    ];

    final currencyStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: superTheme.fg3,
    ).merge(theme.currencyStyle);
    final balanceStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.6,
      color: colors.secondary,
    ).merge(theme.balanceStyle);
    final transactionStartStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 12.5,
      color: colors.primary,
    ).merge(theme.transactionStartStyle);
    final positiveTransactionEndStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: colors.secondary,
    ).merge(theme.positiveTransactionEndStyle);
    final negativeTransactionEndStyle = TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: colors.error,
    ).merge(theme.negativeTransactionEndStyle);

    return Scaffold(
      backgroundColor: theme.backgroundColor ?? colors.surface,
      appBar: SuperAppBar(
        title: Text(l10n.accountDetail),
        actions: const [AppLanguageToggleButton(), AppThemeToggleButton()],
      ),
      body: MScroll([
        AccountDetailBalanceSection(
          title: l10n.currentBalance,
          trailing: Pill(l10n.active),
          accentColor: theme.balanceAccentColor ?? colors.secondary,
          theme: theme.balanceSection,
          start: Text('SAR', style: currencyStyle),
          end: Text('42,500.00', style: balanceStyle),
        ),
        AccountDetailInformationSection(
          title: l10n.information,
          accentColor: theme.informationAccentColor ?? colors.primary,
          theme: theme.informationSection,
          children: [
            SuperGrid(
              scope: SuperGridScope.current,
              children: [
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 6,
                  large: 6,
                  child: KeyValueRow(l10n.code, '1001', mono: true),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 6,
                  large: 6,
                  child: KeyValueRow(l10n.accountType, l10n.assetCash),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 6,
                  large: 6,
                  child: KeyValueRow(l10n.tree, l10n.assetsTreeOne),
                ),
                SuperGridCell(
                  mobile: 4,
                  tablet: 4,
                  desktop: 6,
                  large: 6,
                  child: KeyValueRow(l10n.currency, 'SAR'),
                ),
              ],
            ),
          ],
        ),
        AccountDetailRecentTransactionsSection(
          title: l10n.recentTransactions,
          accentColor: theme.transactionsAccentColor ?? colors.secondary,
          theme: theme.transactionsSection,
          children: [
            for (final transaction in transactions)
              TwoRowTile(
                theme: theme.transactionTile,
                title: Text(transaction.$1, style: transactionStartStyle),
                trailing: Text(
                  transaction.$2,
                  style: transaction.$3
                      ? positiveTransactionEndStyle
                      : negativeTransactionEndStyle,
                ),
              ),
          ],
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
