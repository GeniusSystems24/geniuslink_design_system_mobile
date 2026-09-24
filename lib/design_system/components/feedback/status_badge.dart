import 'package:flutter/material.dart';

/// Configures the surface and optional foreground color inherited by
/// [StatusBadge] content.
///
/// Example:
///
/// ```dart
/// const warningBadgeTheme = StatusBadgeThemeData(
///   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///   borderRadius: BorderRadius.all(Radius.circular(999)),
/// );
/// ```
@immutable
class StatusBadgeThemeData {
  const StatusBadgeThemeData({
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(999)),
    this.minWidth,
    this.minHeight,
  });

  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final double? minWidth;
  final double? minHeight;

  StatusBadgeThemeData copyWith({
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    double? minWidth,
    double? minHeight,
  }) {
    return StatusBadgeThemeData(
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
    );
  }
}

/// Displays arbitrary [child] content inside a compact status surface.
///
/// The caller owns the semantic meaning and prepares the badge content. This
/// component therefore works for counts, statuses, tags, transaction types, and
/// other compact indicators without depending on a feature enum or model.
///
/// Example:
///
/// ```dart
/// const StatusBadge(
///   child: Text('3 OPEN'),
/// )
/// ```
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.child,
    this.theme = const StatusBadgeThemeData(),
  });

  final Widget child;
  final StatusBadgeThemeData theme;

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (theme.foregroundColor != null) {
      content = DefaultTextStyle.merge(
        style: TextStyle(color: theme.foregroundColor),
        child: IconTheme.merge(
          data: IconThemeData(color: theme.foregroundColor),
          child: content,
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: theme.minWidth ?? 0,
        minHeight: theme.minHeight ?? 0,
      ),
      padding: theme.padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor == null
            ? null
            : Border.all(color: theme.borderColor!, width: theme.borderWidth),
        borderRadius: theme.borderRadius,
      ),
      child: content,
    );
  }
}
