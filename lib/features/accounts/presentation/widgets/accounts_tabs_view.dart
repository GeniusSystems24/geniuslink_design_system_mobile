import 'package:flutter/material.dart';
import 'package:super_tab_bar/super_tab_bar.dart';

import 'account_detail_full_components.dart';
import 'account_tree_components.dart';

/// Visual configuration for [AccountsTabsView].
@immutable
class AccountsTabsViewThemeData {
  const AccountsTabsViewThemeData({
    this.fillContent = true,
    this.scrollContent = false,
    this.contentPadding = EdgeInsets.zero,
    this.allowAutoCompact = true,
  });

  final bool fillContent;
  final bool scrollContent;
  final EdgeInsets contentPadding;
  final bool allowAutoCompact;
}

/// Theme bundle for the extra Accounts tabs and their pages.
@immutable
class AccountsExtraTabsThemeData {
  const AccountsExtraTabsThemeData({
    this.tabs = const AccountsTabsViewThemeData(),
    this.tree = const AccountTreeScreenThemeData(),
    this.detail = const AccountDetailFullScreenTheme(),
  });

  final AccountsTabsViewThemeData tabs;
  final AccountTreeScreenThemeData tree;
  final AccountDetailFullScreenTheme detail;
}

/// Thin presentation wrapper around [SuperTabBar].
class AccountsTabsView extends StatelessWidget {
  const AccountsTabsView({
    super.key,
    required this.controller,
    this.theme = const AccountsTabsViewThemeData(),
  });

  final SuperTabBarController controller;
  final AccountsTabsViewThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SuperTabBar(
      controller: controller,
      fillContent: theme.fillContent,
      scrollContent: theme.scrollContent,
      contentPadding: theme.contentPadding,
      allowAutoCompact: theme.allowAutoCompact,
    );
  }
}
