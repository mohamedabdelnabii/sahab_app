// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => ForecastDay(
  date: json['date'] as String?,
  day: json['day'] == null
      ? null
      : DayData.fromJson(json['day'] as Map<String, dynamic>),
  astro: json['astro'] == null
      ? null
      : AstroData.fromJson(json['astro'] as Map<String, dynamic>),
  hour: (json['hour'] as List<dynamic>?)
      ?.map((e) => HourData.fromJson(e as Map<String, dynamic>))
      .toList(),
);
