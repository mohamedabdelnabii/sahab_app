import 'weather_condition.dart';

class HourInfo {
  final String time;
  final double tempC;
  final double tempF;
  final WeatherCondition condition;
  final double windKph;
  final int humidity;

  const HourInfo({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });
}
