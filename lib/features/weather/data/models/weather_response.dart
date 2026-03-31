import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

export 'responses/astro_data.dart';
export 'responses/condition_data.dart';
import 'responses/current_data.dart';
export 'responses/current_data.dart';
import 'responses/forecast_data.dart';
export 'responses/forecast_data.dart';
export 'responses/forecast_day.dart';
export 'responses/hour_data.dart';
import 'responses/location_data.dart';
export 'responses/location_data.dart';

part 'weather_response.g.dart';

@JsonSerializable(createToJson: false)
class WeatherResponse {
  final LocationData? location;
  final CurrentData? current;
  final ForecastData? forecast;

  WeatherResponse({this.location, this.current, this.forecast});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Weather toEntity() {
    return Weather(
      location:
          location?.toEntity() ??
          const LocationInfo(
            name: '',
            region: '',
            country: '',
            lat: 0,
            lon: 0,
            tzId: '',
            localtime: '',
          ),
      current:
          current?.toEntity() ??
          const CurrentWeather(
            tempC: 0,
            tempF: 0,
            isDay: true,
            condition: WeatherCondition(text: '', iconUrl: '', code: 0),
            windKph: 0,
            windDir: '',
            pressureMb: 0,
            humidity: 0,
            feelslikeC: 0,
            feelslikeF: 0,
            dewpointC: 0,
            dewpointF: 0,
            visKm: 0,
            uv: 0,
          ),
      forecastDays:
          forecast?.forecastday?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
