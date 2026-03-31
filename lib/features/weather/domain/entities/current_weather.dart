import 'weather_condition.dart';

class CurrentWeather {
  final double tempC;
  final double tempF;
  final bool isDay;
  final WeatherCondition condition;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final int humidity;
  final double feelslikeC;
  final double feelslikeF;
  final double dewpointC;
  final double dewpointF;
  final double visKm;
  final double uv;

  const CurrentWeather({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.humidity,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.uv,
  });
}
