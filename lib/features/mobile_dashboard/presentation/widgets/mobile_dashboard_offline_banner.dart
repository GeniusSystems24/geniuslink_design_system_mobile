import 'package:flutter/material.dart';
import 'package:gl_mobile_app/design_system/kit.dart';
import 'package:gl_mobile_app/features/mobile_dashboard/presentation/widgets/mobile_dashboard_theme.dart';

class MobileDashboardOfflineBanner extends StatelessWidget {
  final String message;

  const MobileDashboardOfflineBanner({
    this.message = "You're offline — showing last-known data",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: superCoreTint(context.mdColors.tertiary, 0x29),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Row(
        children: [
          Icon(MIcons.of('ban'), size: 15, color: context.mdColors.tertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.mdColors.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
