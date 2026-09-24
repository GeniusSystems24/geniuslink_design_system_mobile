// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';
import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';

import 'eyebrow.dart';

/// Displays a compact metric or summary card.
///
/// The card presents a small [label], a prominent [value], and an optional
/// [sub] line. Set [hi] to emphasize the card with the active secondary color.
///
/// Example:
///
/// ```dart
/// const Mini(
///   label: 'Balance',
///   value: 'SAR 24,500',
///   sub: 'Updated today',
///   hi: true,
/// )
/// ```
class Mini extends StatelessWidget {
  /// Short label describing the metric.
  final String label;

  /// Primary value displayed prominently in the card.
  final String value;

  /// Optional supporting text displayed below [value].
  final String? sub;

  /// Whether the card should use the highlighted visual treatment.
  final bool hi;

  /// Creates a compact metric card.
  const Mini({
    super.key,
    required this.label,
    required this.value,
    this.sub,
    this.hi = false,
  });

  @override
  Widget build(BuildContext context) {
    // Resolve the design-system theme once so every token in this card uses the
    // same inherited theme snapshot.
    final theme = SuperMaterialThemeData.of(context);
    final accent = theme.colorScheme.secondary;

    // Highlighted cards use a translucent accent surface; normal cards use the
    // standard design-system background and border tokens.
    final backgroundColor = hi
        ? superCoreTint(accent, 0x14)
        : theme.superTheme.bg;
    final borderColor = hi
        ? superCoreTint(accent, 0x4D)
        : theme.superTheme.border;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, color: theme.superTheme.fg3, size: 9.5),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: hi ? accent : theme.superTheme.fg1,
              ),
            ),
          ),
          // Omit supporting text entirely when no secondary value is supplied
          // so the compact card remains content-driven.
          if (sub != null)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                sub!,
                style: TextStyle(
                  fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                  fontSize: 10,
                  color: theme.superTheme.fg3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
