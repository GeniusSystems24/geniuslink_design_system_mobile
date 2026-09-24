// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

/// Displays a compact uppercase label for secondary section metadata.
///
/// [Eyebrow] is intended for short labels that visually precede a value,
/// heading, or compact content block. The text is converted to uppercase at
/// render time while the original [text] value remains unchanged.
///
/// Example:
///
/// ```dart
/// const Eyebrow(
///   'Account status',
///   size: 10,
/// )
/// ```
class Eyebrow extends StatelessWidget {
  /// Text displayed by the eyebrow label.
  ///
  /// The rendered value is converted to uppercase with [String.toUpperCase].
  final String text;

  /// Optional foreground color.
  ///
  /// When omitted, the secondary foreground color from
  /// [SuperMaterialThemeData] is used.
  final Color? color;

  /// Optional text size.
  ///
  /// When omitted, the surrounding text style determines the effective size.
  final double? size;

  /// Creates a compact uppercase label.
  const Eyebrow(this.text, {super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    // Resolve the design-system theme once so typography and colors come from
    // one consistent theme snapshot during this build.
    final theme = SuperMaterialThemeData.of(context);

    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontFamily: theme.textTheme.bodyMedium?.fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: size,
        letterSpacing: 0.6,
        color: color ?? theme.superTheme.fg2,
      ),
    );
  }
}
