import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import 'account_detail_full_components.dart';
import 'accounts_shared_components.dart';

/// Positional layout configuration for [AccountDetailBalanceSection].
@immutable
class AccountDetailBalanceSectionThemeData {
  const AccountDetailBalanceSectionThemeData({
    this.section = const AccountsSectionThemeData(),
    this.gap = 8,
    this.stackBreakpoint = 220,
  });

  final AccountsSectionThemeData section;
  final double gap;
  final double stackBreakpoint;
}

/// Current-balance section with direct directional [start] and [end] slots.
class AccountDetailBalanceSection extends StatelessWidget {
  const AccountDetailBalanceSection({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    this.trailing,
    this.accentColor,
    this.theme = const AccountDetailBalanceSectionThemeData(),
  });

  final String title;
  final Widget start;
  final Widget end;
  final Widget? trailing;
  final Color? accentColor;
  final AccountDetailBalanceSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AccountsSection(
      title: title,
      trailing: trailing,
      accentColor: accentColor,
      theme: theme.section,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < theme.stackBreakpoint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                start,
                SizedBox(height: theme.gap),
                end,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              start,
              SizedBox(width: theme.gap),
              Flexible(child: end),
            ],
          );
        },
      ),
    );
  }
}

/// Information section accepting caller-composed rows.
class AccountDetailInformationSection extends StatelessWidget {
  const AccountDetailInformationSection({
    super.key,
    required this.title,
    required this.children,
    this.accentColor,
    this.theme = const AccountsSectionThemeData(),
  });

  final String title;
  final List<Widget> children;
  final Color? accentColor;
  final AccountsSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AccountsSection(
      title: title,
      accentColor: accentColor,
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

/// Screen-level visual overrides for [AccountDetailScreen].
@immutable
class AccountDetailScreenThemeData {
  const AccountDetailScreenThemeData({
    this.backgroundColor,
    this.balanceAccentColor,
    this.informationAccentColor,
    this.transactionsAccentColor,
    this.balanceSection = const AccountDetailBalanceSectionThemeData(),
    this.informationSection = const AccountsSectionThemeData(),
    this.transactionsSection =
        const AccountDetailRecentTransactionsSectionTheme(),
    this.transactionTile = const TwoRowTileThemeData(),
    this.currencyStyle,
    this.balanceStyle,
    this.transactionStartStyle,
    this.positiveTransactionEndStyle,
    this.negativeTransactionEndStyle,
  });

  final Color? backgroundColor;
  final Color? balanceAccentColor;
  final Color? informationAccentColor;
  final Color? transactionsAccentColor;
  final AccountDetailBalanceSectionThemeData balanceSection;
  final AccountsSectionThemeData informationSection;
  final AccountDetailRecentTransactionsSectionTheme transactionsSection;
  final TwoRowTileThemeData transactionTile;
  final TextStyle? currencyStyle;
  final TextStyle? balanceStyle;
  final TextStyle? transactionStartStyle;
  final TextStyle? positiveTransactionEndStyle;
  final TextStyle? negativeTransactionEndStyle;
}
