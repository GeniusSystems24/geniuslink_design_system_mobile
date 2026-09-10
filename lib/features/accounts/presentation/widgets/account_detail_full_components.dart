import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';

/// Layout customization for the current-balance section.
@immutable
class AccountDetailCurrentBalanceSectionTheme {
  const AccountDetailCurrentBalanceSectionTheme({
    this.padding = const EdgeInsets.all(16),
    this.topGap = 8,
    this.bottomGap = 12,
    this.stackBreakpoint = 280,
    this.topCrossAxisAlignment = CrossAxisAlignment.baseline,
    this.textBaseline = TextBaseline.alphabetic,
  });

  final EdgeInsets padding;
  final double topGap;
  final double bottomGap;
  final double stackBreakpoint;
  final CrossAxisAlignment topCrossAxisAlignment;
  final TextBaseline? textBaseline;
}

/// Layout customization for the recent-transactions section.
@immutable
class AccountDetailRecentTransactionsSectionTheme {
  const AccountDetailRecentTransactionsSectionTheme({
    this.padding = const EdgeInsets.all(8),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.dividerColor,
  });

  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final Color? dividerColor;
}

/// Layout customization for the screen's directional bottom actions.
@immutable
class AccountDetailActionsTheme {
  const AccountDetailActionsTheme({
    this.gap = 10,
    this.stackBreakpoint = 280,
  });

  final double gap;
  final double stackBreakpoint;
}

/// Content text-style overrides for the current-balance visual slots.
@immutable
class AccountDetailCurrentBalanceContentTheme {
  const AccountDetailCurrentBalanceContentTheme({
    this.topStartStyle,
    this.topEndStyle,
  });

  final TextStyle? topStartStyle;
  final TextStyle? topEndStyle;
}

/// Text-style overrides for the four transaction tile positions.
@immutable
class AccountDetailTransactionContentTheme {
  const AccountDetailTransactionContentTheme({
    this.topStartStyle,
    this.topEndPositiveStyle,
    this.topEndNegativeStyle,
    this.bottomStartStyle,
    this.bottomEndStyle,
  });

  final TextStyle? topStartStyle;
  final TextStyle? topEndPositiveStyle;
  final TextStyle? topEndNegativeStyle;
  final TextStyle? bottomStartStyle;
  final TextStyle? bottomEndStyle;
}

/// Feature-level theme for [AccountDetailFullScreen].
///
/// Shared design-system widgets continue to resolve from the app theme, while
/// these fields provide optional per-screen/per-component overrides.
@immutable
class AccountDetailFullScreenTheme {
  const AccountDetailFullScreenTheme({
    this.backgroundColor,
    this.currentBalanceAccentColor,
    this.informationAccentColor,
    this.recentTransactionsAccentColor,
    this.auditAccentColor,
    this.currentBalanceSection =
        const AccountDetailCurrentBalanceSectionTheme(),
    this.recentTransactionsSection =
        const AccountDetailRecentTransactionsSectionTheme(),
    this.actions = const AccountDetailActionsTheme(),
    this.currentBalanceContent =
        const AccountDetailCurrentBalanceContentTheme(),
    this.transactionContent = const AccountDetailTransactionContentTheme(),
    this.transactionTile = const TwoRowTileThemeData(),
  });

  final Color? backgroundColor;
  final Color? currentBalanceAccentColor;
  final Color? informationAccentColor;
  final Color? recentTransactionsAccentColor;
  final Color? auditAccentColor;

  final AccountDetailCurrentBalanceSectionTheme currentBalanceSection;
  final AccountDetailRecentTransactionsSectionTheme recentTransactionsSection;
  final AccountDetailActionsTheme actions;
  final AccountDetailCurrentBalanceContentTheme currentBalanceContent;
  final AccountDetailTransactionContentTheme transactionContent;
  final TwoRowTileThemeData transactionTile;
}

/// Current-balance feature section.
///
/// The visual regions are direct widget slots. No account/domain model is
/// required by this component.
class AccountDetailCurrentBalanceSection extends StatelessWidget {
  const AccountDetailCurrentBalanceSection({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.accentColor,
    required this.topStart,
    required this.topEnd,
    required this.bottomStart,
    required this.bottomEnd,
    this.theme = const AccountDetailCurrentBalanceSectionTheme(),
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color accentColor;

  final Widget topStart;
  final Widget topEnd;
  final Widget bottomStart;
  final Widget bottomEnd;

  final AccountDetailCurrentBalanceSectionTheme theme;

  @override
  Widget build(BuildContext context) {
    return SuperSectionCard2(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      initiallyExpanded: true,
      accentColor: accentColor,
      padding: theme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: theme.topCrossAxisAlignment,
            textBaseline: theme.topCrossAxisAlignment == CrossAxisAlignment.baseline
                ? theme.textBaseline
                : null,
            children: [
              topStart,
              SizedBox(width: theme.topGap),
              Flexible(child: topEnd),
            ],
          ),
          SizedBox(height: theme.bottomGap),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < theme.stackBreakpoint) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    bottomStart,
                    SizedBox(height: theme.bottomGap),
                    bottomEnd,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: bottomStart),
                  SizedBox(width: theme.bottomGap),
                  Expanded(child: bottomEnd),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Recent-transactions section that accepts already-composed child widgets.
///
/// Transaction/domain semantics remain in the feature composition. This
/// component only owns the section surface, content padding, and separators.
class AccountDetailRecentTransactionsSection extends StatelessWidget {
  const AccountDetailRecentTransactionsSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.accentColor,
    required this.children,
    this.theme = const AccountDetailRecentTransactionsSectionTheme(),
  });

  final String title;
  final String? subtitle;
  final Color accentColor;
  final List<Widget> children;
  final AccountDetailRecentTransactionsSectionTheme theme;

  @override
  Widget build(BuildContext context) {
    final dividerColor = theme.dividerColor ??
        SuperMaterialThemeData.of(context).superTheme.border;

    return SuperSectionCard2(
      title: title,
      subtitle: subtitle,
      initiallyExpanded: true,
      accentColor: accentColor,
      padding: theme.padding,
      child: Padding(
        padding: theme.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < children.length; index++) ...[
              children[index],
              if (index != children.length - 1)
                Divider(height: 1, color: dividerColor),
            ],
          ],
        ),
      ),
    );
  }
}

/// Responsive bottom action layout using directional positional slots.
class AccountDetailActions extends StatelessWidget {
  const AccountDetailActions({
    super.key,
    required this.start,
    required this.end,
    this.theme = const AccountDetailActionsTheme(),
  });

  final Widget start;
  final Widget end;
  final AccountDetailActionsTheme theme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < theme.stackBreakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              start,
              SizedBox(height: theme.gap),
              end,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: start),
            SizedBox(width: theme.gap),
            Expanded(child: end),
          ],
        );
      },
    );
  }
}
