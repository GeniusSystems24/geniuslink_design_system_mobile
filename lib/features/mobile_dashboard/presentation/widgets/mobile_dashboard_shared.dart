import 'package:flutter/material.dart';

import '../../../../design_system/kit.dart';
import '../../domain/domain.dart';
import 'mobile_dashboard_theme.dart';

class MobileDashboardSectionHeader extends StatelessWidget {
  final String title;
  final MdMarker marker;
  final String? subtitle;
  final Widget? trailing;

  const MobileDashboardSectionHeader({
    required this.title,
    required this.marker,
    this.subtitle,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              color: mobileDashboardMarkerColor(context, marker),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: context.mdTheme.fg1,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: context.mdTheme.fg3,
                        fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

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
