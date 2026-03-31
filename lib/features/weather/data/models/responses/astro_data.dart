import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

part 'astro_data.g.dart';

@JsonSerializable(createToJson: false)
class AstroData {
  final String? sunrise;
  final String? sunset;

  AstroData({this.sunrise, this.sunset});

  factory AstroData.fromJson(Map<String, dynamic> json) =>
      _$AstroDataFromJson(json);

  AstroInfo toEntity() {
    return AstroInfo(
      sunrise: sunrise ?? '',
      sunset: sunset ?? '',
    );
  }
}
