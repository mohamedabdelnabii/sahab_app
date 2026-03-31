// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationSuggestionModel _$LocationSuggestionModelFromJson(
  Map<String, dynamic> json,
) => LocationSuggestionModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  region: json['region'] as String,
  country: json['country'] as String,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
);

Map<String, dynamic> _$LocationSuggestionModelToJson(
  LocationSuggestionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'region': instance.region,
  'country': instance.country,
  'lat': instance.lat,
  'lon': instance.lon,
};
