import 'package:sahab/core/networking/api_error_handler.dart';
import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/domain/entities/location_suggestion.dart';
import 'package:sahab/features/weather/domain/repositories/weather_repository.dart';

import '../models/weather_request_body.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<Weather>> getWeather(
    WeatherRequestBody weatherRequestBody,
  ) async {
    try {
      final response = await _remoteDataSource.getWeatherByCity(
        weatherRequestBody.q,
      );

      return ApiResult.success(response.toEntity());
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<Weather>> getHistoryWeather(
    WeatherRequestBody weatherRequestBody,
  ) async {
    try {
      final response = await _remoteDataSource.getHistoryWeather(
        weatherRequestBody.q,
        weatherRequestBody.dt!,
      );

      return ApiResult.success(response.toEntity());
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<LocationSuggestion>>> searchLocations(
    String query,
  ) async {
    try {
      final response = await _remoteDataSource.searchLocations(query);

      return ApiResult.success(response.map((e) => e.toEntity()).toList());
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
