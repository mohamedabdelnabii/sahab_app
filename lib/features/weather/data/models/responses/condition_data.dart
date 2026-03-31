import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

part 'condition_data.g.dart';

@JsonSerializable(createToJson: false)
class ConditionData {
  final String? text;
  final String? icon;
  final int? code;

  ConditionData({
    this.text,
    this.icon,
    this.code,
  });

  factory ConditionData.fromJson(Map<String, dynamic> json) =>
      _$ConditionDataFromJson(json);

  WeatherCondition toEntity() {
    return WeatherCondition(
      text: text ?? '',
      iconUrl: (icon ?? '').startsWith('//') ? 'https:$icon' : (icon ?? ''),
      code: code ?? 0,
    );
  }
}
