import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sahab/features/weather/data/models/weather_request_body.dart';
import 'package:sahab/features/weather/data/models/weather_response.dart';
import 'package:sahab/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(WeatherRequestBody(q: ''));
  });

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(mockRemoteDataSource);
  });

  group('getWeather', () {
    const tCityName = 'London';
    final tWeatherRequestBody = WeatherRequestBody(q: tCityName);
    final tWeatherResponse = WeatherResponse(
      location: LocationData(name: 'London', country: 'UK'),
      current: CurrentData(tempC: 15.0, humidity: 50),
    );

    test('should return success when data source is successful', () async {
      when(() => mockRemoteDataSource.getWeatherByCity(any()))
          .thenAnswer((_) async => tWeatherResponse);

      final result = await repository.getWeather(tWeatherRequestBody);

      expect(result, isA<Success<Weather>>());
    });
  });
}
