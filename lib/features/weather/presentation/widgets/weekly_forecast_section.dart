import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/presentation/widgets/glass_card.dart';

import '../../../../core/helpers/spacing.dart';

class DailyForecast {
  final String day;
  final double minTemp;
  final double maxTemp;

  const DailyForecast({
    required this.day,
    required this.minTemp,
    required this.maxTemp,
  });
}

class WeeklyForecastSection extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  const WeeklyForecastSection({super.key, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    final labelColor = context.labelColor;
    final onSurface = context.onSurfaceColor;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 18,
                color: labelColor,
              ),
              hGap(8),
              Text(
                '7-DAY FORECAST',
                style: context.font12Primary54MediumSpacing,
              ),
            ],
          ),
          Divider(color: onSurface.withValues(alpha: 0.1)),
          Column(
            children: [
              for (int index = 0; index < dailyForecast.length; index++) ...[
                if (index > 0) Divider(color: onSurface.withValues(alpha: 0.1), height: 20),
                Builder(
                  builder: (context) {
                    final day = dailyForecast[index];
                    return Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            index == 0 ? 'Today' : day.day,
                            style: context.font14PrimaryMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.wb_sunny, color: Colors.amber, size: 24),
                        const Spacer(),
                        Text(
                          '${day.minTemp.round()}°',
                          style: context.font16PrimaryMedium.copyWith(
                            color: labelColor,
                          ),
                        ),
                        hGap(10),
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        hGap(10),
                        Text(
                          '${day.maxTemp.round()}°',
                          style: context.font16PrimaryMedium,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
