// ============================================================
// GeniusLink Mobile — Buttons (MBtn)
// File placement:  lib/design_system/components/buttons/m_buttons.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';
import '../layout/m_icons.dart';

import 'package:gl_mobile_app/design_system/theme/super_core_theme_helpers.dart';

enum MBtnVariant { primary, secondary, danger }

class MBtn extends StatelessWidget {
  final String label;
  final MBtnVariant variant;
  final String? icon;
  final VoidCallback? onTap;
  final bool full;
  const MBtn(
    this.label, {
    super.key,
    this.variant = MBtnVariant.primary,
    this.icon,
    this.onTap,
    this.full = false,
  });

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (variant) {
      MBtnVariant.primary => (
        SuperMaterialThemeData.of(context).colorScheme.primary,
        Colors.white,
        null,
      ),
      MBtnVariant.secondary => (
        Colors.transparent,
        SuperMaterialThemeData.of(context).superTheme.fg1,
        SuperMaterialThemeData.of(context).superTheme.borderStrong,
      ),
      MBtnVariant.danger => (
        Colors.transparent,
        SuperMaterialThemeData.of(context).colorScheme.error,
        superCoreTint(
          SuperMaterialThemeData.of(context).colorScheme.error,
          0x66,
        ),
      ),
    };
    final child = Row(
      mainAxisSize: full ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(MIcons.of(icon!), size: 17, color: fg),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            fontFamily: SuperMaterialThemeData.of(
              context,
            ).textTheme.bodyMedium?.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fg,
          ),
        ),
      ],
    );
    return SizedBox(
      width: full ? double.infinity : null,
      height: 48,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: border == null ? BorderSide.none : BorderSide(color: border),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: child,
          ),
        ),
      ),
    );
  }
}
