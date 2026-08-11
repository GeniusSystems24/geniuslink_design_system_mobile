import 'dart:math' as math;

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import 'mobile_dashboard_theme.dart';

class MobileDashboardTrendChart extends StatelessWidget {
  final List<double> values;
  final Color color;
  final List<String> axisLabels;
  final String currency;
  final double height;
  final String semanticsLabel;

  const MobileDashboardTrendChart({
    required this.values,
    required this.color,
    required this.axisLabels,
    required this.currency,
    required this.semanticsLabel,
    this.height = 176,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      image: true,
      child: RepaintBoundary(
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(
            painter: _MobileDashboardTrendPainter(
              values: values,
              color: color,
              axis: axisLabels,
              currency: currency,
              gridColor: context.mdColors.outlineVariant.withValues(
                alpha: 0.58,
              ),
              surfaceColor: context.mdTheme.surface,
              labelColor: context.mdColors.onSurfaceVariant,
              valueLabelColor: context.mdTheme.fg2,
              tooltipBackground: context.mdColors.inverseSurface,
              tooltipForeground: context.mdColors.onInverseSurface,
              fontFamily: context.mdTextTheme.bodyMedium?.fontFamily,
              textDirection: Directionality.of(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileDashboardTrendPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final List<String> axis;
  final String currency;
  final Color gridColor;
  final Color surfaceColor;
  final Color labelColor;
  final Color valueLabelColor;
  final Color tooltipBackground;
  final Color tooltipForeground;
  final String? fontFamily;
  final TextDirection textDirection;

  const _MobileDashboardTrendPainter({
    required this.values,
    required this.color,
    required this.axis,
    required this.currency,
    required this.gridColor,
    required this.surfaceColor,
    required this.labelColor,
    required this.valueLabelColor,
    required this.tooltipBackground,
    required this.tooltipForeground,
    required this.fontFamily,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty || size.width <= 0 || size.height <= 0) {
      return;
    }

    const padLeft = 50.0;
    const padRight = 12.0;
    const padTop = 16.0;
    const padBottom = 27.0;
    final plotWidth = math.max(1.0, size.width - padLeft - padRight);
    final plotHeight = math.max(1.0, size.height - padTop - padBottom);
    final count = values.length;
    final rawMin = values.reduce(math.min);
    final rawMax = values.reduce(math.max);
    final rawSpan = rawMax - rawMin;
    final fallbackSpan = math.max(rawMax.abs() * 0.08, 1.0);
    final span = rawSpan.abs() < 0.000001 ? fallbackSpan : rawSpan;
    final low = rawMin - span * 0.14;
    final high = rawMax + span * 0.18;

    double xAt(int index) =>
        padLeft +
        (count == 1 ? plotWidth / 2 : index / (count - 1) * plotWidth);
    double yAt(double value) =>
        padTop + plotHeight - ((value - low) / (high - low)) * plotHeight;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    const gridLines = 4;
    for (var i = 0; i <= gridLines; i++) {
      final fraction = i / gridLines;
      final y = padTop + plotHeight * fraction;
      canvas.drawLine(
        Offset(padLeft, y),
        Offset(size.width - padRight, y),
        gridPaint,
      );
      final value = high - (high - low) * fraction;
      final label = TextPainter(
        text: TextSpan(
          text: mobileDashboardCompactNumber(value),
          style: TextStyle(
            color: valueLabelColor,
            fontSize: 9.5,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: textDirection,
        maxLines: 1,
      )..layout(maxWidth: padLeft - 8);
      label.paint(
        canvas,
        Offset(padLeft - label.width - 7, y - label.height / 2),
      );
    }

    final points = [
      for (var i = 0; i < count; i++) Offset(xAt(i), yAt(values[i])),
    ];
    final linePath = _smoothPath(points);
    final areaPath = Path.from(linePath)
      ..lineTo(points.last.dx, padTop + plotHeight)
      ..lineTo(points.first.dx, padTop + plotHeight)
      ..close();

    canvas.drawPath(
      areaPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0.015),
          ],
        ).createShader(Rect.fromLTWH(padLeft, padTop, plotWidth, plotHeight)),
    );

    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (count <= 8) {
      for (final point in points) {
        canvas.drawCircle(point, 2.5, Paint()..color = surfaceColor);
        canvas.drawCircle(
          point,
          2.5,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8,
        );
      }
    }

    final last = points.last;
    canvas.drawCircle(
      last,
      6.5,
      Paint()..color = color.withValues(alpha: 0.16),
    );
    canvas.drawCircle(last, 4.2, Paint()..color = surfaceColor);
    canvas.drawCircle(
      last,
      4.2,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );
    _paintValueBubble(canvas, size, last, values.last);

    if (axis.isNotEmpty) {
      for (var i = 0; i < axis.length; i++) {
        final fraction = axis.length == 1 ? 0.5 : i / (axis.length - 1);
        final x = padLeft + fraction * plotWidth;
        final label = TextPainter(
          text: TextSpan(
            text: axis[i],
            style: TextStyle(
              color: labelColor,
              fontSize: 10,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: textDirection,
          maxLines: 1,
        )..layout(maxWidth: math.max(24, plotWidth / axis.length));
        final dx = (x - label.width / 2)
            .clamp(padLeft, size.width - padRight - label.width)
            .toDouble();
        label.paint(canvas, Offset(dx, size.height - label.height - 2));
      }
    }
  }

  Path _smoothPath(List<Offset> points) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    if (points.length == 1) {
      return path;
    }
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final midpoint = (previous.dx + current.dx) / 2;
      path.cubicTo(
        midpoint,
        previous.dy,
        midpoint,
        current.dy,
        current.dx,
        current.dy,
      );
    }
    return path;
  }

  void _paintValueBubble(
    Canvas canvas,
    Size size,
    Offset anchor,
    double value,
  ) {
    final text = TextPainter(
      text: TextSpan(
        text: '$currency ${mobileDashboardCompactNumber(value)}',
        style: TextStyle(
          color: tooltipForeground,
          fontSize: 9.5,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: textDirection,
      maxLines: 1,
    )..layout();
    const horizontalPadding = 7.0;
    const verticalPadding = 4.0;
    final bubbleWidth = text.width + horizontalPadding * 2;
    final bubbleHeight = text.height + verticalPadding * 2;
    final left = (anchor.dx - bubbleWidth / 2)
        .clamp(50.0, size.width - bubbleWidth - 4.0)
        .toDouble();
    final preferredTop = anchor.dy - bubbleHeight - 10;
    final top = preferredTop < 2 ? anchor.dy + 10 : preferredTop;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, bubbleWidth, bubbleHeight),
      const Radius.circular(7),
    );
    canvas.drawRRect(rect, Paint()..color = tooltipBackground);
    text.paint(canvas, Offset(left + horizontalPadding, top + verticalPadding));
  }

  @override
  bool shouldRepaint(covariant _MobileDashboardTrendPainter oldDelegate) {
    return !listEquals(oldDelegate.values, values) ||
        oldDelegate.color != color ||
        !listEquals(oldDelegate.axis, axis) ||
        oldDelegate.currency != currency ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.surfaceColor != surfaceColor ||
        oldDelegate.labelColor != labelColor ||
        oldDelegate.valueLabelColor != valueLabelColor ||
        oldDelegate.tooltipBackground != tooltipBackground ||
        oldDelegate.tooltipForeground != tooltipForeground ||
        oldDelegate.fontFamily != fontFamily ||
        oldDelegate.textDirection != textDirection;
  }
}
