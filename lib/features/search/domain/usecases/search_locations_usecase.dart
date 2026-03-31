import 'package:sahab/core/networking/api_result.dart';
import '../entities/location_suggestion.dart';
import '../repositories/search_repository.dart';

/// Use case for searching locations
class SearchLocationsUseCase {
  final SearchRepository _repository;

  const SearchLocationsUseCase(this._repository);

  /// Execute search with the given query
  Future<ApiResult<List<LocationSuggestion>>> call(String query) {
    return _repository.searchLocations(query);
  }
}
