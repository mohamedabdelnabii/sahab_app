import 'dart:math' as math;
import 'package:flutter/material.dart';

class SunArcPainter extends CustomPainter {
  final Color lineColor;
  final Color sunColor;

  SunArcPainter({
    this.lineColor = Colors.white24,
    this.sunColor = const Color(0xFFFFCA28),
  });

  @override
  void paint(Canvas canvas, Size size) {
    try {
      if (size.width <= 0 || size.height <= 0) return;

      final paint = Paint()
        ..color = lineColor
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final dotPaint = Paint()
        ..color = sunColor
        ..style = PaintingStyle.fill;

      // Dashed arc
      final path = Path()
        ..addArc(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height),
            width: size.width,
            height: size.height * 1.6,
          ),
          -3.14,
          3.14,
        );

      // Draw dashed
      final dashPath = _dashPath(path, 4, 4);
      if (dashPath.getBounds().width > 0 && dashPath.getBounds().height > 0) {
        canvas.drawPath(dashPath, paint);
      }

      // Sun dot at ~65% along the arc
      final angle = -3.14 + 3.14 * 0.65;
      final radius = size.width / 2;
      final cx = size.width / 2 + radius * math.cos(angle);
      final cy = size.height + radius * 0.8 * math.sin(angle);
      canvas.drawCircle(Offset(cx, cy), 5, dotPaint);
    } catch (e) {
      // If any error occurs during painting, just don't paint anything
      // This prevents the app from crashing
    }
  }

  Path _dashPath(Path source, double dashLen, double gapLen) {
    try {
      final metrics = source.computeMetrics();
      if (metrics.isEmpty) return Path();
      final metric = metrics.first;
      final total = metric.length;
      if (total <= 0) return Path();
      final result = Path();
      double dist = 0;
      bool draw = true;
      while (dist < total) {
        final len = draw ? dashLen : gapLen;
        if (draw) {
          result.addPath(metric.extractPath(dist, dist + len), Offset.zero);
        }
        dist += len;
        draw = !draw;
      }
      return result;
    } catch (e) {
      // Return empty path if any error occurs
      return Path();
    }
  }

  @override
  bool shouldRepaint(covariant SunArcPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.sunColor != sunColor;
  }
}
