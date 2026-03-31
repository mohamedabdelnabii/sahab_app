import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'astro_data.dart';
import 'day_data.dart';
import 'hour_data.dart';

part 'forecast_day.g.dart';

@JsonSerializable(createToJson: false)
class ForecastDay {
  final String? date;
  final DayData? day;
  final AstroData? astro;
  final List<HourData>? hour;

  ForecastDay({this.date, this.day, this.astro, this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);

  ForecastDayInfo toEntity() {
    return ForecastDayInfo(
      date: date ?? '',
      maxtempC: day?.maxtempC ?? 0.0,
      maxtempF: day?.maxtempF ?? 0.0,
      mintempC: day?.mintempC ?? 0.0,
      mintempF: day?.mintempF ?? 0.0,
      condition: day?.condition?.toEntity() ??
          const WeatherCondition(text: '', iconUrl: '', code: 0),
      astro: astro?.toEntity() ?? const AstroInfo(sunrise: '', sunset: ''),
      hours: hour?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
