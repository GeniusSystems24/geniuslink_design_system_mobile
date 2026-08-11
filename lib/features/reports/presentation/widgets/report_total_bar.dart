// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class ReportTotalBar extends StatelessWidget {
  final String label, value;
  final Color? tone;
  const ReportTotalBar({
    super.key,
    required this.label,
    required this.value,
    this.tone,
  });
  @override
  Widget build(BuildContext context) {
    final resolvedTone =
        tone ?? SuperMaterialThemeData.of(context).colorScheme.secondary;
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: superCoreTint(resolvedTone, 0x14),
        border: Border.all(color: superCoreTint(resolvedTone, 0x4D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Eyebrow(label, color: resolvedTone, size: 11),
          Text(
            value,
            style: TextStyle(
              fontFamily: SuperMaterialThemeData.of(
                context,
              ).textTheme.bodyMedium?.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: SuperMaterialThemeData.of(context).superTheme.fg1,
            ),
          ),
        ],
      ),
    );
  }
}
