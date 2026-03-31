import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/data/models/weather_request_body.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/domain/usecases/get_weather_user_case.dart';
import 'package:sahab/features/weather/domain/usecases/get_weather_history_use_case.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';

class MockGetWeatherUseCase extends Mock implements GetWeatherUseCase {}
class MockGetWeatherHistoryUseCase extends Mock implements GetWeatherHistoryUseCase {}

void main() {
  late WeatherCubit weatherCubit;
  late MockGetWeatherUseCase mockGetWeatherUseCase;
  late MockGetWeatherHistoryUseCase mockGetWeatherHistoryUseCase;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    mockGetWeatherHistoryUseCase = MockGetWeatherHistoryUseCase();
    weatherCubit = WeatherCubit(mockGetWeatherUseCase, mockGetWeatherHistoryUseCase);
  });

  tearDown(() {
    weatherCubit.close();
  });

  group('WeatherCubit', () {
    const tCity = 'London';
    final tWeather = Weather(
      location: const LocationInfo(name: 'London', region: '', country: '', lat: 0, lon: 0, tzId: '', localtime: ''),
      current: const CurrentWeather(
        tempC: 15.0,
        tempF: 59.0,
        isDay: true,
        condition: WeatherCondition(text: 'Sunny', iconUrl: '', code: 0),
        windKph: 0,
        windDir: '',
        pressureMb: 0,
        humidity: 0,
        feelslikeC: 15.0,
        feelslikeF: 59.0,
        dewpointC: 10.0,
        dewpointF: 50.0,
        visKm: 10.0,
        uv: 5.0,
      ),
      forecastDays: const [],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, success] when getWeather is successful',
      setUp: () {
        registerFallbackValue(WeatherRequestBody(q: tCity));
        when(() => mockGetWeatherUseCase(any()))
            .thenAnswer((_) async => ApiResult.success(tWeather));
      },
      build: () => weatherCubit,
      act: (cubit) => cubit.getWeather(tCity),
      expect: () => [
        const WeatherState.loading(),
        WeatherState.success(tWeather),
      ],
    );
  });
}
