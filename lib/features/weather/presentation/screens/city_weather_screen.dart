import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/core/di/injection_container.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/generated/l10n.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import '../widgets/home/weather_body.dart';
import '../widgets/home/weather_loading.dart';

class CityWeatherScreen extends StatelessWidget {
  final String cityName;

  const CityWeatherScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final onSurface = context.onSurfaceColor;

    return BlocProvider(
      create: (context) => gitIt<WeatherCubit>()..getWeather(cityName),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(cityName, style: context.font18PrimaryBold),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined, color: onSurface),
              tooltip: 'Set as Home',
              onPressed: () {
                context.read<WeatherCubit>().setHomeCity(cityName);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(s.homeCityUpdated(cityName)),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: AppDecorations.getMainGradient(context),
          child: SafeArea(
            bottom: false,
            child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const WeatherLoading(),
                  success: (weather) => WeatherBody(weather: weather, showTopBar: false),
                  error: (error) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        error,
                        style: context.font16PrimaryMedium.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
