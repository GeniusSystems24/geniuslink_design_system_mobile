import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';

/// Common section configuration used by Accounts presentation sections.
@immutable
class AccountsSectionThemeData {
  const AccountsSectionThemeData({
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.initiallyExpanded = true,
    this.collapsible = true,
    this.dividerAfterHeader = false,
  });

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final bool initiallyExpanded;
  final bool collapsible;
  final bool dividerAfterHeader;
}

/// Accounts feature section that centralizes the existing section-card style.
///
/// [child] remains caller-composed so this component does not depend on any
/// domain model.
///
/// Example:
///
/// ```dart
/// AccountsSection(
///   title: 'Information',
///   accentColor: Colors.blue,
///   child: const Text('Content'),
/// )
/// ```
class AccountsSection extends StatelessWidget {
  const AccountsSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.icon,
    this.accentColor,
    this.theme = const AccountsSectionThemeData(),
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final IconData? icon;
  final Color? accentColor;
  final Widget child;
  final AccountsSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (theme.margin == null) {
      return SuperSectionCard2(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        icon: icon,
        initiallyExpanded: theme.initiallyExpanded,
        accentColor: accentColor,
        collapsible: theme.collapsible,
        dividerAfterHeader: theme.dividerAfterHeader,
        padding: theme.padding,
        child: child,
      );
    }

    return SuperSectionCard2(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      icon: icon,
      initiallyExpanded: theme.initiallyExpanded,
      accentColor: accentColor,
      collapsible: theme.collapsible,
      dividerAfterHeader: theme.dividerAfterHeader,
      margin: theme.margin!,
      padding: theme.padding,
      child: child,
    );
  }
}

/// Section variant for a vertical list of caller-composed field/content widgets.
///
/// This keeps form screens focused on composition without coupling the section
/// to any specific field model or controller.
class AccountsFieldSection extends StatelessWidget {
  const AccountsFieldSection({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.trailing,
    this.icon,
    this.accentColor,
    this.theme = const AccountsSectionThemeData(),
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final IconData? icon;
  final Color? accentColor;
  final List<Widget> children;
  final AccountsSectionThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AccountsSection(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      icon: icon,
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

/// Responsive directional action-row configuration.
@immutable
class AccountsPageActionsThemeData {
  const AccountsPageActionsThemeData({
    this.gap = 10,
    this.stackBreakpoint = 280,
  });

  final double gap;
  final double stackBreakpoint;
}

/// Responsive pair of caller-supplied actions.
///
/// The slots use [start] and [end], so their visual order follows the current
/// [Directionality].
class AccountsPageActions extends StatelessWidget {
  const AccountsPageActions({
    super.key,
    required this.start,
    required this.end,
    this.theme = const AccountsPageActionsThemeData(),
  });

  final Widget start;
  final Widget end;
  final AccountsPageActionsThemeData theme;

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

/// Surface customization for [AccountsNoteSurface].
@immutable
class AccountsNoteSurfaceThemeData {
  const AccountsNoteSurfaceThemeData({
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry borderRadius;
}

/// Themed note/content surface with a direct [child] slot.
class AccountsNoteSurface extends StatelessWidget {
  const AccountsNoteSurface({
    super.key,
    required this.child,
    this.theme = const AccountsNoteSurfaceThemeData(),
  });

  final Widget child;
  final AccountsNoteSurfaceThemeData theme;

  @override
  Widget build(BuildContext context) {
    final superTheme = SuperMaterialThemeData.of(context).superTheme;

    return Container(
      padding: theme.padding,
      decoration: BoxDecoration(
        color: theme.backgroundColor ?? superTheme.inputBg,
        border: Border.all(color: theme.borderColor ?? superTheme.border),
        borderRadius: theme.borderRadius,
      ),
      child: child,
    );
  }
}

enum AccountsChoicePosition { start, end }

/// Surface/text defaults for [AccountsChoicePair].
@immutable
class AccountsChoicePairThemeData {
  const AccountsChoicePairThemeData({
    this.gap = 8,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.selectedBackgroundColor,
    this.selectedBorderColor,
    this.selectedForegroundColor,
    this.unselectedBackgroundColor,
    this.unselectedBorderColor,
    this.unselectedForegroundColor,
    this.textStyle,
  });

  final double gap;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Color? selectedBackgroundColor;
  final Color? selectedBorderColor;
  final Color? selectedForegroundColor;
  final Color? unselectedBackgroundColor;
  final Color? unselectedBorderColor;
  final Color? unselectedForegroundColor;
  final TextStyle? textStyle;
}

/// Two directional visual choices using direct [start] and [end] widget slots.
///
/// The component owns selection presentation only; it does not know what the
/// choices mean to the feature.
class AccountsChoicePair extends StatelessWidget {
  const AccountsChoicePair({
    super.key,
    required this.start,
    required this.end,
    required this.selected,
    this.onStartTap,
    this.onEndTap,
    this.theme = const AccountsChoicePairThemeData(),
  });

  final Widget start;
  final Widget end;
  final AccountsChoicePosition selected;
  final VoidCallback? onStartTap;
  final VoidCallback? onEndTap;
  final AccountsChoicePairThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ChoiceSurface(
            selected: selected == AccountsChoicePosition.start,
            onTap: onStartTap,
            theme: theme,
            child: start,
          ),
        ),
        SizedBox(width: theme.gap),
        Expanded(
          child: _ChoiceSurface(
            selected: selected == AccountsChoicePosition.end,
            onTap: onEndTap,
            theme: theme,
            child: end,
          ),
        ),
      ],
    );
  }
}

class _ChoiceSurface extends StatelessWidget {
  const _ChoiceSurface({
    required this.selected,
    required this.child,
    required this.theme,
    this.onTap,
  });

  final bool selected;
  final Widget child;
  final AccountsChoicePairThemeData theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final materialTheme = SuperMaterialThemeData.of(context);
    final colors = materialTheme.colorScheme;
    final superTheme = materialTheme.superTheme;

    final foreground = selected
        ? theme.selectedForegroundColor ?? colors.secondary
        : theme.unselectedForegroundColor ?? superTheme.fg2;
    final background = selected
        ? theme.selectedBackgroundColor ?? superCoreTint(colors.secondary, 0x14)
        : theme.unselectedBackgroundColor ?? superTheme.inputBg;
    final border = selected
        ? theme.selectedBorderColor ?? colors.secondary
        : theme.unselectedBorderColor ?? superTheme.border;

    final defaultStyle = TextStyle(
      color: foreground,
      fontWeight: FontWeight.w700,
      fontSize: 12,
      letterSpacing: 0.4,
      fontFamily: materialTheme.textTheme.bodyMedium?.fontFamily,
    ).merge(theme.textStyle);

    final content = Container(
      padding: theme.padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: border),
        borderRadius: theme.borderRadius,
      ),
      child: DefaultTextStyle.merge(
        style: defaultStyle,
        child: IconTheme.merge(
          data: IconThemeData(color: foreground),
          child: child,
        ),
      ),
    );

    if (onTap == null) return content;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
        onTap: onTap,
        child: content,
      ),
    );
  }
}
