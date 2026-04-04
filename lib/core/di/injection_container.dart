import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sahab/features/weather/data/apis/weather_api_services.dart';
import 'package:sahab/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sahab/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:sahab/features/weather/domain/repositories/weather_repository.dart';
import 'package:sahab/features/weather/domain/usecases/get_weather_history_use_case.dart';
import 'package:sahab/features/weather/domain/usecases/get_weather_user_case.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/features/search/data/api/search_api_service.dart';
import 'package:sahab/features/search/data/repositories/search_repository_impl.dart';
import 'package:sahab/features/search/domain/repositories/search_repository.dart';
import 'package:sahab/features/search/domain/usecases/search_history_usecases.dart';
import 'package:sahab/features/search/domain/usecases/search_locations_usecase.dart';
import 'package:sahab/features/search/presentation/cubit/search_cubit.dart';
import 'package:sahab/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:sahab/features/settings/domain/repositories/settings_repository.dart';
import 'package:sahab/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sahab/features/alerts/presentation/cubit/alert_cubit.dart';
import 'package:sahab/features/alerts/domain/services/alert_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sahab/features/radar/data/api/radar_api_service.dart';
import 'package:sahab/features/radar/data/datasource/radar_remote_data_source.dart';
import 'package:sahab/features/radar/data/repositories/radar_repository_impl.dart';
import 'package:sahab/features/radar/domain/repository/radar_repository.dart';
import 'package:sahab/features/radar/domain/usecases/fetch_radar_data_use_case.dart';
import 'package:sahab/features/radar/presentation/cubit/radar_cubit.dart';
import '../networking/dio_factory.dart';

final gitIt = GetIt.instance;

Future<void> setupGetIt() async {
  //*-------------------------------------- API --------------------------------------*
  Dio dio = await DioFactory.getDio();
  gitIt.registerLazySingleton<Dio>(() => dio);

  // Features - Weather
  // Api service
  gitIt.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(gitIt()),
  );
  final prefs = await SharedPreferences.getInstance();
  gitIt.registerLazySingleton<SharedPreferences>(() => prefs);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  gitIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(() => flutterLocalNotificationsPlugin);

  // Data sources
  gitIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(gitIt()),
  );
  // Alerts DI
  gitIt.registerLazySingleton<AlertService>(() => AlertService(gitIt(), gitIt()));

  // Use cases
  gitIt.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCase(gitIt()),
  );
  gitIt.registerLazySingleton<GetWeatherHistoryUseCase>(
    () => GetWeatherHistoryUseCase(gitIt()),
  );


  // Repository
  gitIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(gitIt()),
  );


  // Cubit
  gitIt.registerFactory<WeatherCubit>(() => WeatherCubit(gitIt(), gitIt(), gitIt()));
  gitIt.registerFactory<SearchCubit>(
    () => SearchCubit(gitIt(), gitIt(), gitIt()),
  );
  gitIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(gitIt<SettingsRepository>()),
  );
  gitIt.registerFactory<AlertCubit>(() => AlertCubit(gitIt()));

  //*-------------------------------------- Search Feature --------------------------------------*
  // API Service
  gitIt.registerLazySingleton<SearchApiService>(
    () => SearchApiService(gitIt()),
  );

  // Repository
  gitIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(gitIt()),
  );

  // Use Cases
  gitIt.registerLazySingleton<SearchLocationsUseCase>(
    () => SearchLocationsUseCase(gitIt()),
  );
  gitIt.registerLazySingleton<GetSearchHistoryUseCase>(
    () => GetSearchHistoryUseCase(gitIt()),
  );
  gitIt.registerLazySingleton<AddToSearchHistoryUseCase>(
    () => AddToSearchHistoryUseCase(gitIt()),
  );

  //*-------------------------------------- Settings Feature --------------------------------------*
  // Repository
  gitIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(),
  );

  // Use cases can be added here when needed

  //*-------------------------------------- Radar Feature --------------------------------------*
// API Service
  gitIt.registerLazySingleton<RadarApiService>(() => RadarApiService(gitIt()));

// Data Source
  gitIt.registerLazySingleton<RadarRemoteDataSource>(
        () => RadarRemoteDataSourceImpl(gitIt()),
  );

// Repository
  gitIt.registerLazySingleton<RadarRepository>(
        () => RadarRepositoryImpl(gitIt()),
  );

// Use Cases
  gitIt.registerLazySingleton<FetchRadarDataUseCase>(
        () => FetchRadarDataUseCase(gitIt()),
  );

// Cubit
  gitIt.registerFactory<RadarCubit>(() => RadarCubit(gitIt()));
}
