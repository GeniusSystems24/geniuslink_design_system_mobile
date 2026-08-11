// ============================================================
// GeniusLink Mobile — Feedback (Pill)
// File placement:  lib/design_system/components/feedback/m_feedback.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' hide PillTone;
import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';

enum PillTone { success, info, warning, danger, neutral }

class Pill extends StatelessWidget {
  final String label;
  final PillTone tone;
  const Pill(this.label, {super.key, this.tone = PillTone.success});
  @override
  Widget build(BuildContext context) {
    final c = switch (tone) {
      PillTone.success => SuperMaterialThemeData.of(
        context,
      ).colorScheme.secondary,
      PillTone.info => SuperMaterialThemeData.of(context).colorScheme.primary,
      PillTone.warning => SuperMaterialThemeData.of(
        context,
      ).colorScheme.tertiary,
      PillTone.danger => SuperMaterialThemeData.of(context).colorScheme.error,
      PillTone.neutral => SuperMaterialThemeData.of(context).superTheme.fg3,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: superCoreTint(c, 0x26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: SuperMaterialThemeData.of(
            context,
          ).textTheme.bodyMedium?.fontFamily,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: c,
        ),
      ),
    );
  }
}
