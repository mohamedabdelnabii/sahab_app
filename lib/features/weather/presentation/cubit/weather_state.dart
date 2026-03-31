part of 'weather_cubit.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = Loading;
  const factory WeatherState.success(Weather weather) = Success;
  const factory WeatherState.error(String error) = Error;
}