// Reusable presentation widget extracted from the former multi-screen file.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class BillingUsageBar extends StatelessWidget {
  final String label;
  final double val, max;
  final String unit;
  const BillingUsageBar({
    super.key,
    required this.label,
    required this.val,
    required this.max,
    required this.unit,
  });
  @override
  Widget build(BuildContext context) {
    final pct = math.min(100, ((val / max) * 100).round());
    final fmt = val > 100
        ? val.toInt().toString().replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+$)'),
            (m) => '${m[1]},',
          )
        : val.toString();
    final maxFmt = max.toInt().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Eyebrow(
                label,
                color: SuperMaterialThemeData.of(context).superTheme.fg3,
                size: 10,
              ),
              Text(
                '$fmt$unit / $maxFmt',
                style: TextStyle(
                  fontFamily: SuperMaterialThemeData.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 11,
                  color: SuperMaterialThemeData.of(context).superTheme.fg2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(
                  height: 6,
                  color: SuperMaterialThemeData.of(context).superTheme.inputBg,
                ),
                FractionallySizedBox(
                  widthFactor: pct / 100,
                  child: Container(
                    height: 6,
                    color: pct > 85
                        ? SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.tertiary
                        : SuperMaterialThemeData.of(
                            context,
                          ).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
