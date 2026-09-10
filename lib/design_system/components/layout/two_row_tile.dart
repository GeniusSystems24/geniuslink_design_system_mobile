import 'package:flutter/material.dart';

/// Configures the layout and surface of [TwoRowTile].
///
/// Only layout and surface concerns belong here. Text, badges, amounts, icons,
/// and other feature-specific visuals remain caller-provided widgets.
///
/// Example:
///
/// ```dart
/// const movementTileTheme = TwoRowTileThemeData(
///   padding: EdgeInsets.symmetric(vertical: 14),
///   rowGap: 6,
///   columnGap: 12,
///   borderRadius: BorderRadius.all(Radius.circular(10)),
/// );
/// ```
@immutable
class TwoRowTileThemeData {
  const TwoRowTileThemeData({
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.rowGap = 4,
    this.columnGap = 12,
    this.minHeight,
    this.backgroundColor,
    this.borderColor,
    this.dividerColor,
    this.borderRadius = BorderRadius.zero,
  });

  final EdgeInsetsGeometry padding;
  final double rowGap;
  final double columnGap;
  final double? minHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? dividerColor;
  final BorderRadiusGeometry borderRadius;

  TwoRowTileThemeData copyWith({
    EdgeInsetsGeometry? padding,
    double? rowGap,
    double? columnGap,
    double? minHeight,
    Color? backgroundColor,
    Color? borderColor,
    Color? dividerColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return TwoRowTileThemeData(
      padding: padding ?? this.padding,
      rowGap: rowGap ?? this.rowGap,
      columnGap: columnGap ?? this.columnGap,
      minHeight: minHeight ?? this.minHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

/// Displays two rows using positional [topStart], [topEnd],
/// [bottomStart], and [bottomEnd] widget slots.
///
/// This is a layout-driven component: it deliberately does not depend on a
/// transaction, account, banking, or other feature model. The feature prepares
/// its content and passes widgets directly into the appropriate positions.
///
/// Example:
///
/// ```dart
/// TwoRowTile(
///   topStart: const Text('Cash deposit — Main'),
///   topEnd: const Text('+SAR 120,000.00'),
///   bottomStart: const Text('DEP-7741'),
///   bottomEnd: const Text('1h ago'),
///   onTap: () {},
/// )
/// ```
class TwoRowTile extends StatelessWidget {
  const TwoRowTile({
    super.key,
    this.topStart,
    this.topEnd,
    this.bottomStart,
    this.bottomEnd,
    this.onTap,
    this.semanticLabel,
    this.showBottomDivider = false,
    this.theme = const TwoRowTileThemeData(),
  });

  final Widget? topStart;
  final Widget? topEnd;
  final Widget? bottomStart;
  final Widget? bottomEnd;

  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool showBottomDivider;
  final TwoRowTileThemeData theme;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: theme.minHeight == null
          ? null
          : BoxConstraints(minHeight: theme.minHeight!),
      padding: theme.padding,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor != null
            ? Border.all(color: theme.borderColor!)
            : showBottomDivider && theme.dividerColor != null
                ? Border(bottom: BorderSide(color: theme.dividerColor!))
                : null,
        borderRadius: theme.borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topStart != null || topEnd != null)
            _DirectionalSlotRow(
              start: topStart,
              end: topEnd,
              gap: theme.columnGap,
            ),
          if ((topStart != null || topEnd != null) &&
              (bottomStart != null || bottomEnd != null))
            SizedBox(height: theme.rowGap),
          if (bottomStart != null || bottomEnd != null)
            _DirectionalSlotRow(
              start: bottomStart,
              end: bottomEnd,
              gap: theme.columnGap,
            ),
        ],
      ),
    );

    if (onTap == null) {
      return semanticLabel == null
          ? content
          : Semantics(label: semanticLabel, child: content);
    }

    final interactive = Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
        onTap: onTap,
        child: content,
      ),
    );

    return semanticLabel == null
        ? interactive
        : Semantics(
            button: true,
            label: semanticLabel,
            child: interactive,
          );
  }
}

class _DirectionalSlotRow extends StatelessWidget {
  const _DirectionalSlotRow({
    required this.start,
    required this.end,
    required this.gap,
  });

  final Widget? start;
  final Widget? end;
  final double gap;

  @override
  Widget build(BuildContext context) {
    if (start == null) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: end,
      );
    }

    if (end == null) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: start,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: start,
          ),
        ),
        SizedBox(width: gap),
        Flexible(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: end,
          ),
        ),
      ],
    );
  }
}
