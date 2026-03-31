import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'sun_arc_painter.dart';

class SunsetCard extends StatelessWidget {
  final AstroInfo astro;

  const SunsetCard({super.key, required this.astro});

  @override
  Widget build(BuildContext context) {
    final textSecondary = context.labelColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.getGlassDecoration(context),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_twilight, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text(
                      'SUNSET',
                      style: context.font12Primary54MediumSpacing,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  astro.sunset,
                  textDirection: TextDirection.ltr,
                  style: context.font24PrimaryLight,
                ),
                const SizedBox(height: 4),
                Text(
                  'Sunrise: ${astro.sunrise}',
                  textDirection: TextDirection.ltr,
                  style: context.font12Primary60Regular,
                ),
              ],
            ),
          ),
          // Sun arc visualization
          SizedBox(
            width: 80,
            height: 60,
            child: CustomPaint(
              painter: SunArcPainter(
                lineColor: textSecondary.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
