import '../../../../core/networking/api_result.dart';
import '../../data/models/weather_request_body.dart';
import '../entities/weather.dart';
import '../entities/location_suggestion.dart';

abstract class WeatherRepository {
  Future<ApiResult<Weather>> getWeather(
      WeatherRequestBody weatherRequestBody,
      );
  Future<ApiResult<Weather>> getHistoryWeather(
      WeatherRequestBody weatherRequestBody,
      );
  Future<ApiResult<List<LocationSuggestion>>> searchLocations(
      String query,
      );
}
