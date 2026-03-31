import 'package:sahab/core/networking/api_result.dart';
import 'package:sahab/features/weather/domain/entities/location_suggestion.dart';
import 'package:sahab/features/weather/domain/repositories/weather_repository.dart';

class SearchLocationsUseCase {
  final WeatherRepository _repository;

  SearchLocationsUseCase(this._repository);

  Future<ApiResult<List<LocationSuggestion>>> call(String query) async {
    return await _repository.searchLocations(query);
  }
}
