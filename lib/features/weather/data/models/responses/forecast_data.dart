import 'package:json_annotation/json_annotation.dart';
import 'forecast_day.dart';

part 'forecast_data.g.dart';

@JsonSerializable(createToJson: false)
class ForecastData {
  final List<ForecastDay>? forecastday;

  ForecastData({this.forecastday});

  factory ForecastData.fromJson(Map<String, dynamic> json) =>
      _$ForecastDataFromJson(json);
}
