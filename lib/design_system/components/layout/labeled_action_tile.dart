// MOBILE_DASHBOARD_LAYOUT_FIX_V1
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
class LabeledActionTileThemeData {
  const LabeledActionTileThemeData({
    this.gap = 7,
    this.padding = EdgeInsets.zero,
    this.minHeight,
    this.alignment = Alignment.center,
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  final double gap;
  final EdgeInsetsGeometry padding;
  final double? minHeight;
  final AlignmentGeometry alignment;
  final PressableSurfaceThemeData pressableTheme;

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
        constraints: BoxConstraints(
          minHeight: theme.minHeight ?? 0,
        ),
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
