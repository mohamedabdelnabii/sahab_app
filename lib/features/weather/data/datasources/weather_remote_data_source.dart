import 'package:sahab/features/weather/data/apis/weather_api_services.dart';
import 'package:sahab/core/networking/api_constants.dart';
import 'package:sahab/features/weather/data/models/weather_response.dart';
import 'package:sahab/features/weather/data/models/responses/location_suggestion.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> getWeatherByCity(String cityName);
  Future<WeatherResponse> getHistoryWeather(String cityName, String dt);
  Future<List<LocationSuggestionModel>> searchLocations(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApiService _weatherApiService;

  WeatherRemoteDataSourceImpl(this._weatherApiService);

  @override
  Future<WeatherResponse> getWeatherByCity(String cityName) async {
    return _weatherApiService.getWeather(ApiConstants.weatherApiKey, cityName);
  }

  @override
  Future<WeatherResponse> getHistoryWeather(String cityName, String dt) async {
    return _weatherApiService.getHistoryWeather(ApiConstants.weatherApiKey, cityName, dt);
  }

  @override
  Future<List<LocationSuggestionModel>> searchLocations(String query) async {
    return _weatherApiService.searchLocations(ApiConstants.weatherApiKey, query);
  }
}
