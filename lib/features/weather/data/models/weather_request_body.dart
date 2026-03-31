import 'package:json_annotation/json_annotation.dart';

part 'weather_request_body.g.dart';

@JsonSerializable(createFactory: false)
class WeatherRequestBody {
  final String q;
  final String? dt;

  WeatherRequestBody({
    required this.q,
    this.dt,
  });

  Map<String, dynamic> toJson() => _$WeatherRequestBodyToJson(this);
}