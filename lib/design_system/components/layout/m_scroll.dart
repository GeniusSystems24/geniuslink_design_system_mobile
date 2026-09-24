// M_WIDGETS_SPLIT_V1
// Extracted from m_widgets.dart so this widget has one clear source file.
// LAYOUT_WIDGET_DOCS_V1
import 'package:flutter/material.dart';

/// Displays a vertically scrolling list with consistent page padding and gaps.
///
/// [MScroll] is intended for simple screen bodies composed from a finite list
/// of sections. It uses [ListView.separated] so spacing stays centralized.
///
/// Example:
///
/// ```dart
/// MScroll(
///   const [
///     Text('Overview'),
///     Text('Details'),
///     Text('Activity'),
///   ],
///   pad: 20,
/// )
/// ```
class MScroll extends StatelessWidget {
  /// Widgets displayed from top to bottom.
  final List<Widget> children;

  /// Horizontal and top padding around the list.
  ///
  /// The bottom inset remains `24` logical pixels to preserve the component's
  /// existing screen-bottom breathing room.
  final double pad;

  /// Creates a vertically scrolling section list.
  const MScroll(this.children, {super.key, this.pad = 16});

  @override
  Widget build(BuildContext context) {
    // ListView.separated centralizes inter-section spacing so callers do not
    // need to wrap every child in its own bottom Padding or SizedBox.
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(pad, pad, pad, 24),
      itemCount: children.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) => children[index],
    );
  }
}
