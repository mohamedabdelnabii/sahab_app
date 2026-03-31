// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayData _$DayDataFromJson(Map<String, dynamic> json) => DayData(
  maxtempC: (json['maxtemp_c'] as num?)?.toDouble(),
  maxtempF: (json['maxtemp_f'] as num?)?.toDouble(),
  mintempC: (json['mintemp_c'] as num?)?.toDouble(),
  mintempF: (json['mintemp_f'] as num?)?.toDouble(),
  condition: json['condition'] == null
      ? null
      : ConditionData.fromJson(json['condition'] as Map<String, dynamic>),
);
