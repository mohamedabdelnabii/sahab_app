// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourData _$HourDataFromJson(Map<String, dynamic> json) => HourData(
  timeEpoch: (json['time_epoch'] as num?)?.toInt(),
  time: json['time'] as String?,
  tempC: (json['temp_c'] as num?)?.toDouble(),
  tempF: (json['temp_f'] as num?)?.toDouble(),
  condition: json['condition'] == null
      ? null
      : ConditionData.fromJson(json['condition'] as Map<String, dynamic>),
  windKph: (json['wind_kph'] as num?)?.toDouble(),
  humidity: (json['humidity'] as num?)?.toInt(),
);
