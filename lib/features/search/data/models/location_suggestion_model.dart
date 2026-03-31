import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/location_suggestion.dart';

part 'location_suggestion_model.g.dart';

@JsonSerializable()
class LocationSuggestionModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  LocationSuggestionModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory LocationSuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$LocationSuggestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSuggestionModelToJson(this);

  LocationSuggestion toEntity() => LocationSuggestion(
        id: id.toString(),
        name: name,
        region: region,
        country: country,
        lat: lat,
        lon: lon,
      );
}
