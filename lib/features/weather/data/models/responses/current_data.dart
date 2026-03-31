import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';
import 'condition_data.dart';

part 'current_data.g.dart';

@JsonSerializable(createToJson: false)
class CurrentData {
  @JsonKey(name: 'temp_c')
  final double? tempC;

  @JsonKey(name: 'temp_f')
  final double? tempF;

  @JsonKey(name: 'is_day')
  final int? isDay;

  final ConditionData? condition;

  @JsonKey(name: 'wind_mph')
  final double? windMph;

  @JsonKey(name: 'wind_kph')
  final double? windKph;

  @JsonKey(name: 'wind_degree')
  final int? windDegree;

  @JsonKey(name: 'wind_dir')
  final String? windDir;

  @JsonKey(name: 'pressure_mb')
  final double? pressureMb;

  @JsonKey(name: 'precip_mm')
  final double? precipMm;

  final int? humidity;
  final int? cloud;

  @JsonKey(name: 'feelslike_c')
  final double? feelslikeC;

  @JsonKey(name: 'feelslike_f')
  final double? feelslikeF;

  @JsonKey(name: 'windchill_c')
  final double? windchillC;

  @JsonKey(name: 'heatindex_c')
  final double? heatindexC;

  @JsonKey(name: 'dewpoint_c')
  final double? dewpointC;

  @JsonKey(name: 'dewpoint_f')
  final double? dewpointF;

  @JsonKey(name: 'vis_km')
  final double? visKm;

  final double? uv;

  @JsonKey(name: 'gust_kph')
  final double? gustKph;

  CurrentData({
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.precipMm,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.heatindexC,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.uv,
    this.gustKph,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) =>
      _$CurrentDataFromJson(json);

  CurrentWeather toEntity() {
    return CurrentWeather(
      tempC: tempC ?? 0.0,
      tempF: tempF ?? 0.0,
      isDay: (isDay ?? 1) == 1,
      condition: condition?.toEntity() ?? const WeatherCondition(text: '', iconUrl: '', code: 0),
      windKph: windKph ?? 0.0,
      windDir: windDir ?? '',
      pressureMb: pressureMb ?? 0.0,
      humidity: humidity ?? 0,
      feelslikeC: feelslikeC ?? 0.0,
      feelslikeF: feelslikeF ?? 0.0,
      dewpointC: dewpointC ?? 0.0,
      dewpointF: dewpointF ?? 0.0,
      visKm: visKm ?? 0.0,
      uv: uv ?? 0.0,
    );
  }
}
