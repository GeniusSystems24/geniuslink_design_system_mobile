import 'package:flutter/material.dart';

/// Configures the colors and animation timing of [AnimatedSkeletonBox].
///
/// The skeleton automatically respects accessibility settings that disable or
/// reduce animation.
///
/// Example:
///
/// ```dart
/// const skeletonTheme = AnimatedSkeletonBoxThemeData(
///   duration: Duration(milliseconds: 1000),
///   highlightWidthFactor: 0.5,
/// );
/// ```
@immutable
class AnimatedSkeletonBoxThemeData {
  const AnimatedSkeletonBoxThemeData({
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1250),
    this.highlightWidthFactor = 0.55,
  });

  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final double highlightWidthFactor;

  AnimatedSkeletonBoxThemeData copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? duration,
    double? highlightWidthFactor,
  }) {
    return AnimatedSkeletonBoxThemeData(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      highlightWidthFactor: highlightWidthFactor ?? this.highlightWidthFactor,
    );
  }
}

/// Renders an animated rectangular placeholder for loading content.
///
/// Use multiple boxes to approximate the structure of the final UI while data is
/// loading. The animation is suppressed when accessibility preferences request
/// reduced motion.
///
/// Example:
///
/// ```dart
/// const AnimatedSkeletonBox(
///   width: double.infinity,
///   height: 18,
///   borderRadius: BorderRadius.all(Radius.circular(6)),
/// )
/// ```
class AnimatedSkeletonBox extends StatefulWidget {
  const AnimatedSkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.theme = const AnimatedSkeletonBoxThemeData(),
  });

  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final AnimatedSkeletonBoxThemeData theme;

  @override
  State<AnimatedSkeletonBox> createState() => _AnimatedSkeletonBoxState();
}

class _AnimatedSkeletonBoxState extends State<AnimatedSkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _animationsDisabled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.theme.duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final media = MediaQuery.maybeOf(context);
    final disabled =
        (media?.disableAnimations ?? false) ||
        (media?.accessibleNavigation ?? false);
    if (disabled == _animationsDisabled && _controller.isAnimating) return;
    _animationsDisabled = disabled;
    if (_animationsDisabled) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedSkeletonBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme.duration != widget.theme.duration) {
      _controller.duration = widget.theme.duration;
      if (!_animationsDisabled) _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = widget.theme.baseColor ?? scheme.surfaceContainerHighest;
    final highlight = widget.theme.highlightColor ?? scheme.surfaceContainerLow;
    final transparent = base.withValues(alpha: 0);

    Widget placeholder(AlignmentGeometry alignment) {
      return RepaintBoundary(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: base),
                if (!_animationsDisabled)
                  FractionallySizedBox(
                    widthFactor: widget.theme.highlightWidthFactor,
                    alignment: alignment,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [transparent, highlight, transparent],
                          stops: const [0, 0.5, 1],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: _animationsDisabled
          ? placeholder(Alignment.center)
          : AnimatedBuilder(
              animation: _controller,
              builder: (_, _) => placeholder(
                Alignment(-3 + (_controller.value * 6), 0),
              ),
            ),
    );
  }
}
