import '../entities/user_settings.dart';

/// Repository contract for settings operations
abstract class SettingsRepository {
  /// Load user settings
  Future<UserSettings> loadSettings();
  
  /// Save temperature unit preference
  Future<void> saveTemperatureUnit(bool isCelsius);
  
  /// Save wind unit preference
  Future<void> saveWindUnit(String unit);
  
  /// Save pressure unit preference
  Future<void> savePressureUnit(String unit);
  
  /// Save language preference
  Future<void> saveLanguage(String language);
  
  /// Save notifications preference
  Future<void> saveNotificationsEnabled(bool enabled);
  
  /// Save theme preference
  Future<void> saveTheme(bool isDarkMode);
}
