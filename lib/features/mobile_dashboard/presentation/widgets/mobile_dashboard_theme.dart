// MOBILE_DASHBOARD_COMPONENTIZATION_V3
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as super_core;

import '../../../../design_system/components/controls/segmented_slot_selector.dart';
import '../../../../design_system/components/feedback/status_badge.dart';
import '../../../../design_system/components/layout/directional_slot_tile.dart';
import '../../../../design_system/components/layout/icon_surface.dart';
import '../../../../design_system/components/layout/labeled_action_tile.dart';
import '../../../../design_system/components/layout/metric_slot_card.dart';
import '../../../../design_system/components/layout/pressable_surface.dart';
import '../../../../design_system/components/layout/two_row_tile.dart';
import '../../domain/domain.dart';

/// Groups reusable component theme overrides for the mobile dashboard.
///
/// Values supplied here act as feature-level defaults. Individual components can
/// still receive a more specific theme when a local visual override is required.
///
/// Example:
///
/// ```dart
/// const dashboardComponents = MobileDashboardComponentThemeData(
///   metricCardTheme: MetricSlotCardThemeData(
///     borderRadius: BorderRadius.all(Radius.circular(14)),
///   ),
///   badgeTheme: StatusBadgeThemeData(
///     borderRadius: BorderRadius.all(Radius.circular(999)),
///   ),
/// );
/// ```
@immutable
class MobileDashboardComponentThemeData {
  const MobileDashboardComponentThemeData({
    this.pressableTheme,
    this.rowTheme,
    this.twoRowTheme,
    this.metricCardTheme,
    this.actionTileTheme,
    this.iconSurfaceTheme,
    this.iconButtonTheme,
    this.badgeTheme,
    this.segmentedSelectorTheme,
  });

  final PressableSurfaceThemeData? pressableTheme;
  final DirectionalSlotTileThemeData? rowTheme;
  final TwoRowTileThemeData? twoRowTheme;
  final MetricSlotCardThemeData? metricCardTheme;
  final LabeledActionTileThemeData? actionTileTheme;
  final IconSurfaceThemeData? iconSurfaceTheme;
  final IconSurfaceButtonThemeData? iconButtonTheme;
  final StatusBadgeThemeData? badgeTheme;
  final SegmentedSlotSelectorThemeData? segmentedSelectorTheme;

  MobileDashboardComponentThemeData copyWith({
    PressableSurfaceThemeData? pressableTheme,
    DirectionalSlotTileThemeData? rowTheme,
    TwoRowTileThemeData? twoRowTheme,
    MetricSlotCardThemeData? metricCardTheme,
    LabeledActionTileThemeData? actionTileTheme,
    IconSurfaceThemeData? iconSurfaceTheme,
    IconSurfaceButtonThemeData? iconButtonTheme,
    StatusBadgeThemeData? badgeTheme,
    SegmentedSlotSelectorThemeData? segmentedSelectorTheme,
  }) {
    return MobileDashboardComponentThemeData(
      pressableTheme: pressableTheme ?? this.pressableTheme,
      rowTheme: rowTheme ?? this.rowTheme,
      twoRowTheme: twoRowTheme ?? this.twoRowTheme,
      metricCardTheme: metricCardTheme ?? this.metricCardTheme,
      actionTileTheme: actionTileTheme ?? this.actionTileTheme,
      iconSurfaceTheme: iconSurfaceTheme ?? this.iconSurfaceTheme,
      iconButtonTheme: iconButtonTheme ?? this.iconButtonTheme,
      badgeTheme: badgeTheme ?? this.badgeTheme,
      segmentedSelectorTheme:
          segmentedSelectorTheme ?? this.segmentedSelectorTheme,
    );
  }
}

/// Provides [MobileDashboardComponentThemeData] to a dashboard subtree.
///
/// Wrap the dashboard (or a smaller subtree) to customize reusable presentation
/// components without coupling those components to dashboard domain models.
///
/// Example:
///
/// ```dart
/// MobileDashboardTheme(
///   data: const MobileDashboardComponentThemeData(
///     rowTheme: DirectionalSlotTileThemeData(gap: 10),
///   ),
///   child: dashboardBody,
/// )
/// ```
///
/// In the example, `dashboardBody` is any widget that composes mobile-dashboard
/// content.
class MobileDashboardTheme extends InheritedTheme {
  const MobileDashboardTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MobileDashboardComponentThemeData data;

  static MobileDashboardComponentThemeData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MobileDashboardTheme>()
        ?.data;
  }

  @override
  bool updateShouldNotify(MobileDashboardTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MobileDashboardTheme(data: data, child: child);
  }
}

extension MobileDashboardThemeContext on BuildContext {
  super_core.SuperMaterialThemeData get mdMaterialTheme =>
      super_core.SuperMaterialThemeData.of(this);

  super_core.SuperThemeData get mdTheme => mdMaterialTheme.superTheme;

  ColorScheme get mdColors => mdMaterialTheme.colorScheme;

  TextTheme get mdTextTheme => mdMaterialTheme.textTheme;

  MobileDashboardComponentThemeData get mdComponentTheme =>
      MobileDashboardTheme.maybeOf(this) ??
      const MobileDashboardComponentThemeData();
}

Color mobileDashboardMarkerColor(BuildContext context, MdMarker marker) {
  final colors = context.mdColors;
  return switch (marker) {
    MdMarker.positive => colors.secondary,
    MdMarker.warning => colors.tertiary,
    MdMarker.primary => colors.primary,
  };
}

Color mobileDashboardToneColor(BuildContext context, MdTone tone) {
  final colors = context.mdColors;
  return switch (tone) {
    MdTone.success => colors.secondary,
    MdTone.information => colors.primary,
    MdTone.warning => colors.tertiary,
    MdTone.danger => colors.error,
    MdTone.neutral => context.mdTheme.fg3,
  };
}

String mobileDashboardNumber(num value, {int decimals = 0}) {
  final fixed = value.toStringAsFixed(decimals);
  final parts = fixed.split('.');
  final negative = parts.first.startsWith('-');
  final digits = negative ? parts.first.substring(1) : parts.first;
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }

  final fraction = parts.length > 1 ? '.${parts.last}' : '';
  return '${negative ? '-' : ''}$buffer$fraction';
}

String mobileDashboardCompactNumber(num value) {
  final abs = value.abs();
  final sign = value < 0 ? '-' : '';

  if (abs >= 1000000000) {
    return '$sign${(abs / 1000000000).toStringAsFixed(abs >= 10000000000 ? 0 : 1)}B';
  }
  if (abs >= 1000000) {
    return '$sign${(abs / 1000000).toStringAsFixed(abs >= 10000000 ? 0 : 1)}M';
  }
  if (abs >= 1000) {
    return '$sign${(abs / 1000).toStringAsFixed(abs >= 10000 ? 0 : 1)}K';
  }
  return '$sign${abs.toStringAsFixed(abs >= 100 ? 0 : 1)}';
}
