import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/data/models/weather_request_body.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetWeatherUseCase(this._weatherRepository);

  Future<ApiResult<Weather>> call(
      WeatherRequestBody weatherRequestBody,
      ) {
    return _weatherRepository.getWeather(weatherRequestBody);
  }
}