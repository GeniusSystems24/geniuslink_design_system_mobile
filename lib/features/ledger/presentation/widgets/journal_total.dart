// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class JournalTotal extends StatelessWidget {
  final String label, value;
  final Color color;
  const JournalTotal(this.label, this.value, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Eyebrow(
        label,
        color: SuperMaterialThemeData.of(context).superTheme.fg3,
        size: 9,
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontFamily: SuperMaterialThemeData.of(
            context,
          ).textTheme.bodyMedium?.fontFamily,
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    ],
  );
}
