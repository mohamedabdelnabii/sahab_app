import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/presentation/screens/forecast_detail_screen.dart';

import '../../../../../core/helpers/spacing.dart';

class ForecastDayCard extends StatelessWidget {
  final ForecastDayInfo day;
  final String cityName;
  final bool isCelsius;

  const ForecastDayCard({super.key, required this.day, required this.cityName, this.isCelsius = true});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(day.date);
    final dayName = DateFormat('EEEE').format(date);
    final isToday = day.date == DateTime.now().toString().substring(0, 10);
    
    final activeColor = context.onSurfaceColor;
    final inactiveColor = context.labelColor;

    return InkWell(
      onTap: () => context.push(
        ForecastDetailScreen.routeName,
        extra: {'day': day, 'cityName': cityName, 'isCelsius': isCelsius},
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: activeColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: activeColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            // Day Name
            Expanded(
              flex: 3,
              child: Text(
                isToday ? 'Today' : dayName,
                style: context.font14PrimarySemiBoldSpacing.copyWith(letterSpacing: 1),
              ),
            ),
            
            // Icon & Condition
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Image.network(
                    day.condition.iconUrl,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.wb_cloudy_outlined,
                      color: inactiveColor,
                      size: 20,
                    ),
                  ),
                  hGap(8),
                  Expanded(
                    child: Text(
                      day.condition.text,
                      style: context.font12Primary70Medium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            
            // Temps
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${(isCelsius ? day.maxtempC : day.maxtempF).round()}°',
                    style: context.font14PrimarySemiBoldSpacing.copyWith(letterSpacing: 0),
                  ),
                  hGap(8),
                  Text(
                    '${(isCelsius ? day.mintempC : day.mintempF).round()}°',
                    style: context.font14Primary70Spacing.copyWith(letterSpacing: 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
