import 'package:flutter/material.dart';

import 'directional_slot_tile.dart';
import 'pressable_surface.dart';

/// Configures the reusable surface and spacing of [MetricSlotCard].
///
/// Use [copyWith] for local variants instead of duplicating a complete card
/// style. Feature-specific text and status colors can remain on the widgets
/// passed into the card slots.
///
/// Example:
///
/// ```dart
/// const metricTheme = MetricSlotCardThemeData(
///   padding: EdgeInsets.all(14),
///   rowGap: 6,
///   borderRadius: BorderRadius.all(Radius.circular(12)),
/// );
/// ```
@immutable
class MetricSlotCardThemeData {
  const MetricSlotCardThemeData({
    this.padding = const EdgeInsets.all(14),
    this.rowGap = 8,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  final EdgeInsetsGeometry padding;
  final double rowGap;
  final MainAxisAlignment mainAxisAlignment;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final PressableSurfaceThemeData pressableTheme;

  MetricSlotCardThemeData copyWith({
    EdgeInsetsGeometry? padding,
    double? rowGap,
    MainAxisAlignment? mainAxisAlignment,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    PressableSurfaceThemeData? pressableTheme,
  }) {
    return MetricSlotCardThemeData(
      padding: padding ?? this.padding,
      rowGap: rowGap ?? this.rowGap,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      pressableTheme: pressableTheme ?? this.pressableTheme,
    );
  }
}

/// Displays metric-like content in three directional rows of widget
/// slots.
///
/// The component owns layout only. It does not interpret labels, money, trends,
/// status, or business values. Use [startOverlay] for a positional accent or
/// similar decoration without coupling the card to a specific feature.
///
/// Example:
///
/// ```dart
/// MetricSlotCard(
///   topStart: const Text('TOTAL BALANCE'),
///   centerStart: const Text('SAR 2,680,900'),
///   bottomStart: const Text('▲ 2.4%'),
///   startOverlay: Container(width: 3),
///   onTap: () {},
/// )
/// ```
class MetricSlotCard extends StatelessWidget {
  const MetricSlotCard({
    super.key,
    this.topStart,
    this.topEnd,
    this.centerStart,
    this.centerEnd,
    this.bottomStart,
    this.bottomEnd,
    this.startOverlay,
    this.onTap,
    this.semanticLabel,
    this.theme = const MetricSlotCardThemeData(),
  });

  final Widget? topStart;
  final Widget? topEnd;
  final Widget? centerStart;
  final Widget? centerEnd;
  final Widget? bottomStart;
  final Widget? bottomEnd;
  final Widget? startOverlay;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final MetricSlotCardThemeData theme;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor == null
            ? null
            : Border.all(color: theme.borderColor!, width: theme.borderWidth),
        borderRadius: theme.borderRadius,
      ),
      child: Stack(
        children: [
          Padding(
            padding: theme.padding,
            child: Column(
              mainAxisAlignment: theme.mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (topStart != null || topEnd != null)
                  DirectionalSlotRow(start: topStart, end: topEnd),
                if ((topStart != null || topEnd != null) &&
                    (centerStart != null || centerEnd != null))
                  SizedBox(height: theme.rowGap),
                if (centerStart != null || centerEnd != null)
                  DirectionalSlotRow(start: centerStart, end: centerEnd),
                if ((centerStart != null || centerEnd != null) &&
                    (bottomStart != null || bottomEnd != null))
                  SizedBox(height: theme.rowGap),
                if (bottomStart != null || bottomEnd != null)
                  DirectionalSlotRow(start: bottomStart, end: bottomEnd),
              ],
            ),
          ),
          if (startOverlay != null)
            PositionedDirectional(
              start: 0,
              top: 0,
              bottom: 0,
              child: startOverlay!,
            ),
        ],
      ),
    );

    if (onTap == null) {
      return semanticLabel == null
          ? card
          : Semantics(label: semanticLabel, child: card);
    }

    return PressableSurface(
      onTap: onTap,
      semanticLabel: semanticLabel,
      theme: theme.pressableTheme,
      child: card,
    );
  }
}
