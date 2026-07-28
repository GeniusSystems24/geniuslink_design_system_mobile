import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardViewAllButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const MobileDashboardViewAllButton({
    required this.onTap,
    this.label = 'View all',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: context.mdColors.primary,
            ),
          ),
          Icon(MIcons.of('chevR'), size: 14, color: context.mdColors.primary),
        ],
      ),
    );
  }
}

class MobileDashboardPill extends StatelessWidget {
  final String label;
  final Color color;

  const MobileDashboardPill({
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: superCoreTint(color, 0x24),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: color,
        ),
      ),
    );
  }
}
