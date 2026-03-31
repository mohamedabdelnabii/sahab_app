import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import '../widgets/home/weather_body.dart';
import '../widgets/home/weather_loading.dart';

import 'package:sahab/core/helpers/extensions.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home-view';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getWeatherFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppDecorations.getMainGradient(context),
      child: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const WeatherLoading(),
              success: (weather) =>
                  WeatherBody(weather: weather),
              error: (error) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    error,
                    style: context.font16PrimaryMedium.copyWith(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
