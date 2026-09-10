import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Builds a constraint-driven grid from reusable widget [children].
///
/// The number of columns is derived from the width provided by the parent and
/// [minItemWidth], rather than from device labels such as phone, tablet, or
/// desktop. This keeps the grid reusable in nested and resizable layouts.
///
/// Example:
///
/// ```dart
/// AdaptiveSlotGrid(
///   minItemWidth: 150,
///   maxColumns: 4,
///   spacing: 12,
///   children: const [
///     Text('One'),
///     Text('Two'),
///     Text('Three'),
///     Text('Four'),
///   ],
/// )
/// ```
class AdaptiveSlotGrid extends StatelessWidget {
  const AdaptiveSlotGrid({
    super.key,
    required this.children,
    required this.minItemWidth,
    this.maxColumns = 4,
    this.spacing = 12,
    this.runSpacing = 12,
    this.childAspectRatio = 1,
  });

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;
  final double runSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : minItemWidth;
        final raw = ((width + spacing) / (minItemWidth + spacing)).floor();
        final columns = math.max(1, math.min(maxColumns, raw));

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: runSpacing,
          crossAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: children,
        );
      },
    );
  }
}
