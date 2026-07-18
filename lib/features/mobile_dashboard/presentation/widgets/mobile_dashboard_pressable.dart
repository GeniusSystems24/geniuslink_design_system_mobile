import 'package:flutter/material.dart';

class MobileDashboardPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;

  const MobileDashboardPressable({
    required this.child,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  @override
  State<MobileDashboardPressable> createState() =>
      _MobileDashboardPressableState();
}

class _MobileDashboardPressableState
    extends State<MobileDashboardPressable> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final content = GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap == null
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.onTap == null
          ? null
          : (_) => setState(() => _isPressed = false),
      onTapCancel: widget.onTap == null
          ? null
          : () => setState(() => _isPressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 90),
        child: widget.child,
      ),
    );

    if (widget.semanticLabel == null) {
      return content;
    }

    return Semantics(
      button: widget.onTap != null,
      label: widget.semanticLabel,
      child: content,
    );
  }
}
