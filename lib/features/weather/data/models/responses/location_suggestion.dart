import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/location_suggestion.dart';

part 'location_suggestion.g.dart';

@JsonSerializable()
class LocationSuggestionModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  LocationSuggestionModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory LocationSuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$LocationSuggestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSuggestionModelToJson(this);

  LocationSuggestion toEntity() {
    return LocationSuggestion(
      id: id,
      name: name,
      region: region,
      country: country,
      lat: lat,
      lon: lon,
      url: url,
    );
  }
}
