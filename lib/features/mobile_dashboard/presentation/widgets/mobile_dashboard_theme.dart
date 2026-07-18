import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as super_core;

import '../../domain/domain.dart';

extension MobileDashboardThemeContext on BuildContext {
  super_core.SuperMaterialThemeData get mdMaterialTheme =>
      super_core.SuperMaterialThemeData.of(this);

  super_core.SuperThemeData get mdTheme => mdMaterialTheme.superTheme;

  ColorScheme get mdColors => mdMaterialTheme.colorScheme;

  TextTheme get mdTextTheme => mdMaterialTheme.textTheme;
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
