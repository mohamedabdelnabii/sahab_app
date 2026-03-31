// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastData _$ForecastDataFromJson(Map<String, dynamic> json) => ForecastData(
  forecastday: (json['forecastday'] as List<dynamic>?)
      ?.map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
      .toList(),
);
