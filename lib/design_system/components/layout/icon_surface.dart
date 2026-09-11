// LAYOUT_THEME_EXTENSIONS_V1
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'pressable_surface.dart';

/// Configures the reusable container rendered by [IconSurface].
///
/// The theme controls the surface size, padding, border, and radius. The icon or
/// other visual content is still supplied by the caller.
///
/// Example:
///
/// ```dart
/// const iconSurfaceTheme = IconSurfaceThemeData(
///   size: 44,
///   borderRadius: BorderRadius.all(Radius.circular(12)),
/// );
/// ```
@immutable
class IconSurfaceThemeData
    extends ThemeExtension<IconSurfaceThemeData> {
  const IconSurfaceThemeData({
    this.size = 40,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.padding = EdgeInsets.zero,
  });

  /// Returns the registered [IconSurfaceThemeData], if available.
  static IconSurfaceThemeData? mayOf(BuildContext context) {
    return Theme.of(context).extension<IconSurfaceThemeData>();
  }

  /// Returns the effective icon-surface theme for [context].
  static IconSurfaceThemeData of(BuildContext context) {
    final registered = mayOf(context);
    if (registered != null) {
      return registered;
    }

    final materialTheme = Theme.of(context);
    return materialTheme.brightness == Brightness.dark
        ? dark(colorScheme: materialTheme.colorScheme)
        : light(colorScheme: materialTheme.colorScheme);
  }

  /// Creates the default light icon-surface theme.
  static IconSurfaceThemeData light({
    ColorScheme colorScheme = const ColorScheme.light(),
  }) {
    return IconSurfaceThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      borderColor: colorScheme.outlineVariant,
    );
  }

  /// Creates the default dark icon-surface theme.
  static IconSurfaceThemeData dark({
    ColorScheme colorScheme = const ColorScheme.dark(),
  }) {
    return IconSurfaceThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      borderColor: colorScheme.outlineVariant,
    );
  }

  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  IconSurfaceThemeData copyWith({
    double? size,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return IconSurfaceThemeData(
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  @override
  IconSurfaceThemeData lerp(
    covariant IconSurfaceThemeData? other,
    double t,
  ) {
    if (other == null || identical(this, other)) {
      return this;
    }

    return IconSurfaceThemeData(
      size: ui.lerpDouble(size, other.size, t)!,
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      ),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: ui.lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      )!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
    );
  }
}

/// Places arbitrary [child] content inside a reusable square surface.
///
/// Although commonly used with an [Icon], the slot accepts any widget so callers
/// are not coupled to `IconData` or to one feature's visual representation.
///
/// Example:
///
/// ```dart
/// const IconSurface(
///   child: Icon(Icons.account_balance_wallet_outlined),
/// )
/// ```
class IconSurface extends StatelessWidget {
  const IconSurface({
    super.key,
    required this.child,
    this.theme = const IconSurfaceThemeData(),
  });

  final Widget child;
  final IconSurfaceThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: theme.size,
      height: theme.size,
      padding: theme.padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.borderColor == null
            ? null
            : Border.all(color: theme.borderColor!, width: theme.borderWidth),
        borderRadius: theme.borderRadius,
      ),
      child: child,
    );
  }
}

