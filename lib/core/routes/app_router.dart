import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahab/core/routes/routes_list.dart';
import '../../features/weather/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../features/weather/presentation/screens/welcome/welcome_view.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static GoRouter? _router;

  static GoRouter getRouter({
    required bool isNotFirstLogin,
  }) {
    if (_router != null) return _router!;

    _router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: getInitialLocation(isNotFirstLogin),
      routes: RoutesList.all,
    );

    return _router!;
  }

  static String getInitialLocation(bool isNotFirstLogin) {
    debugPrint('isNotFirstLogin: $isNotFirstLogin');

    if (!isNotFirstLogin) {
      return WelcomeView.routeName;
    } else {
      return BottomNavBarView.routeName;
    }
  }
}