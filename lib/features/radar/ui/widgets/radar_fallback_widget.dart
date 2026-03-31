import 'dart:math' as math;
import 'package:flutter/material.dart';

class RadarFallbackWidget extends StatelessWidget {
  final Animation<double> animation;
  final Color onSurface;
  final Color primary;

  const RadarFallbackWidget({
    super.key,
    required this.animation,
    required this.onSurface,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow Background
          Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  onSurface.withValues(alpha: 0.08),
                  primary.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Radar Visualization
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(320, 320),
                painter: RadarPainter(
                  angle: animation.value * 2 * math.pi,
                  gridColor: onSurface.withValues(alpha: 0.1),
                  sweepColor: onSurface.withValues(alpha: 0.25),
                  pointColor: primary.withValues(alpha: 0.6),
                ),
              );
            },
          ),

          // Center Point
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: onSurface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: primary, blurRadius: 10, spreadRadius: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadarPainter extends CustomPainter {
  final double angle;
  final Color gridColor;
  final Color sweepColor;
  final Color pointColor;

  RadarPainter({
    required this.angle,
    required this.gridColor,
    required this.sweepColor,
    required this.pointColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Concentric Circles
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius * 0.75, paintCircle);
    canvas.drawCircle(center, radius * 0.5, paintCircle);
    canvas.drawCircle(center, radius * 0.25, paintCircle);

    // Cross lines
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paintCircle,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paintCircle,
    );

    // Radar Sweep
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: angle - 0.8,
        endAngle: angle,
        colors: [
          Colors.transparent,
          sweepColor,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, radius, sweepPaint);
    canvas.restore();

    // Fake Random "Weather" Points
    final pointPaint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;

    _drawRandomPoint(canvas, center, radius * 0.5, 0.4, pointPaint);
    _drawRandomPoint(canvas, center, radius * 0.8, 1.2, pointPaint);
    _drawRandomPoint(canvas, center, radius * 0.3, 2.5, pointPaint);
  }

  void _drawRandomPoint(Canvas canvas, Offset center, double distance, double rad, Paint paint) {
    final x = center.dx + distance * math.cos(rad);
    final y = center.dy + distance * math.sin(rad);
    canvas.drawCircle(Offset(x, y), 4, paint);
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => oldDelegate.angle != angle;
}
