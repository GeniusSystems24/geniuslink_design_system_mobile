// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
// KEY_VALUE_ROW_RENAME_V1
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

import 'eyebrow.dart';

/// Displays a compact key/value row.
///
/// The key is rendered as an [Eyebrow], while the value expands into the
/// remaining horizontal space and aligns toward the logical end of the row.
///
/// Example:
///
/// ```dart
/// const KeyValueRow(
///   'Reference',
///   'INV-2026-0018',
///   mono: true,
/// )
/// ```
class KeyValueRow extends StatelessWidget {
  /// Key or label displayed at the logical start of the row.
  final String k;

  /// Value displayed at the logical end of the row.
  final String v;

  /// Whether the value is conceptually monospaced.
  ///
  /// This property is retained for API compatibility. The current design
  /// system resolves the same body font for both branches.
  final bool mono;

  /// Whether the value should use Arabic text handling.
  ///
  /// This property is retained for API compatibility. The current design
  /// system resolves its body font through [SuperMaterialThemeData].
  final bool ar;

  /// Creates a compact key/value row.
  const KeyValueRow(
    this.k,
    this.v, {
    super.key,
    this.mono = false,
    this.ar = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SuperMaterialThemeData.of(context);

    // Keep the key compact while the value consumes the remaining width.
    // TextAlign.end follows the active text direction automatically.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Eyebrow(k, color: theme.superTheme.fg3),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13.5,
              color: theme.superTheme.fg1,
              // Preserve the existing API branches even though all currently
              // resolve to the design-system body font.
              fontFamily: ar
                  ? theme.textTheme.bodyMedium?.fontFamily
                  : (mono
                        ? theme.textTheme.bodyMedium?.fontFamily
                        : theme.textTheme.bodyMedium?.fontFamily),
            ),
          ),
        ),
      ],
    );
  }
}
