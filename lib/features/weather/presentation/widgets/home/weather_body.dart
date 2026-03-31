import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/helpers/extensions.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:sahab/features/search/presentation/screens/search_view.dart';
import 'package:sahab/generated/l10n.dart';

import 'detail_card.dart';
import 'forecast_day_card.dart';
import 'hour_card.dart';
import 'sunset_card.dart';

class WeatherBody extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;

  const WeatherBody({super.key, required this.weather, this.isCelsius = true});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final loc = weather.location;
    final cur = weather.current;
    final forecastDay = weather.forecastDays.firstOrNull;
    final hours = forecastDay?.hours ?? [];
    final astro = forecastDay?.astro;

    // Formatting Date
    String formattedDate = '';
    try {
      final DateTime dt = DateTime.parse(loc.localtime);
      formattedDate = DateFormat('EEEE, MMM d | hh:mm a').format(dt);
    } catch (_) {
      formattedDate = loc.localtime;
    }

    final String weatherDateOnly = loc.localtime.split(' ').first;
    final bool isHistoryView = weatherDateOnly == '2024-03-24';

    final textBodyColor = context.onSurfaceColor;
    final textSecondaryColor = context.labelColor;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top Bar ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Icon(Icons.cloud_outlined, color: textSecondaryColor, size: 20),
                    const SizedBox(width: 8),
                    Text(s.sahab, style: context.font14PrimarySemiBoldSpacing),
                    const Spacer(),
                    IconButton(
                      onPressed: () => context.push(SearchView.routeName),
                      icon: Icon(Icons.search, color: textSecondaryColor, size: 22),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: textBodyColor.withValues(alpha: 0.1),
                      child: Icon(Icons.person, color: textSecondaryColor, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── City Name ──────────────────── ABOVE اليوم
              SizedBox(
                width: double.infinity,
                child: Text(
                  [loc.name, loc.region].where((s) => s.isNotEmpty).join(', ').toUpperCase(),
                  style: context.font14PrimarySemiBoldSpacing.copyWith(
                    color: textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 6),

              // ── Formatted Date ──────────────── ABOVE اليوم
              SizedBox(
                width: double.infinity,
                child: Text(
                  formattedDate,
                  style: context.font12Primary54MediumSpacing,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),

              // ── Date Tab (اليوم) ─────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _DateTab(
                      label: s.today,
                      isSelected: !isHistoryView,
                      onTap: () => context.read<WeatherCubit>().getWeather('Tanta'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Historical Badge ───────────────────────────────
              if (isHistoryView)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.orangeAccent.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.history, color: Colors.orangeAccent, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'HISTORICAL DATA',
                          style: context.font12Primary54MediumSpacing.copyWith(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Main Temperature ─────────────────────────────
              Text(
                '${(isCelsius ? cur.tempC : cur.tempF).round()}°',
                style: context.font100PrimaryExtraLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // ── Condition ────────────────────────────────────
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
                  const SizedBox(width: 8),
                  Text(cur.condition.text, style: context.font16PrimaryMedium),
                ],
              ),
              const SizedBox(height: 32),

              // ── Hourly Forecast ──────────────────────────────
              if (hours.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.hourlyForecast,
                        style: context.font14PrimarySemiBoldSpacing.copyWith(letterSpacing: 1),
                      ),
                      Text(
                        s.next_24_hours,
                        style: context.font12Primary54MediumSpacing.copyWith(letterSpacing: 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: hours.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final hour = hours[i];
                      bool isCurrentlyThisHour = false;
                      if (!isHistoryView) {
                        final currentHourStr = loc.localtime.split(' ').last.split(':').first;
                        final hourStr = hour.time.split(' ').last.split(':').first;
                        isCurrentlyThisHour = hourStr == currentHourStr;
                      }
                      return HourCard(
                        hour: hour,
                        isNow: isCurrentlyThisHour,
                        isCelsius: isCelsius,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // ── 7-Day Forecast Title ──────────────────────────────
              if (weather.forecastDays.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    s.Seven_DAY_FORECAST,
                    style: context.font14PrimarySemiBoldSpacing.copyWith(letterSpacing: 2),
                  ),
                ),
            ],
          ),
        ),

        // ── 7-Day Forecast List ──────────────────────────────
        if (weather.forecastDays.length > 1)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ForecastDayCard(
                    day: weather.forecastDays[i],
                    cityName: weather.location.name,
                    isCelsius: isCelsius,
                  ),
                ),
                childCount: weather.forecastDays.length,
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
                          value: '${(isCelsius ? cur.feelslikeC : cur.feelslikeF).round()}°',
                          subtitle: _feelsLikeDesc(cur, isCelsius, s),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DetailCard(
                          icon: Icons.water_drop_outlined,
                          label: s.humidity,
                          value: '${cur.humidity}%',
                          subtitle: s.dewPoint(
                            (isCelsius ? cur.dewpointC : cur.dewpointF).round().toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

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
                      const SizedBox(width: 12),
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
                const SizedBox(height: 12),

                // ── Sunset Card ─────────────────────────────────
                if (astro != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SunsetCard(astro: astro),
                  ),
                const SizedBox(height: 12),

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
                      const SizedBox(width: 12),
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
          color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
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