/// Configures [IconSurfaceButton], including its surface, badge
/// position, and press feedback.
///
/// Example:
///
/// ```dart
/// const iconButtonTheme = IconSurfaceButtonThemeData(
///   badgeTop: -6,
///   badgeEnd: -6,
///   surfaceTheme: IconSurfaceThemeData(size: 44),
/// );
/// ```
@immutable
class IconSurfaceButtonThemeData
    extends ThemeExtension<IconSurfaceButtonThemeData> {
  const IconSurfaceButtonThemeData({
    this.surfaceTheme = const IconSurfaceThemeData(),
    this.badgeTop = -8,
    this.badgeEnd = -8,
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  /// Returns the registered [IconSurfaceButtonThemeData], if available.
  static IconSurfaceButtonThemeData? mayOf(BuildContext context) {
    return Theme.of(context).extension<IconSurfaceButtonThemeData>();
  }

  /// Returns the effective icon-surface-button theme for [context].
  static IconSurfaceButtonThemeData of(BuildContext context) {
    final registered = mayOf(context);
    if (registered != null) {
      return registered;
    }

    final materialTheme = Theme.of(context);
    return materialTheme.brightness == Brightness.dark
        ? dark(colorScheme: materialTheme.colorScheme)
        : light(colorScheme: materialTheme.colorScheme);
  }

  /// Creates the default light icon-surface-button theme.
  static IconSurfaceButtonThemeData light({
    ColorScheme colorScheme = const ColorScheme.light(),
  }) {
    return IconSurfaceButtonThemeData(
      surfaceTheme: IconSurfaceThemeData.light(colorScheme: colorScheme),
      pressableTheme: PressableSurfaceThemeData.light(),
    );
  }

  /// Creates the default dark icon-surface-button theme.
  static IconSurfaceButtonThemeData dark({
    ColorScheme colorScheme = const ColorScheme.dark(),
  }) {
    return IconSurfaceButtonThemeData(
      surfaceTheme: IconSurfaceThemeData.dark(colorScheme: colorScheme),
      pressableTheme: PressableSurfaceThemeData.dark(),
    );
  }

  final IconSurfaceThemeData surfaceTheme;
  final double badgeTop;
  final double badgeEnd;
  final PressableSurfaceThemeData pressableTheme;

  @override
  IconSurfaceButtonThemeData copyWith({
    IconSurfaceThemeData? surfaceTheme,
    double? badgeTop,
    double? badgeEnd,
    PressableSurfaceThemeData? pressableTheme,
  }) {
    return IconSurfaceButtonThemeData(
      surfaceTheme: surfaceTheme ?? this.surfaceTheme,
      badgeTop: badgeTop ?? this.badgeTop,
      badgeEnd: badgeEnd ?? this.badgeEnd,
      pressableTheme: pressableTheme ?? this.pressableTheme,
    );
  }

  @override
  IconSurfaceButtonThemeData lerp(
    covariant IconSurfaceButtonThemeData? other,
    double t,
  ) {
    if (other == null || identical(this, other)) {
      return this;
    }

    return IconSurfaceButtonThemeData(
      surfaceTheme: surfaceTheme.lerp(other.surfaceTheme, t),
      badgeTop: ui.lerpDouble(badgeTop, other.badgeTop, t)!,
      badgeEnd: ui.lerpDouble(badgeEnd, other.badgeEnd, t)!,
      pressableTheme: pressableTheme.lerp(other.pressableTheme, t),
    );
  }
}

/// Creates a pressable icon surface with an optional visual [badge]
/// slot.
///
/// The button accepts widgets instead of feature-specific icon/status models, so
/// callers can compose icons, images, counters, or custom badges as needed.
///
/// Example:
///
/// ```dart
/// IconSurfaceButton(
///   icon: const Icon(Icons.notifications_none),
///   badge: const Text('3'),
///   semanticLabel: 'Notifications',
///   onTap: () {},
/// )
/// ```
class IconSurfaceButton extends StatelessWidget {
  const IconSurfaceButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.badge,
    this.semanticLabel,
    this.theme = const IconSurfaceButtonThemeData(),
  });

  final Widget icon;
  final Widget? badge;
  final VoidCallback onTap;
  final String? semanticLabel;
  final IconSurfaceButtonThemeData theme;

  @override
  Widget build(BuildContext context) {
    return PressableSurface(
      onTap: onTap,
      semanticLabel: semanticLabel,
      theme: theme.pressableTheme,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          IconSurface(theme: theme.surfaceTheme, child: icon),
          if (badge != null)
            PositionedDirectional(
              top: theme.badgeTop,
              end: theme.badgeEnd,
              child: badge!,
            ),
        ],
      ),
    );
  }
}
