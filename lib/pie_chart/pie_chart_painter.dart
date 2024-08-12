import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart_project/pie_chart/pie_chart_segment.dart';

class PieChartPainter extends CustomPainter {
  final List<PieChartSegment> segments;
  final double animationValue;
  final int selectedIndex;
  final double selectedScale;

  PieChartPainter({
    required this.segments,
    required this.animationValue,
    required this.selectedIndex,
    required this.selectedScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -pi / 2;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    final total =
        segments.fold<double>(0, (sum, segment) => sum + segment.chartValue);

    final radius = min(size.width / 2, size.height / 2);
    const gapAngle = 10 * pi / 180;

    for (int i = 0; i < segments.length; i++) {
      final sweepAngle =
          (2 * pi * (segments[i].chartValue / total)) * animationValue;
      paint.color = segments[i].color;

      final isSelected = selectedIndex == i;
      final selectedRadius = isSelected ? radius * selectedScale : radius;

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: selectedRadius),
        startAngle,
        sweepAngle - gapAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
