import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final settings = await _repository.loadSettings();
    emit(
      state.copyWith(
        isCelsius: settings.isCelsius,
        windUnit: settings.windUnit,
        pressureUnit: settings.pressureUnit,
        language: settings.language,
        isNotificationsEnabled: settings.isNotificationsEnabled,
        isDarkMode: settings.isDarkMode,
      ),
    );
  }

  void toggleTemperatureUnit() {
    final newValue = !state.isCelsius;
    emit(state.copyWith(isCelsius: newValue));
    _repository.saveTemperatureUnit(newValue);
  }

  void updateWindUnit(String unit) {
    emit(state.copyWith(windUnit: unit));
    _repository.saveWindUnit(unit);
  }

  void updatePressureUnit(String unit) {
    emit(state.copyWith(pressureUnit: unit));
    _repository.savePressureUnit(unit);
  }

  void updateLanguage(String lang) {
    emit(state.copyWith(language: lang));
    _repository.saveLanguage(lang);
  }

  void toggleNotifications() {
    final newValue = !state.isNotificationsEnabled;
    emit(state.copyWith(isNotificationsEnabled: newValue));
    _repository.saveNotificationsEnabled(newValue);
  }

  void toggleTheme() {
    final newValue = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: newValue));
    _repository.saveTheme(newValue);
  }
}
