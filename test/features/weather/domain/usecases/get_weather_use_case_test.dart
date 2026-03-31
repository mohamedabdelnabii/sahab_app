import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/data/models/weather_request_body.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/domain/repositories/weather_repository.dart';
import 'package:sahab/features/weather/domain/usecases/get_weather_user_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherUseCase useCase;
  late MockWeatherRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(WeatherRequestBody(q: ''));
  });

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = GetWeatherUseCase(mockRepository);
  });

  group('call', () {
    const tCityName = 'London';
    final tWeatherRequestBody = WeatherRequestBody(q: tCityName);
    final tWeather = Weather(
    location: const LocationInfo(name: 'Tanta', region: '', country: '', lat: 0, lon: 0, tzId: '', localtime: ''),
    current: const CurrentWeather(
      tempC: 22.0,
      tempF: 71.6,
      isDay: true,
      condition: WeatherCondition(text: 'Sunny', iconUrl: '', code: 0),
      windKph: 0,
      windDir: '',
      pressureMb: 0,
      humidity: 0,
      feelslikeC: 22.0,
      feelslikeF: 71.6,
      dewpointC: 15.0,
      dewpointF: 59.0,
      visKm: 10.0,
      uv: 5.0,
    ),
    forecastDays: const [],
  );
    test('should call repository.getWeather', () async {
      when(() => mockRepository.getWeather(any()))
          .thenAnswer((_) async => ApiResult.success(tWeather));

    // act
    final result = await useCase(tWeatherRequestBody);

    // assert
    expect(result, isA<Success<Weather>>());
    verify(() => mockRepository.getWeather(tWeatherRequestBody)).called(1);
    });
  });
}
