import 'package:equatable/equatable.dart';

class LocationSuggestion extends Equatable {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  const LocationSuggestion({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  @override
  List<Object?> get props => [id, name, region, country, lat, lon, url];
}
