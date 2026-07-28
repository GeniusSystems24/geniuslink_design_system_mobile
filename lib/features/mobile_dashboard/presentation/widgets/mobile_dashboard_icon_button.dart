import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_pressable.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final String? badge;
  final String? semanticLabel;

  const MobileDashboardIconButton({
    required this.icon,
    required this.onTap,
    this.badge,
    this.semanticLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDashboardPressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.mdTheme.inputBg,
          border: Border.all(color: context.mdTheme.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(MIcons.of(icon), size: 18, color: context.mdTheme.fg1),
            if (badge != null)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  height: 15,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: context.mdColors.error,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: context.mdTheme.bg, width: 1.5),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: context.mdColors.onError,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
