// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardOfflineBanner extends StatelessWidget {
  final String message;
  final DirectionalSlotTileThemeData? theme;

  const MobileDashboardOfflineBanner({
    this.message = "You're offline — showing last-known data",
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.mdColors.tertiary;
    return DirectionalSlotTile(
      theme:
          theme ??
          DirectionalSlotTileThemeData(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            gap: 8,
            backgroundColor: superCoreTint(color, 0x29),
          ),
      start: Icon(MIcons.of('ban'), size: 15, color: color),
      center: Text(
        message,
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
