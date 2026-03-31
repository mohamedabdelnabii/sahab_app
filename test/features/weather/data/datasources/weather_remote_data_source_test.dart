import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahab/core/networking/api_constants.dart';
import 'package:sahab/features/weather/data/apis/weather_api_services.dart';
import 'package:sahab/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sahab/features/weather/data/models/weather_request_body.dart';
import 'package:sahab/features/weather/data/models/weather_response.dart';

class MockWeatherApiService extends Mock implements WeatherApiService {}

void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockWeatherApiService mockApiService;

  setUpAll(() {
    registerFallbackValue(WeatherRequestBody(q: ''));
  });

  setUp(() {
    mockApiService = MockWeatherApiService();
    dataSource = WeatherRemoteDataSourceImpl(mockApiService);
  });

  group('getWeatherByCity', () {
    const tCityName = 'London';
    final tWeatherResponse = WeatherResponse(
      location: LocationData(name: 'London', country: 'UK'),
      current: CurrentData(tempC: 15.0, humidity: 50),
    );

    test('should call WeatherApiService.getWeather with correct parameters', () async {
      when(() => mockApiService.getWeather(any(), any()))
          .thenAnswer((_) async => tWeatherResponse);

      await dataSource.getWeatherByCity(tCityName);

      verify(() => mockApiService.getWeather(ApiConstants.weatherApiKey, tCityName)).called(1);
    });

    test('should return WeatherResponse when successful', () async {
      when(() => mockApiService.getWeather(any(), any()))
          .thenAnswer((_) async => tWeatherResponse);

      final result = await dataSource.getWeatherByCity(tCityName);

      expect(result, equals(tWeatherResponse));
    });
  });
}
