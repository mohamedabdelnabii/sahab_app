import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

class HourCard extends StatelessWidget {
  final HourInfo hour;
  final bool isCelsius;
  final bool isNow;

  const HourCard({super.key, required this.hour, required this.isNow, this.isCelsius = true});

  String _hourLabel() {
    if (isNow) return 'Now';
    final t = hour.time;
    if (t.length >= 16) return t.substring(11, 16); // "HH:mm"
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = context.onSurfaceColor;
    final inactiveColor = context.labelColor;

    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isNow
            ? activeColor.withValues(alpha: 0.15)
            : activeColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNow
              ? activeColor.withValues(alpha: 0.3)
              : activeColor.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _hourLabel(),
            style: context.font12Primary70Medium,
          ),
          Image.network(
            hour.condition.iconUrl,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.wb_cloudy_outlined,
              color: inactiveColor,
              size: 24,
            ),
          ),
          Text(
            '${(isCelsius ? hour.tempC : hour.tempF).round()}°',
            style: context.font14PrimaryMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
