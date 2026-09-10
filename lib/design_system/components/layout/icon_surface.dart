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
class IconSurfaceThemeData {
  const IconSurfaceThemeData({
    this.size = 40,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.padding = EdgeInsets.zero,
  });

  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

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
class IconSurfaceButtonThemeData {
  const IconSurfaceButtonThemeData({
    this.surfaceTheme = const IconSurfaceThemeData(),
    this.badgeTop = -8,
    this.badgeEnd = -8,
    this.pressableTheme = const PressableSurfaceThemeData(),
  });

  final IconSurfaceThemeData surfaceTheme;
  final double badgeTop;
  final double badgeEnd;
  final PressableSurfaceThemeData pressableTheme;

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
