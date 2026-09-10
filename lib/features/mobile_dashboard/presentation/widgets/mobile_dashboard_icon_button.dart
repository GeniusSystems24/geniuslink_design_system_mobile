// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final String? badge;
  final String? semanticLabel;
  final IconSurfaceButtonThemeData? theme;
  final StatusBadgeThemeData? badgeTheme;

  const MobileDashboardIconButton({
    required this.icon,
    required this.onTap,
    this.badge,
    this.semanticLabel,
    this.theme,
    this.badgeTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = theme ??
        context.mdComponentTheme.iconButtonTheme ??
        IconSurfaceButtonThemeData(
          surfaceTheme: IconSurfaceThemeData(
            size: 38,
            backgroundColor: context.mdTheme.inputBg,
            borderColor: context.mdTheme.border,
            borderRadius: BorderRadius.circular(8),
          ),
        );

    return IconSurfaceButton(
      onTap: onTap,
      semanticLabel: semanticLabel,
      theme: resolvedTheme,
      icon: Icon(MIcons.of(icon), size: 18, color: context.mdTheme.fg1),
      badge: badge == null
          ? null
          : StatusBadge(
              theme: badgeTheme ??
                  StatusBadgeThemeData(
                    minWidth: 15,
                    minHeight: 15,
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    backgroundColor: context.mdColors.error,
                    foregroundColor: context.mdColors.onError,
                    borderColor: context.mdTheme.bg,
                    borderWidth: 1.5,
                  ),
              child: Text(
                badge!,
                style: TextStyle(
                  fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}
