// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import '../../../../design_system/kit.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardPressable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final PressableSurfaceThemeData? theme;

  const MobileDashboardPressable({
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PressableSurface(
      onTap: onTap,
      semanticLabel: semanticLabel,
      theme:
          theme ??
          context.mdComponentTheme.pressableTheme ??
          const PressableSurfaceThemeData(),
      child: child,
    );
  }
}
