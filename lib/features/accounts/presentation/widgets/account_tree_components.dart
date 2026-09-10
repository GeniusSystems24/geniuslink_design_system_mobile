import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import 'accounts_shared_components.dart';

/// Layout configuration for [AccountTreeSection].
@immutable
class AccountTreeSectionThemeData {
  const AccountTreeSectionThemeData({
    this.outerPadding = const EdgeInsets.all(16),
    this.section = const AccountsSectionThemeData(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      collapsible: false,
      dividerAfterHeader: true,
    ),
    this.headerGap = 8,
    this.contentHeightOffset = 104,
    this.unboundedFallbackHeight = 520,
  });

  final EdgeInsetsGeometry outerPadding;
  final AccountsSectionThemeData section;
  final double headerGap;
  final double contentHeightOffset;
  final double unboundedFallbackHeight;
}

/// Bounded account-tree section with direct header/content widget slots.
///
/// The section is model-independent: [content] can be any scrollable/tree
/// widget supplied by the caller.
class AccountTreeSection extends StatelessWidget {
  const AccountTreeSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.headerStart,
    required this.headerEnd,
    required this.content,
    this.icon,
    this.accentColor,
    this.theme = const AccountTreeSectionThemeData(),
  });

  final String title;
  final String subtitle;
  final Widget headerStart;
  final Widget headerEnd;
  final Widget content;
  final IconData? icon;
  final Color? accentColor;
  final AccountTreeSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: theme.outerPadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.hasBoundedHeight
              ? constraints.maxHeight
              : theme.unboundedFallbackHeight;
          final contentHeight = availableHeight > theme.contentHeightOffset
              ? availableHeight - theme.contentHeightOffset
              : availableHeight;

          return AccountsSection(
            title: title,
            subtitle: subtitle,
            icon: icon,
            accentColor: accentColor,
            theme: theme.section,
            child: SizedBox(
              height: contentHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DirectionalSlotTile(
                    start: headerStart,
                    end: headerEnd,
                    theme: const DirectionalSlotTileThemeData(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: theme.headerGap),
                  Expanded(child: content),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Screen-level visual overrides for the account-tree screen.
@immutable
class AccountTreeScreenThemeData {
  const AccountTreeScreenThemeData({
    this.backgroundColor,
    this.accentColor,
    this.section = const AccountTreeSectionThemeData(),
    this.typeDotSize = 7,
    this.headerStartStyle,
    this.headerEndStyle,
    this.amountStyle,
    this.rootAmountStyle,
  });

  final Color? backgroundColor;
  final Color? accentColor;
  final AccountTreeSectionThemeData section;
  final double typeDotSize;
  final TextStyle? headerStartStyle;
  final TextStyle? headerEndStyle;
  final TextStyle? amountStyle;
  final TextStyle? rootAmountStyle;
}
