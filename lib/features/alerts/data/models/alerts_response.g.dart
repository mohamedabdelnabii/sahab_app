// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertsResponse _$AlertsResponseFromJson(Map<String, dynamic> json) =>
    AlertsResponse(
      alerts: AlertsData.fromJson(json['alerts'] as Map<String, dynamic>),
    );

AlertsData _$AlertsDataFromJson(Map<String, dynamic> json) => AlertsData(
  alert: (json['alert'] as List<dynamic>)
      .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
