import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sahab/core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/weather_request_body.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather_history_use_case.dart';
import '../../domain/usecases/get_weather_user_case.dart';
import '../../../../features/alerts/domain/services/alert_service.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;
  final GetWeatherHistoryUseCase _getWeatherHistoryUseCase;
  final AlertService _alertService;

  WeatherCubit(
    this._getWeatherUseCase,
    this._getWeatherHistoryUseCase,
    this._alertService,
  ) : super(const WeatherState.initial());

  Future<void> getWeather(String city) async {
    emit(const WeatherState.loading());

    final result = await _getWeatherUseCase(WeatherRequestBody(q: city));

    _handleResult(result);
  }

  Future<void> getWeatherFromPrefs() async {
    final city = await SharedPrefHelper.getHomeCity();
    await getWeather(city);
  }

  Future<void> setHomeCity(String city) async {
    await SharedPrefHelper.saveHomeCity(city);
    await getWeather(city);
  }

  Future<void> getHistoryWeather(String city, String dt) async {
    emit(const WeatherState.loading());

    final result = await _getWeatherHistoryUseCase(
      WeatherRequestBody(q: city, dt: dt),
    );

    _handleResult(result);
  }

  void _handleResult(ApiResult<Weather> result) {
    result.when(
      success: (data) {
        _alertService.checkWeatherAndGenerateAlerts(data);
        emit(WeatherState.success(data));
      },
      failure: (error) {
        log('❌ Error: ${error.getAllMessages()}');
        emit(WeatherState.error(error.getAllMessages()));
      },
    );
  }
}
