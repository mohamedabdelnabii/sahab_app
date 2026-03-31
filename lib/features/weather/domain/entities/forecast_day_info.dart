import 'astro_info.dart';
import 'hour_info.dart';
import 'weather_condition.dart';

class ForecastDayInfo {
  final String date;
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final WeatherCondition condition;
  final AstroInfo astro;
  final List<HourInfo> hours;

  const ForecastDayInfo({
    required this.date,
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.condition,
    required this.astro,
    required this.hours,
  });
}
