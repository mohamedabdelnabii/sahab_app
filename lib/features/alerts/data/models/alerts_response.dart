import 'package:json_annotation/json_annotation.dart';
import 'alert_model.dart';
import '../../domain/entities/alert.dart';

part 'alerts_response.g.dart';

@JsonSerializable(createToJson: false)
class AlertsResponse {
  final AlertsData alerts;

  const AlertsResponse({required this.alerts});

  factory AlertsResponse.fromJson(Map<String, dynamic> json) =>
      _$AlertsResponseFromJson(json);

  List<Alert> toEntityList() {
    return alerts.alert.map((model) => model.toEntity()).toList();
  }
}

@JsonSerializable(createToJson: false)
class AlertsData {
  final List<AlertModel> alert;

  const AlertsData({required this.alert});

  factory AlertsData.fromJson(Map<String, dynamic> json) =>
      _$AlertsDataFromJson(json);
}
