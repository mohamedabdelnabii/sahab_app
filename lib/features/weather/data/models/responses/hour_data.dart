import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'condition_data.dart';

part 'hour_data.g.dart';

@JsonSerializable(createToJson: false)
class HourData {
  @JsonKey(name: 'time_epoch')
  final int? timeEpoch;

  final String? time;

  @JsonKey(name: 'temp_c')
  final double? tempC;

  @JsonKey(name: 'temp_f')
  final double? tempF;

  final ConditionData? condition;

  @JsonKey(name: 'wind_kph')
  final double? windKph;

  final int? humidity;

  HourData({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.condition,
    this.windKph,
    this.humidity,
  });

  factory HourData.fromJson(Map<String, dynamic> json) =>
      _$HourDataFromJson(json);

  HourInfo toEntity() {
    return HourInfo(
      time: time ?? '',
      tempC: tempC ?? 0.0,
      tempF: tempF ?? 0.0,
      condition: condition?.toEntity() ?? const WeatherCondition(text: '', iconUrl: '', code: 0),
      windKph: windKph ?? 0.0,
      humidity: humidity ?? 0,
    );
  }
}
