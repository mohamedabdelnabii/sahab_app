import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sahab/core/di/injection_container.dart';
import '../helpers/app_constants.dart';
import '../helpers/custom_bloc_observer.dart';
import '../helpers/shared_pref_helper.dart';
import 'package:sahab/features/alerts/domain/services/alert_service.dart';
import '../routes/app_router.dart';


class AppInitializer {
  static Future<void> initCore() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await setupGetIt();
    await gitIt<AlertService>().initNotifications();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Bloc.observer = CustomBlocObserver();

  }

  static Future<void> initRouter() async {
    final isNotFirstLogin = await SharedPrefHelper.getBool(
      AppConstants.prefsIsNotFirstLogin,
    );

    if (!gitIt.isRegistered<GoRouter>()) {
      gitIt.registerSingleton<GoRouter>(
        AppRouter.getRouter(isNotFirstLogin: isNotFirstLogin),
      );
    }
  }

}
