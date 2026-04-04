import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:sahab/core/cubit/connection/connection_cubit.dart';
import 'package:sahab/core/cubit/language/language_cubit.dart';
import 'package:sahab/core/di/injection_container.dart';
import 'package:sahab/core/theme/app_theme.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/widgets/no_connection_overlay.dart';

import 'package:sahab/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sahab/features/weather/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/features/alerts/presentation/cubit/alert_cubit.dart';

import 'package:sahab/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.transparent,
          ),
        );

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LanguageCubit()),
            BlocProvider(create: (_) => ConnectionCubit()),
            BlocProvider(create: (_) => gitIt<SettingsCubit>()),
            BlocProvider(create: (_) => gitIt<BottomNavBarCubit>()),
            BlocProvider(create: (_) => gitIt<WeatherCubit>()),
            BlocProvider(create: (_) => gitIt<AlertCubit>()),
          ],
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settingsState) {
                  final languageCubit = context.read<LanguageCubit>();

                  return Directionality(
                    textDirection: languageCubit.locale == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Stack(
                      children: [
                        MaterialApp.router(
                          debugShowCheckedModeBanner: false,
                          routerConfig: gitIt<GoRouter>(),
                          locale: Locale(languageCubit.locale),
                          supportedLocales: S.delegate.supportedLocales,
                          localizationsDelegates: const [
                            S.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          themeMode: settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                          theme: AppTheme.lightTheme(context),
                          darkTheme: AppTheme.darkTheme(context),
                        ),
                        const NoConnectionOverlay(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
