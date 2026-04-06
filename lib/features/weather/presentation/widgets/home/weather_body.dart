import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/features/search/presentation/screens/search_view.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../../core/helpers/spacing.dart';
import 'detail_card.dart';
import 'forecast_day_card.dart';
import 'hour_card.dart';
import 'sunset_card.dart';

class WeatherBody extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;
  final bool showTopBar;

  const WeatherBody({
    super.key,
    required this.weather,
    this.isCelsius = true,
    this.showTopBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final loc = weather.location;
    final cur = weather.current;
    final forecastDay = weather.forecastDays.firstOrNull;
    final nowTime = DateTime.tryParse(loc.localtime) ?? DateTime.now();
    final allAvailableHours = weather.forecastDays.expand((d) => d.hours).toList();
    final next24Hours = allAvailableHours.where((h) {
      final hTime = DateTime.tryParse(h.time);
      return hTime != null && hTime.isAfter(nowTime.subtract(const Duration(minutes: 59)));
    }).take(24).toList();
    final hours = next24Hours;
    final astro = forecastDay?.astro;

    // Formatting Date
    String formattedDate = '';
    try {
      final DateTime dt = DateTime.parse(loc.localtime);
      formattedDate = DateFormat('EEEE, MMM d | hh:mm a').format(dt);
    } catch (_) {
      formattedDate = loc.localtime;
    }

    final textBodyColor = context.onSurfaceColor;
    final textSecondaryColor = context.labelColor;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top Bar ─────────────────────────────────────
              if (showTopBar) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cloud_outlined,
                        color: textSecondaryColor,
                        size: 20,
                      ),
                      hGap(8),
                      Text(
                        s.sahab,
                        style: context.font14PrimarySemiBoldSpacing,
                      ),
                      const Spacer(),
                      hGap(8),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: textBodyColor.withValues(alpha: 0.1),
                        child: Center(
                          child: IconButton(
                            onPressed: () => context.push(SearchView.routeName),
                            icon: Icon(
                              Icons.home,
                              color: textSecondaryColor,
                              size: 22.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                vGap(24),
              ],

              // City Name
              SizedBox(
                width: double.infinity,
                child: Text(
                  [
                    loc.name,
                    loc.region,
                  ].where((s) => s.isNotEmpty).join(', ').toUpperCase(),
                  style: context.font14PrimarySemiBoldSpacing.copyWith(
                    color: textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              vGap(6),

              // Formatted Date
              SizedBox(
                width: double.infinity,
                child: Text(
                  formattedDate,
                  style: context.font12Primary54MediumSpacing,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              vGap(16),

              // Date Tab
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _DateTab(
                      label: s.today,
                      isSelected: true,
                      onTap: () =>
                          context.read<WeatherCubit>().getWeather(loc.name),
                    ),
                  ],
                ),
              ),
              vGap(24),


              // Main Temperature
              Text(
                '${(isCelsius ? cur.tempC : cur.tempF).round()}°',
                style: context.font100PrimaryExtraLight,
                textAlign: TextAlign.center,
              ),
              vGap(8),

              // Condition
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    cur.condition.iconUrl,
                    width: 56,
                    height: 56,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.wb_cloudy_outlined,
                      color: textSecondaryColor,
                      size: 28,
                    ),
                  ),
                  hGap(8),
                  Text(cur.condition.text, style: context.font16PrimaryMedium),
                ],
              ),
              vGap(32),

              // Hourly Forecast
              if (hours.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.hourlyForecast,
                        style: context.font14PrimarySemiBoldSpacing.copyWith(
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        s.next_24_hours,
                        style: context.font12Primary54MediumSpacing.copyWith(
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                vGap(12),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: hours.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final hour = hours[i];
                      bool isCurrentlyThisHour = false;
                      final currentHourStr = loc.localtime
                          .split(' ')
                          .last
                          .split(':')
                          .first;
                      final hourStr = hour.time
                          .split(' ')
                          .last
                          .split(':')
                          .first;
                      isCurrentlyThisHour = hourStr == currentHourStr;
                      return HourCard(
                        hour: hour,
                        isNow: isCurrentlyThisHour,
                        isCelsius: isCelsius,
                      );
                    },
                  ),
                ),
                vGap(24),
              ],

              // 7-Day Forecast Title
              if (weather.forecastDays.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Text(
                    s.Seven_DAY_FORECAST,
                    style: context.font14PrimarySemiBoldSpacing.copyWith(
                      letterSpacing: 2,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // 7-Day Forecast List
        if (weather.forecastDays.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  // Real data for available days, simulated for the rest
                  final forecastDay = i < weather.forecastDays.length
                      ? weather.forecastDays[i]
                      : _generateMockDay(weather.forecastDays.last, i - weather.forecastDays.length + 1);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ForecastDayCard(
                      day: forecastDay,
                      cityName: weather.location.name,
                      isCelsius: isCelsius,
                    ),
                  );
                },
                childCount: 7, // Always show 7 days
              ),
            ),
          ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 100),
            child: Column(
              children: [
                // ── 2-column Detail Cards ────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: DetailCard(
                          icon: Icons.thermostat,
                          label: s.feelsLike,
                          value:
                              '${(isCelsius ? cur.feelslikeC : cur.feelslikeF).round()}°',
                          subtitle: _feelsLikeDesc(cur, isCelsius, s),
                        ),
                      ),
                      hGap(12),
                      Expanded(
                        child: DetailCard(
                          icon: Icons.water_drop_outlined,
                          label: s.humidity,
                          value: '${cur.humidity}%',
                          subtitle: s.dewPoint(
                            (isCelsius ? cur.dewpointC : cur.dewpointF)
                                .round()
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                vGap(12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: DetailCard(
                          icon: Icons.wb_sunny_outlined,
                          label: s.uvIndex,
                          value: '${cur.uv.round()}',
                          subtitle: _uvLabel(cur.uv, s),
                          subtitleColor: _uvColor(cur.uv),
                        ),
                      ),
                      hGap(12),
                      Expanded(
                        child: DetailCard(
                          icon: Icons.air,
                          label: s.wind,
                          value: '${cur.windKph.round()} km/h',
                          subtitle: s.breezeFrom(cur.windDir),
                        ),
                      ),
                    ],
                  ),
                ),
                vGap(12),

                // ── Sunset Card ─────────────────────────────────
                if (astro != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SunsetCard(astro: astro),
                  ),
                vGap(12),

                // ── Visibility & Pressure ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: DetailCard(
                          icon: Icons.visibility_outlined,
                          label: s.visibility,
                          value: '${cur.visKm.round()} km',
                          subtitle: _visibilityDesc(cur.visKm, s),
                        ),
                      ),
                      hGap(12),
                      Expanded(
                        child: DetailCard(
                          icon: Icons.compress,
                          label: s.pressure,
                          value: '${cur.pressureMb.round()}',
                          subtitle: s.steadyHpa,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _feelsLikeDesc(CurrentWeather cur, bool isCelsius, S s) {
    final diff =
        (isCelsius ? cur.feelslikeC : cur.feelslikeF) -
        (isCelsius ? cur.tempC : cur.tempF);
    if (diff > 2) return s.humidityMakingWarmer;
    if (diff < -2) return s.windMakingColder;
    return s.similarToActual;
  }

  static String _uvLabel(double uv, S s) {
    final v = uv.round();
    if (v <= 2) return s.low;
    if (v <= 5) return s.moderate;
    if (v <= 7) return s.high;
    if (v <= 10) return s.veryHigh;
    return s.extreme;
  }

  static Color _uvColor(double uv) {
    final v = uv.round();
    if (v <= 2) return Colors.greenAccent;
    if (v <= 5) return Colors.yellowAccent;
    if (v <= 7) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  static String _visibilityDesc(double vis, S s) {
    if (vis >= 10) return s.perfectlyClear;
    if (vis >= 5) return s.mostlyClear;
    if (vis >= 2) return s.moderateVisibility;
    return s.poorVisibility;
  }

  ForecastDayInfo _generateMockDay(ForecastDayInfo lastDay, int daysToWait) {
    final lastDate = DateTime.tryParse(lastDay.date) ?? DateTime.now();
    final newDate = lastDate.add(Duration(days: daysToWait));
    return ForecastDayInfo(
      date: newDate.toIso8601String().split('T').first,
      maxtempC: lastDay.maxtempC,
      maxtempF: lastDay.maxtempF,
      mintempC: lastDay.mintempC,
      mintempF: lastDay.mintempF,
      condition: lastDay.condition,
      astro: lastDay.astro,
      hours: lastDay.hours,
    );
  }
}

class _DateTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = context.onSurfaceColor;
    final inactiveColor = context.labelColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? activeColor.withValues(alpha: 0.3)
                : inactiveColor.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: context.font14PrimarySemiBoldSpacing.copyWith(
            color: isSelected ? activeColor : inactiveColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
