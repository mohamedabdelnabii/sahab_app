import 'package:json_annotation/json_annotation.dart';
import 'package:sahab/features/weather/domain/entities/weather.dart';

part 'location_data.g.dart';

@JsonSerializable(createToJson: false)
class LocationData {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;

  @JsonKey(name: 'tz_id')
  final String? tzId;

  @JsonKey(name: 'localtime_epoch')
  final int? localtimeEpoch;

  final String? localtime;

  LocationData({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  LocationInfo toEntity() {
    return LocationInfo(
      name: name ?? '',
      region: region ?? '',
      country: country ?? '',
      lat: lat ?? 0.0,
      lon: lon ?? 0.0,
      tzId: tzId ?? '',
      localtime: localtime ?? '',
    );
  }
}
