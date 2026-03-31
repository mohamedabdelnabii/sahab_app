import 'package:dio/dio.dart';
import 'package:sahab/core/networking/api_constants.dart';
import '../models/weather_response.dart';
import '../models/responses/location_suggestion.dart';

class WeatherApiService {
  final Dio _dio;

  WeatherApiService(this._dio);

  Future<WeatherResponse> getWeather(String apiKey, String city) async {
    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.forecastWeather}',
      queryParameters: {'key': apiKey, 'q': city, 'days': 7, 'aqi': 'no', 'alerts': 'no'},
    );

    return WeatherResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<WeatherResponse> getHistoryWeather(String apiKey, String city, String dt) async {
    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.historyWeather}',
      queryParameters: {'key': apiKey, 'q': city, 'dt': dt},
    );

    return WeatherResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<List<LocationSuggestionModel>> searchLocations(String apiKey, String query) async {
    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.searchLocations}',
      queryParameters: {'key': apiKey, 'q': query},
    );

    return (response.data as List)
        .map((e) => LocationSuggestionModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
