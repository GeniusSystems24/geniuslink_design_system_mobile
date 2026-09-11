// COMPONENTIZATION_API_COMPAT_V1
// LAYOUT_THEME_EXTENSIONS_V1
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'pressable_surface.dart';

/// Layout, surface, divider, and press customization for [DirectionalSlotTile].
///
/// This theme intentionally contains the union of the options used by the
/// shared design-system component and the feature adapters that compose it.
@immutable
class DirectionalSlotTileThemeData
    extends ThemeExtension<DirectionalSlotTileThemeData> {
  const DirectionalSlotTileThemeData({
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.gap = 12,
    this.minHeight,
    this.backgroundColor,
    this.border,
    this.borderColor,
    this.borderWidth = 1,
    this.dividerColor,
    this.borderRadius = BorderRadius.zero,
    this.alignment = AlignmentDirectional.centerStart,
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  /// Returns the registered [DirectionalSlotTileThemeData], if available.
  static DirectionalSlotTileThemeData? mayOf(BuildContext context) {
    return Theme.of(context).extension<DirectionalSlotTileThemeData>();
  }

  /// Returns the effective directional-slot-tile theme for [context].
  static DirectionalSlotTileThemeData of(BuildContext context) {
    final registered = mayOf(context);
    if (registered != null) {
      return registered;
    }

    final materialTheme = Theme.of(context);
    return materialTheme.brightness == Brightness.dark
        ? dark(colorScheme: materialTheme.colorScheme)
        : light(colorScheme: materialTheme.colorScheme);
  }

  /// Creates the default light directional-slot-tile theme.
  static DirectionalSlotTileThemeData light({
    ColorScheme colorScheme = const ColorScheme.light(),
  }) {
    return DirectionalSlotTileThemeData(
      dividerColor: colorScheme.outlineVariant,
      pressableTheme: PressableSurfaceThemeData.light(),
    );
  }

  /// Creates the default dark directional-slot-tile theme.
  static DirectionalSlotTileThemeData dark({
    ColorScheme colorScheme = const ColorScheme.dark(),
  }) {
    return DirectionalSlotTileThemeData(
      dividerColor: colorScheme.outlineVariant,
      pressableTheme: PressableSurfaceThemeData.dark(),
    );
  }

  final EdgeInsetsGeometry padding;
  final double gap;
  final double? minHeight;
  final Color? backgroundColor;

  /// Explicit border. When supplied, it takes precedence over [borderColor]
  /// and the automatic bottom divider.
  final BoxBorder? border;
  final Color? borderColor;
  final double borderWidth;
  final Color? dividerColor;
  final BorderRadiusGeometry borderRadius;
  final AlignmentGeometry alignment;
  final PressableSurfaceThemeData pressableTheme;

  @override
  DirectionalSlotTileThemeData copyWith({
    EdgeInsetsGeometry? padding,
    double? gap,
    double? minHeight,
    Color? backgroundColor,
    BoxBorder? border,
    Color? borderColor,
    double? borderWidth,
    Color? dividerColor,
    BorderRadiusGeometry? borderRadius,
    AlignmentGeometry? alignment,
    PressableSurfaceThemeData? pressableTheme,
  }) {
    return DirectionalSlotTileThemeData(
      padding: padding ?? this.padding,
      gap: gap ?? this.gap,
      minHeight: minHeight ?? this.minHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      border: border ?? this.border,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      dividerColor: dividerColor ?? this.dividerColor,
      borderRadius: borderRadius ?? this.borderRadius,
      alignment: alignment ?? this.alignment,
      pressableTheme: pressableTheme ?? this.pressableTheme,
    );
  }

  @override
  DirectionalSlotTileThemeData lerp(
    covariant DirectionalSlotTileThemeData? other,
    double t,
  ) {
    if (other == null || identical(this, other)) {
      return this;
    }

    return DirectionalSlotTileThemeData(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      gap: ui.lerpDouble(gap, other.gap, t)!,
      minHeight: ui.lerpDouble(minHeight, other.minHeight, t),
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      ),
      border: BoxBorder.lerp(border, other.border, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: ui.lerpDouble(borderWidth, other.borderWidth, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      )!,
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t)!,
      pressableTheme: pressableTheme.lerp(other.pressableTheme, t),
    );
  }
}

/// Generic one-row layout with directional visual slots.
///
/// [start], [center], and [end] describe layout position rather than business
/// meaning, so feature widgets can translate their own data into Widgets before
/// composing this component.
///
/// Example:
///
/// ```dart
/// DirectionalSlotTile(
///   start: const Icon(Icons.account_balance_outlined),
///   center: const Text('Main account'),
///   end: const Text('SAR 42,500.00'),
///   showBottomDivider: true,
/// )
/// ```
class DirectionalSlotTile extends StatelessWidget {
  const DirectionalSlotTile({
    super.key,
    this.start,
    this.center,
    this.end,
    this.onTap,
    this.semanticLabel,
    this.showBottomDivider = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.theme = const DirectionalSlotTileThemeData(),
  });

  final Widget? start;
  final Widget? center;
  final Widget? end;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool showBottomDivider;
  final CrossAxisAlignment crossAxisAlignment;
  final DirectionalSlotTileThemeData theme;

  BoxBorder? _resolveBorder() {
    if (theme.border != null) return theme.border;

    if (theme.borderColor != null) {
      return Border.all(
        color: theme.borderColor!,
        width: theme.borderWidth,
      );
    }

    if (showBottomDivider && theme.dividerColor != null) {
      return Border(
        bottom: BorderSide(
          color: theme.dividerColor!,
          width: theme.borderWidth,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: theme.minHeight == null
          ? null
          : BoxConstraints(minHeight: theme.minHeight!),
      padding: theme.padding,
      alignment: theme.alignment,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: _resolveBorder(),
        borderRadius: theme.borderRadius,
      ),
      child: DirectionalSlotRow(
        start: start,
        center: center,
        end: end,
        gap: theme.gap,
        crossAxisAlignment: crossAxisAlignment,
      ),
    );

    if (onTap != null) {
      return PressableSurface(
        onTap: onTap,
        semanticLabel: semanticLabel,
        theme: theme.pressableTheme,
        child: content,
      );
    }

    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, child: content);
    }

    return content;
  }
}

/// Generic directional row without surface or interaction behavior.
///
/// Use this when only positional layout is needed, for example inside a metric
/// card that provides its own surface.
///
/// Example:
///
/// ```dart
/// DirectionalSlotRow(
///   start: const Text('Total balance'),
///   end: const Text('SAR 2,680,900'),
/// )
/// ```
class DirectionalSlotRow extends StatelessWidget {
  const DirectionalSlotRow({
    super.key,
    this.start,
    this.center,
    this.end,
    this.gap = 12,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget? start;
  final Widget? center;
  final Widget? end;
  final double gap;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ?start,
        if (start != null && (center != null || end != null))
          SizedBox(width: gap),
        if (center != null)
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: center,
            ),
          )
        else if (start != null && end != null)
          const Spacer(),
        if (center != null && end != null) SizedBox(width: gap),
        if (end != null)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: end,
          ),
      ],
    );
  }
}
