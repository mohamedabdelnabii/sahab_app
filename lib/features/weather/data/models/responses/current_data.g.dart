// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentData _$CurrentDataFromJson(Map<String, dynamic> json) => CurrentData(
  tempC: (json['temp_c'] as num?)?.toDouble(),
  tempF: (json['temp_f'] as num?)?.toDouble(),
  isDay: (json['is_day'] as num?)?.toInt(),
  condition: json['condition'] == null
      ? null
      : ConditionData.fromJson(json['condition'] as Map<String, dynamic>),
  windMph: (json['wind_mph'] as num?)?.toDouble(),
  windKph: (json['wind_kph'] as num?)?.toDouble(),
  windDegree: (json['wind_degree'] as num?)?.toInt(),
  windDir: json['wind_dir'] as String?,
  pressureMb: (json['pressure_mb'] as num?)?.toDouble(),
  precipMm: (json['precip_mm'] as num?)?.toDouble(),
  humidity: (json['humidity'] as num?)?.toInt(),
  cloud: (json['cloud'] as num?)?.toInt(),
  feelslikeC: (json['feelslike_c'] as num?)?.toDouble(),
  feelslikeF: (json['feelslike_f'] as num?)?.toDouble(),
  windchillC: (json['windchill_c'] as num?)?.toDouble(),
  heatindexC: (json['heatindex_c'] as num?)?.toDouble(),
  dewpointC: (json['dewpoint_c'] as num?)?.toDouble(),
  dewpointF: (json['dewpoint_f'] as num?)?.toDouble(),
  visKm: (json['vis_km'] as num?)?.toDouble(),
  uv: (json['uv'] as num?)?.toDouble(),
  gustKph: (json['gust_kph'] as num?)?.toDouble(),
);
