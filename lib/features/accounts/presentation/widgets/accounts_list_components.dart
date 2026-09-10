import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import 'account_row.dart';
import 'accounts_shared_components.dart';

/// Visual configuration for [AccountsSearchPrompt].
@immutable
class AccountsSearchPromptThemeData {
  const AccountsSearchPromptThemeData({
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.gap = 10,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.startColor,
    this.centerStyle,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final double gap;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry borderRadius;
  final Color? startColor;
  final TextStyle? centerStyle;
}

/// Search-prompt surface using direct positional [start] and [center] slots.
class AccountsSearchPrompt extends StatelessWidget {
  const AccountsSearchPrompt({
    super.key,
    required this.start,
    required this.center,
    this.onTap,
    this.theme = const AccountsSearchPromptThemeData(),
  });

  final Widget start;
  final Widget center;
  final VoidCallback? onTap;
  final AccountsSearchPromptThemeData theme;

  @override
  Widget build(BuildContext context) {
    final materialTheme = SuperMaterialThemeData.of(context);
    final superTheme = materialTheme.superTheme;

    return SizedBox(
      height: theme.height,
      child: DirectionalSlotTile(
        onTap: onTap,
        start: IconTheme.merge(
          data: IconThemeData(color: theme.startColor ?? superTheme.fg3),
          child: start,
        ),
        center: DefaultTextStyle.merge(
          style: TextStyle(
            color: superTheme.fg3,
            fontSize: 14,
            fontFamily: materialTheme.textTheme.bodyMedium?.fontFamily,
          ).merge(theme.centerStyle),
          child: center,
        ),
        theme: DirectionalSlotTileThemeData(
          padding: theme.padding,
          gap: theme.gap,
          backgroundColor: theme.backgroundColor ?? superTheme.inputBg,
          border: Border.all(
            color: theme.borderColor ?? superTheme.borderStrong,
          ),
          borderRadius: theme.borderRadius,
        ),
      ),
    );
  }
}

/// Layout configuration for [AccountsListSection].
@immutable
class AccountsListSectionThemeData {
  const AccountsListSectionThemeData({
    this.section = const AccountsSectionThemeData(
      padding: EdgeInsets.all(8),
    ),
  });

  final AccountsSectionThemeData section;
}

/// Account-list section that accepts already-composed rows.
class AccountsListSection extends StatelessWidget {
  const AccountsListSection({
    super.key,
    required this.children,
    this.theme = const AccountsListSectionThemeData(),
  });

  final List<Widget> children;
  final AccountsListSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AccountsSection(
      title: '',
      theme: theme.section,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

/// Screen-level visual overrides for the account-list screen.
@immutable
class AccountsScreenThemeData {
  const AccountsScreenThemeData({
    this.backgroundColor,
    this.searchPrompt = const AccountsSearchPromptThemeData(),
    this.listSection = const AccountsListSectionThemeData(),
    this.accountRow = const AccountRowThemeData(),
  });

  final Color? backgroundColor;
  final AccountsSearchPromptThemeData searchPrompt;
  final AccountsListSectionThemeData listSection;
  final AccountRowThemeData accountRow;
}
