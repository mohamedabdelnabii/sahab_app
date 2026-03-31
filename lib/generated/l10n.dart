// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sahab`
  String get appTitle {
    return Intl.message('Sahab', name: 'appTitle', desc: '', args: []);
  }

  /// `Welcome to `
  String get welcomeTo {
    return Intl.message('Welcome to ', name: 'welcomeTo', desc: '', args: []);
  }

  /// `Experience the atmosphere in a\nwhole new light`
  String get experienceAtmosphere {
    return Intl.message(
      'Experience the atmosphere in a\nwhole new light',
      name: 'experienceAtmosphere',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `REAL-TIME`
  String get realtime {
    return Intl.message('REAL-TIME', name: 'realtime', desc: '', args: []);
  }

  /// `PRECISE`
  String get precise {
    return Intl.message('PRECISE', name: 'precise', desc: '', args: []);
  }

  /// `GLOBAL`
  String get global {
    return Intl.message('GLOBAL', name: 'global', desc: '', args: []);
  }

  /// `Detailed Hourly Forecast`
  String get detailedHourlyForecast {
    return Intl.message(
      'Detailed Hourly Forecast',
      name: 'detailedHourlyForecast',
      desc: '',
      args: [],
    );
  }

  /// `Get accurate weather updates for every hour of the day.`
  String get detailedHourlyForecastDesc {
    return Intl.message(
      'Get accurate weather updates for every hour of the day.',
      name: 'detailedHourlyForecastDesc',
      desc: '',
      args: [],
    );
  }

  /// `Real-Time Radar`
  String get realTimeRadar {
    return Intl.message(
      'Real-Time Radar',
      name: 'realTimeRadar',
      desc: '',
      args: [],
    );
  }

  /// `Track storms and precipitation with our advanced interactive radar.`
  String get realTimeRadarDesc {
    return Intl.message(
      'Track storms and precipitation with our advanced interactive radar.',
      name: 'realTimeRadarDesc',
      desc: '',
      args: [],
    );
  }

  /// `Severe Weather Alerts`
  String get severeWeatherAlerts {
    return Intl.message(
      'Severe Weather Alerts',
      name: 'severeWeatherAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Stay safe with instant notifications about extreme weather conditions.`
  String get severeWeatherAlertsDesc {
    return Intl.message(
      'Stay safe with instant notifications about extreme weather conditions.',
      name: 'severeWeatherAlertsDesc',
      desc: '',
      args: [],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message('SKIP', name: 'skip', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Weather Alerts`
  String get weatherAlerts {
    return Intl.message(
      'Weather Alerts',
      name: 'weatherAlerts',
      desc: '',
      args: [],
    );
  }

  /// `No Active Alerts`
  String get noActiveAlerts {
    return Intl.message(
      'No Active Alerts',
      name: 'noActiveAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch alerts`
  String get failedToFetchAlerts {
    return Intl.message(
      'Failed to fetch alerts',
      name: 'failedToFetchAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Sunrise`
  String get sunrise {
    return Intl.message('Sunrise', name: 'sunrise', desc: '', args: []);
  }

  /// `Sunset`
  String get sunset {
    return Intl.message('Sunset', name: 'sunset', desc: '', args: []);
  }

  /// `HOURLY FORECAST`
  String get hourlyForecast {
    return Intl.message(
      'HOURLY FORECAST',
      name: 'hourlyForecast',
      desc: '',
      args: [],
    );
  }

  /// `Breeze from {direction}.`
  String breezeFrom(Object direction) {
    return Intl.message(
      'Breeze from $direction.',
      name: 'breezeFrom',
      desc: '',
      args: [direction],
    );
  }

  /// `Steady hPa.`
  String get steadyHpa {
    return Intl.message('Steady hPa.', name: 'steadyHpa', desc: '', args: []);
  }

  /// `Sunrise: {time}`
  String sunriseTime(Object time) {
    return Intl.message(
      'Sunrise: $time',
      name: 'sunriseTime',
      desc: '',
      args: [time],
    );
  }

  /// `Sunset: {time}`
  String sunsetTime(Object time) {
    return Intl.message(
      'Sunset: $time',
      name: 'sunsetTime',
      desc: '',
      args: [time],
    );
  }

  /// `SAHAB`
  String get sahab {
    return Intl.message('SAHAB', name: 'sahab', desc: '', args: []);
  }

  /// `FEELS LIKE`
  String get feelsLike {
    return Intl.message('FEELS LIKE', name: 'feelsLike', desc: '', args: []);
  }

  /// `HUMIDITY`
  String get humidity {
    return Intl.message('HUMIDITY', name: 'humidity', desc: '', args: []);
  }

  /// `UV INDEX`
  String get uvIndex {
    return Intl.message('UV INDEX', name: 'uvIndex', desc: '', args: []);
  }

  /// `WIND`
  String get wind {
    return Intl.message('WIND', name: 'wind', desc: '', args: []);
  }

  /// `VISIBILITY`
  String get visibility {
    return Intl.message('VISIBILITY', name: 'visibility', desc: '', args: []);
  }

  /// `PRESSURE`
  String get pressure {
    return Intl.message('PRESSURE', name: 'pressure', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Search for a city or airport`
  String get searchForCityOrAirport {
    return Intl.message(
      'Search for a city or airport',
      name: 'searchForCityOrAirport',
      desc: '',
      args: [],
    );
  }

  /// `Home city updated to {cityName}`
  String homeCityUpdated(Object cityName) {
    return Intl.message(
      'Home city updated to $cityName',
      name: 'homeCityUpdated',
      desc: '',
      args: [cityName],
    );
  }

  /// `Humidity making it feel warmer.`
  String get humidityMakingWarmer {
    return Intl.message(
      'Humidity making it feel warmer.',
      name: 'humidityMakingWarmer',
      desc: '',
      args: [],
    );
  }

  /// `Wind making it feel colder.`
  String get windMakingColder {
    return Intl.message(
      'Wind making it feel colder.',
      name: 'windMakingColder',
      desc: '',
      args: [],
    );
  }

  /// `Similar to the actual temperature.`
  String get similarToActual {
    return Intl.message(
      'Similar to the actual temperature.',
      name: 'similarToActual',
      desc: '',
      args: [],
    );
  }

  /// `The dew point is {temp}° right now.`
  String dewPoint(Object temp) {
    return Intl.message(
      'The dew point is $temp° right now.',
      name: 'dewPoint',
      desc: '',
      args: [temp],
    );
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Moderate`
  String get moderate {
    return Intl.message('Moderate', name: 'moderate', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Very High`
  String get veryHigh {
    return Intl.message('Very High', name: 'veryHigh', desc: '', args: []);
  }

  /// `Extreme`
  String get extreme {
    return Intl.message('Extreme', name: 'extreme', desc: '', args: []);
  }

  /// `Perfectly clear view.`
  String get perfectlyClear {
    return Intl.message(
      'Perfectly clear view.',
      name: 'perfectlyClear',
      desc: '',
      args: [],
    );
  }

  /// `Mostly clear view.`
  String get mostlyClear {
    return Intl.message(
      'Mostly clear view.',
      name: 'mostlyClear',
      desc: '',
      args: [],
    );
  }

  /// `Moderate visibility.`
  String get moderateVisibility {
    return Intl.message(
      'Moderate visibility.',
      name: 'moderateVisibility',
      desc: '',
      args: [],
    );
  }

  /// `Poor visibility.`
  String get poorVisibility {
    return Intl.message(
      'Poor visibility.',
      name: 'poorVisibility',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Home City`
  String get homeCity {
    return Intl.message('Home City', name: 'homeCity', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Units`
  String get units {
    return Intl.message('Units', name: 'units', desc: '', args: []);
  }

  /// `Use Fahrenheit`
  String get useFahrenheit {
    return Intl.message(
      'Use Fahrenheit',
      name: 'useFahrenheit',
      desc: '',
      args: [],
    );
  }

  /// `Celsius (°C)`
  String get celsius {
    return Intl.message('Celsius (°C)', name: 'celsius', desc: '', args: []);
  }

  /// `Fahrenheit (°F)`
  String get fahrenheit {
    return Intl.message(
      'Fahrenheit (°F)',
      name: 'fahrenheit',
      desc: '',
      args: [],
    );
  }

  /// `Wind Speed`
  String get windSpeed {
    return Intl.message('Wind Speed', name: 'windSpeed', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message('Enabled', name: 'enabled', desc: '', args: []);
  }

  /// `Disabled`
  String get disabled {
    return Intl.message('Disabled', name: 'disabled', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `LANGUAGE`
  String get languageTitle {
    return Intl.message('LANGUAGE', name: 'languageTitle', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `PRIVACY POLICY`
  String get privacyTitle {
    return Intl.message(
      'PRIVACY POLICY',
      name: 'privacyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: March 28, 2026\n\nAt Sahab Weather, we prioritize your privacy. This Privacy Policy describes how your personal information is collected, used, and shared when you use our mobile application.\n\n1. Information Collection\nWe collect minimal information required to provide weather forecasts, primarily your geographical location (if permitted) to show local weather data.\n\n2. How We Use Your Information\nLocation data is used solely to fetch weather data for your current city. We do not store your movement history or share your location with third parties for advertising.\n\n3. Third-Party Services\nWe use WeatherAPI to fetch weather information. Please refer to their privacy policy for details on how they handle data.\n\n4. Security\nWe implement industry-standard measures to protect any data processed by the app.\n\n5. Changes to This Policy\nWe may update this policy from time to time. We will notify you of any changes by posting the new policy on this page.`
  String get privacyContent {
    return Intl.message(
      'Last updated: March 28, 2026\n\nAt Sahab Weather, we prioritize your privacy. This Privacy Policy describes how your personal information is collected, used, and shared when you use our mobile application.\n\n1. Information Collection\nWe collect minimal information required to provide weather forecasts, primarily your geographical location (if permitted) to show local weather data.\n\n2. How We Use Your Information\nLocation data is used solely to fetch weather data for your current city. We do not store your movement history or share your location with third parties for advertising.\n\n3. Third-Party Services\nWe use WeatherAPI to fetch weather information. Please refer to their privacy policy for details on how they handle data.\n\n4. Security\nWe implement industry-standard measures to protect any data processed by the app.\n\n5. Changes to This Policy\nWe may update this policy from time to time. We will notify you of any changes by posting the new policy on this page.',
      name: 'privacyContent',
      desc: '',
      args: [],
    );
  }

  /// `© 2026 Sahab Weather Team`
  String get copyright {
    return Intl.message(
      '© 2026 Sahab Weather Team',
      name: 'copyright',
      desc: '',
      args: [],
    );
  }

  /// `SATELLITE RADAR`
  String get satelliteRadar {
    return Intl.message(
      'SATELLITE RADAR',
      name: 'satelliteRadar',
      desc: '',
      args: [],
    );
  }

  /// `Clouds`
  String get clouds {
    return Intl.message('Clouds', name: 'clouds', desc: '', args: []);
  }

  /// `Temp`
  String get temp {
    return Intl.message('Temp', name: 'temp', desc: '', args: []);
  }

  /// `Rain`
  String get rain {
    return Intl.message('Rain', name: 'rain', desc: '', args: []);
  }

  /// `Live Prediction : `
  String get livePrediction {
    return Intl.message(
      'Live Prediction : ',
      name: 'livePrediction',
      desc: '',
      args: [],
    );
  }

  /// `Past Data : `
  String get pastData {
    return Intl.message('Past Data : ', name: 'pastData', desc: '', args: []);
  }

  /// `Next 24 Hours`
  String get next_24_hours {
    return Intl.message(
      'Next 24 Hours',
      name: 'next_24_hours',
      desc: '',
      args: [],
    );
  }

  /// `Seven DAYS FORECAST`
  String get Seven_DAY_FORECAST {
    return Intl.message(
      'Seven DAYS FORECAST',
      name: 'Seven_DAY_FORECAST',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `{count} min ago`
  String minutesAgo(Object count) {
    return Intl.message(
      '$count min ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} hr ago`
  String hoursAgo(Object count) {
    return Intl.message(
      '$count hr ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} days ago`
  String daysAgo(Object count) {
    return Intl.message(
      '$count days ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `Failed to load radar data`
  String get failedToLoadRadarData {
    return Intl.message(
      'Failed to load radar data',
      name: 'failedToLoadRadarData',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
