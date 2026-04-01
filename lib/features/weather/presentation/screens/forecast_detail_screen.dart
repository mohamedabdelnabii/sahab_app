import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/theme/app_colors.dart';
import 'package:sahab/core/theme/app_decorations.dart';
import 'package:sahab/core/theme/app_text_styles.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../widgets/home/detail_card.dart';
import '../widgets/home/hour_card.dart';
import '../widgets/home/sunset_card.dart';

class ForecastDetailScreen extends StatelessWidget {
  static const String routeName = '/forecast-detail';

  final ForecastDayInfo day;
  final String cityName;
  final bool isCelsius;

  const ForecastDetailScreen({
    super.key,
    required this.day,
    required this.cityName,
    this.isCelsius = true,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final date = DateTime.tryParse(day.date) ?? DateTime.now();
    final dayName = DateFormat('EEEE, MMM d').format(date);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.onSurface(context),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          cityName.toUpperCase(),
          style: AppTextStyles.font14PrimarySemiBoldSpacing(context),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.getMainGradient(context),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        dayName,
                        style: AppTextStyles.font24PrimaryBold(context),
                        textAlign: TextAlign.center,
                      ),

                      vGap(16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            day.condition.iconUrl,
                            width: 64,
                            height: 64,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.cloud,
                              color: AppColors.onSurface(context),
                              size: 64,
                            ),
                          ),

                          hGap(12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(isCelsius ? day.maxtempC : day.maxtempF).round()}° / ${(isCelsius ? day.mintempC : day.mintempF).round()}°',
                                style: AppTextStyles.font24PrimaryBold(context),
                              ),

                              Text(
                                day.condition.text,
                                style: AppTextStyles.font16PrimaryMedium(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      vGap(40),

                      Text(
                        s.hourlyForecast,
                        style: AppTextStyles.font14PrimarySemiBoldSpacing(
                          context,
                        ).copyWith(letterSpacing: 2),
                      ),

                      vGap(16),

                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: day.hours.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, i) {
                            return HourCard(
                              hour: day.hours[i],
                              isNow: false,
                              isCelsius: isCelsius,
                            );
                          },
                        ),
                      ),

                      vGap(32),

                      Row(
                        children: [
                          Expanded(
                            child: DetailCard(
                              icon: Icons.wb_sunny_outlined,
                              label: s.sunrise,
                              value: day.astro.sunrise,
                              subtitle: s.sunsetTime(day.astro.sunset),
                            ),
                          ),

                          hGap(12),

                          Expanded(
                            child: DetailCard(
                              icon: Icons.nightlight_round_outlined,
                              label: s.sunset,
                              value: day.astro.sunset,
                              subtitle: s.sunriseTime(day.astro.sunrise),
                            ),
                          ),
                        ],
                      ),

                      vGap(12),

                      SunsetCard(astro: day.astro),

                      vGap(32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
