export 'astro_info.dart';
import 'current_weather.dart';
export 'current_weather.dart';
import 'forecast_day_info.dart';
export 'forecast_day_info.dart';
export 'hour_info.dart';
import 'location_info.dart';
export 'location_info.dart';
export 'weather_condition.dart';

class Weather {
  final LocationInfo location;
  final CurrentWeather current;
  final List<ForecastDayInfo> forecastDays;

  const Weather({
    required this.location,
    required this.current,
    required this.forecastDays,
  });
}
