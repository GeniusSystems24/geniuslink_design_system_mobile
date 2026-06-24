// ============================================================
// GeniusLink Mobile — Feedback (Pill)
// File placement:  lib/design_system/components/feedback/m_feedback.dart
// ============================================================

import 'package:flutter/material.dart';
import '../../tokens/m_colors.dart';

enum PillTone { success, info, warning, danger, neutral }

class Pill extends StatelessWidget {
  final String label;
  final PillTone tone;
  const Pill(this.label, {super.key, this.tone = PillTone.success});
  @override
  Widget build(BuildContext context) {
    final c = switch (tone) {
      PillTone.success => M.green,
      PillTone.info    => M.blue,
      PillTone.warning => M.orange,
      PillTone.danger  => M.red,
      PillTone.neutral => M.fg3,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(color: tint(c, 0x26), borderRadius: BorderRadius.circular(10)),
      child: Text(label.toUpperCase(), style: TextStyle(fontFamily: M.body, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: c)),
    );
  }
}
