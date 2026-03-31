/// Entity representing a search result location
class LocationSuggestion {
  final String id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  const LocationSuggestion({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationSuggestion && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$name, $region, $country';
}
