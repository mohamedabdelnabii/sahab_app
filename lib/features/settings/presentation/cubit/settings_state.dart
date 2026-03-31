part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool isCelsius,
    @Default('km/h') String windUnit,
    @Default('mbar') String pressureUnit,
    @Default('English') String language,
    @Default(true) bool isNotificationsEnabled,
    @Default(true) bool isDarkMode,
  }) = _SettingsState;
}
