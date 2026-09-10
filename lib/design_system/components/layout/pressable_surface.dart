import 'package:flutter/material.dart';

/// Configures the press animation used by [PressableSurface].
///
/// Use this object for interaction-only styling such as scale, duration, and
/// animation curve. The visual appearance of the child remains owned by the
/// child itself.
///
/// Example:
///
/// ```dart
/// const pressTheme = PressableSurfaceThemeData(
///   pressedScale: 0.94,
///   duration: Duration(milliseconds: 120),
/// );
/// ```
@immutable
class PressableSurfaceThemeData {
  const PressableSurfaceThemeData({
    this.pressedScale = 0.96,
    this.duration = const Duration(milliseconds: 90),
    this.curve = Curves.easeOut,
  });

  final double pressedScale;
  final Duration duration;
  final Curve curve;

  PressableSurfaceThemeData copyWith({
    double? pressedScale,
    Duration? duration,
    Curve? curve,
  }) {
    return PressableSurfaceThemeData(
      pressedScale: pressedScale ?? this.pressedScale,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

/// Adds reusable press feedback to an arbitrary [child].
///
/// This component is presentation-only. It does not know which feature owns the
/// child or what the action means. Supply [semanticLabel] when the child does not
/// already expose an accessible action label.
///
/// Example:
///
/// ```dart
/// PressableSurface(
///   semanticLabel: 'Open account details',
///   onTap: () {},
///   child: const Card(
///     child: Padding(
///       padding: EdgeInsets.all(16),
///       child: Text('Account details'),
///     ),
///   ),
/// )
/// ```
class PressableSurface extends StatefulWidget {
  const PressableSurface({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.theme = const PressableSurfaceThemeData(),
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final PressableSurfaceThemeData theme;

  @override
  State<PressableSurface> createState() => _PressableSurfaceState();
}

class _PressableSurfaceState extends State<PressableSurface> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value || !mounted) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap == null ? null : (_) => _setPressed(true),
      onTapUp: widget.onTap == null ? null : (_) => _setPressed(false),
      onTapCancel: widget.onTap == null ? null : () => _setPressed(false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? widget.theme.pressedScale : 1,
        duration: widget.theme.duration,
        curve: widget.theme.curve,
        child: widget.child,
      ),
    );

    if (widget.semanticLabel == null) return child;

    return Semantics(
      button: widget.onTap != null,
      label: widget.semanticLabel,
      child: child,
    );
  }
}
