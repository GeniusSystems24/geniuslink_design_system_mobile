// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

/// Displays a circular text avatar derived from a name.
///
/// The avatar uses the first character from at most the first two whitespace-
/// separated words in [name]. For example, `Genius Systems` renders as `GS`.
///
/// Example:
///
/// ```dart
/// const Avatar(
///   'Genius Systems',
///   size: 48,
/// )
/// ```
class Avatar extends StatelessWidget {
  /// Name used to derive the displayed initials.
  final String name;

  /// Diameter of the circular avatar.
  final double size;

  /// Creates a text-based circular avatar.
  const Avatar(
    this.name, {
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SuperMaterialThemeData.of(context);

    // Normalize whitespace, keep at most two words, and derive one initial from
    // each so long display names remain compact.
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.take(2).map((word) {
      return word.isEmpty ? '' : word[0];
    }).join();

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.superTheme.inputBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.superTheme.borderStrong,
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: theme.textTheme.headlineMedium?.fontFamily,
          fontWeight: FontWeight.w700,
          // Keep the initials visually proportional to the requested diameter.
          fontSize: size * 0.36,
          color: theme.superTheme.fg2,
        ),
      ),
    );
  }
}
