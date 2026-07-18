import 'package:flutter/material.dart';

import 'mobile_dashboard_theme.dart';

class MobileDashboardSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const MobileDashboardSkeleton({
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.mdTheme.inputBg,
        borderRadius: borderRadius,
      ),
    );
  }
}
