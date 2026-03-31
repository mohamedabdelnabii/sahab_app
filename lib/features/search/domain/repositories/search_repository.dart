import 'package:sahab/core/networking/api_result.dart';
import '../entities/location_suggestion.dart';

/// Repository contract for search operations
abstract class SearchRepository {
  /// Search for locations by query
  Future<ApiResult<List<LocationSuggestion>>> searchLocations(String query);
  
  /// Get search history
  Future<List<String>> getSearchHistory();
  
  /// Add a city to search history
  Future<void> addToHistory(String city);
  
  /// Clear search history
  Future<void> clearHistory();
}
