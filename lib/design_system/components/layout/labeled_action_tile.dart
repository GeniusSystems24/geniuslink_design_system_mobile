// MOBILE_DASHBOARD_LAYOUT_FIX_V1
// LAYOUT_THEME_EXTENSIONS_V1
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'pressable_surface.dart';

/// Configures spacing, sizing, alignment, and press feedback for
/// [LabeledActionTile].
///
/// Example:
///
/// ```dart
/// const actionTheme = LabeledActionTileThemeData(
///   gap: 8,
///   minHeight: 72,
/// );
/// ```
@immutable
class LabeledActionTileThemeData
    extends ThemeExtension<LabeledActionTileThemeData> {
  const LabeledActionTileThemeData({
    this.gap = 7,
    this.padding = EdgeInsets.zero,
    this.minHeight,
    this.alignment = Alignment.center,
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  /// Returns the registered [LabeledActionTileThemeData], if available.
  static LabeledActionTileThemeData? mayOf(BuildContext context) {
    return Theme.of(context).extension<LabeledActionTileThemeData>();
  }

  /// Returns the effective labeled-action-tile theme for [context].
  static LabeledActionTileThemeData of(BuildContext context) {
    final registered = mayOf(context);
    if (registered != null) {
      return registered;
    }

    return Theme.of(context).brightness == Brightness.dark ? dark() : light();
  }

  /// Creates the default light labeled-action-tile theme.
  static LabeledActionTileThemeData light() {
    return LabeledActionTileThemeData(
      pressableTheme: PressableSurfaceThemeData.light(),
    );
  }

  /// Creates the default dark labeled-action-tile theme.
  static LabeledActionTileThemeData dark() {
    return LabeledActionTileThemeData(
      pressableTheme: PressableSurfaceThemeData.dark(),
    );
  }

  final double gap;
  final EdgeInsetsGeometry padding;
  final double? minHeight;
  final AlignmentGeometry alignment;
  final PressableSurfaceThemeData pressableTheme;

  @override
  LabeledActionTileThemeData copyWith({
    double? gap,
    EdgeInsetsGeometry? padding,
    double? minHeight,
    AlignmentGeometry? alignment,
    PressableSurfaceThemeData? pressableTheme,
  }) {
    return LabeledActionTileThemeData(
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      alignment: alignment ?? this.alignment,
      pressableTheme: pressableTheme ?? this.pressableTheme,
    );
  }

  @override
  LabeledActionTileThemeData lerp(
    covariant LabeledActionTileThemeData? other,
    double t,
  ) {
    if (other == null || identical(this, other)) {
      return this;
    }

    return LabeledActionTileThemeData(
      gap: ui.lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      minHeight: ui.lerpDouble(minHeight, other.minHeight, t),
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t)!,
      pressableTheme: pressableTheme.lerp(other.pressableTheme, t),
    );
  }
}

/// Displays a reusable vertical action composed from [top] and
/// [bottom] widget slots.
///
/// Use the top slot for an icon/surface and the bottom slot for a label or other
/// content. The component does not depend on a quick-action model.
///
/// Example:
///
/// ```dart
/// LabeledActionTile(
///   top: const IconSurface(child: Icon(Icons.add)),
///   bottom: const Text('Deposit'),
///   semanticLabel: 'Deposit',
///   onTap: () {},
/// )
/// ```
class LabeledActionTile extends StatelessWidget {
  const LabeledActionTile({
    super.key,
    required this.top,
    required this.bottom,
    required this.onTap,
    this.semanticLabel,
    this.theme = const LabeledActionTileThemeData(),
  });

  final Widget top;
  final Widget bottom;
  final VoidCallback onTap;
  final String? semanticLabel;
  final LabeledActionTileThemeData theme;

  @override
  Widget build(BuildContext context) {
    return PressableSurface(
      onTap: onTap,
      semanticLabel: semanticLabel,
      theme: theme.pressableTheme,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: theme.minHeight ?? 0),
        child: Align(
          alignment: theme.alignment,
          // A non-null heightFactor is important here. It prevents this
          // reusable tile from expanding to the maximum loose height offered
          // by parents such as Scaffold.bottomNavigationBar.
          heightFactor: 1,
          child: Padding(
            padding: theme.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                top,
                SizedBox(height: theme.gap),
                bottom,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
