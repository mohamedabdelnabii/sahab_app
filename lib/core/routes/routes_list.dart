import 'package:go_router/go_router.dart';
import 'package:sahab/features/search/presentation/screens/search_view.dart';
import 'package:sahab/features/settings/presentation/screens/settings_view.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/presentation/screens/forecast_detail_screen.dart';
import 'package:sahab/features/weather/presentation/screens/home_view.dart';
import 'package:sahab/features/weather/presentation/screens/city_weather_screen.dart';
import 'package:sahab/features/settings/presentation/screens/language_view.dart';
import 'package:sahab/features/settings/presentation/screens/privacy_view.dart';
import 'package:sahab/features/alerts/presentation/screens/alerts_screen.dart';

import '../../features/weather/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../features/weather/presentation/screens/welcome/welcome_view.dart';
class RoutesList {
  static final List<RouteBase> all = [
    GoRoute(
      path: WelcomeView.routeName,
      builder: (context, state) => const WelcomeView(),
    ),
    GoRoute(
      path: BottomNavBarView.routeName,
      builder: (context, state) => const BottomNavBarView(),
    ),
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: ForecastDetailScreen.routeName,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final day = extra['day'] as ForecastDayInfo;
        final cityName = extra['cityName'] as String;
        final isCelsius = extra['isCelsius'] as bool? ?? true;
        return ForecastDetailScreen(day: day, cityName: cityName, isCelsius: isCelsius);
      },
    ),
    GoRoute(path: AlertsScreen.routeName,
      builder: (context, state) => const AlertsScreen(),
    ),
    GoRoute(path: SettingsView.routeName,
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(path: SearchView.routeName,
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(path: LanguageView.routeName,
      builder: (context, state) => const LanguageView(),
    ),
    GoRoute(path: PrivacyView.routeName,
      builder: (context, state) => const PrivacyView(),
    ),
    GoRoute(
      path: '/city-weather',
      builder: (context, state) {
        final cityName = state.extra as String;
        return CityWeatherScreen(cityName: cityName);
      },
    ),
  ];
}