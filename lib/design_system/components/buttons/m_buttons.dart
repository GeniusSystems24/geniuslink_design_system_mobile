// ============================================================
// GeniusLink Mobile — Buttons (MBtn)
// File placement:  lib/design_system/components/buttons/m_buttons.dart
// ============================================================

import 'package:flutter/material.dart';
import '../../tokens/m_colors.dart';
import '../layout/m_icons.dart';

enum MBtnVariant { primary, secondary, danger }

class MBtn extends StatelessWidget {
  final String label;
  final MBtnVariant variant;
  final String? icon;
  final VoidCallback? onTap;
  final bool full;
  const MBtn(this.label, {super.key, this.variant = MBtnVariant.primary, this.icon, this.onTap, this.full = false});

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (variant) {
      MBtnVariant.primary   => (M.blue, Colors.white, null),
      MBtnVariant.secondary => (Colors.transparent, M.fg1, M.borderStrong),
      MBtnVariant.danger    => (Colors.transparent, M.red, tint(M.red, 0x66)),
    };
    final child = Row(
      mainAxisSize: full ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(MIcons.of(icon!), size: 17, color: fg), const SizedBox(width: 8)],
        Text(label, style: TextStyle(fontFamily: M.body, fontWeight: FontWeight.w600, fontSize: 15, color: fg)),
      ],
    );
    return SizedBox(
      width: full ? double.infinity : null,
      height: 48,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: border == null ? BorderSide.none : BorderSide(color: border)),
        child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: child)),
      ),
    );
  }
}
