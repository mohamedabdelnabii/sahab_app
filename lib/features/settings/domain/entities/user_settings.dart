/// Entity representing user settings
class UserSettings {
  final bool isCelsius;
  final String windUnit;
  final String pressureUnit;
  final String language;
  final bool isNotificationsEnabled;
  final bool isDarkMode;

  const UserSettings({
    this.isCelsius = true,
    this.windUnit = 'km/h',
    this.pressureUnit = 'mbar',
    this.language = 'English',
    this.isNotificationsEnabled = true,
    this.isDarkMode = true,
  });

  UserSettings copyWith({
    bool? isCelsius,
    String? windUnit,
    String? pressureUnit,
    String? language,
    bool? isNotificationsEnabled,
    bool? isDarkMode,
  }) {
    return UserSettings(
      isCelsius: isCelsius ?? this.isCelsius,
      windUnit: windUnit ?? this.windUnit,
      pressureUnit: pressureUnit ?? this.pressureUnit,
      language: language ?? this.language,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
