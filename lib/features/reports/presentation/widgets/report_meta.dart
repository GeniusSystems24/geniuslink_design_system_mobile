// Reusable presentation widget extracted from the former multi-screen file.

import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';

class ReportMeta extends StatelessWidget {
  final String period;
  final ValueChanged<String> onPeriod;
  final List<(String, String)> badges;
  const ReportMeta({
    super.key,
    required this.period,
    required this.onPeriod,
    required this.badges,
  });
  @override
  Widget build(BuildContext context) {
    return SuperSectionCard2(
      
      title: "",
      
      initiallyExpanded: true,
      accentColor: (null),
      
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Segmented(
            options: const ['Dec 2024', 'Nov 2024', 'Q4 2024', 'FY 2024'],
            value: period,
            onChange: onPeriod,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              for (final b in badges)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Eyebrow(
                      b.$1,
                      color: SuperMaterialThemeData.of(context).superTheme.fg3,
                      size: 9.5,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      b.$2,
                      style: TextStyle(
                        fontFamily: SuperMaterialThemeData.of(
                          context,
                        ).textTheme.bodyMedium?.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: SuperMaterialThemeData.of(
                          context,
                        ).superTheme.fg1,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
