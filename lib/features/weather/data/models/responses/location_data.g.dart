// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationData _$LocationDataFromJson(Map<String, dynamic> json) => LocationData(
  name: json['name'] as String?,
  region: json['region'] as String?,
  country: json['country'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lon: (json['lon'] as num?)?.toDouble(),
  tzId: json['tz_id'] as String?,
  localtimeEpoch: (json['localtime_epoch'] as num?)?.toInt(),
  localtime: json['localtime'] as String?,
);
