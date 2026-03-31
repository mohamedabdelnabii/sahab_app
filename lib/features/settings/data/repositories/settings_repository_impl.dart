import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../../../core/helpers/shared_pref_helper.dart';

/// Implementation of SettingsRepository using SharedPreferences
class SettingsRepositoryImpl implements SettingsRepository {
  static const String _isCelsiusKey = 'is_celsius';
  static const String _windUnitKey = 'wind_unit';
  static const String _pressureUnitKey = 'pressure_unit';
  static const String _languageKey = 'language';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _isDarkModeKey = 'is_dark_mode';

  @override
  Future<UserSettings> loadSettings() async {
    final isCelsius = await SharedPrefHelper.getBool(_isCelsiusKey);
    final windUnit = await SharedPrefHelper.getString(_windUnitKey);
    final pressureUnit = await SharedPrefHelper.getString(_pressureUnitKey);
    final language = await SharedPrefHelper.getString(_languageKey);
    final isNotificationsEnabled = await SharedPrefHelper.getBool(_notificationsKey);
    final isDarkMode = await SharedPrefHelper.getBool(_isDarkModeKey);

    return UserSettings(
      isCelsius: await SharedPrefHelper.containsKey(_isCelsiusKey) ? isCelsius : true,
      windUnit: windUnit.isNotEmpty ? windUnit : 'km/h',
      pressureUnit: pressureUnit.isNotEmpty ? pressureUnit : 'mbar',
      language: language.isNotEmpty ? language : 'English',
      isNotificationsEnabled: await SharedPrefHelper.containsKey(_notificationsKey) ? isNotificationsEnabled : true,
      isDarkMode: await SharedPrefHelper.containsKey(_isDarkModeKey) ? isDarkMode : true,
    );
  }

  @override
  Future<void> saveTemperatureUnit(bool isCelsius) async {
    await SharedPrefHelper.setData(_isCelsiusKey, isCelsius);
  }

  @override
  Future<void> saveWindUnit(String unit) async {
    await SharedPrefHelper.setData(_windUnitKey, unit);
  }

  @override
  Future<void> savePressureUnit(String unit) async {
    await SharedPrefHelper.setData(_pressureUnitKey, unit);
  }

  @override
  Future<void> saveLanguage(String language) async {
    await SharedPrefHelper.setData(_languageKey, language);
  }

  @override
  Future<void> saveNotificationsEnabled(bool enabled) async {
    await SharedPrefHelper.setData(_notificationsKey, enabled);
  }

  @override
  Future<void> saveTheme(bool isDarkMode) async {
    await SharedPrefHelper.setData(_isDarkModeKey, isDarkMode);
  }
}
