import 'package:sahab/core/networking/api_result.dart';
import '../../domain/entities/location_suggestion.dart';
import '../../domain/repositories/search_repository.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../api/search_api_service.dart';

/// Implementation of SearchRepository
class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService _apiService;
  static const String _historyKey = 'search_history';

  const SearchRepositoryImpl(this._apiService);

  @override
  Future<ApiResult<List<LocationSuggestion>>> searchLocations(String query) async {
    try {
      final response = await _apiService.searchLocations(query);
      final suggestions = response.map((model) => model.toEntity()).toList();
      return ApiResult.success(suggestions);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return await SharedPrefHelper.getStringList(_historyKey);
  }

  @override
  Future<void> addToHistory(String city) async {
    final history = await SharedPrefHelper.getStringList(_historyKey);
    if (!history.contains(city)) {
      final updatedHistory = [city, ...history].take(10).toList();
      await SharedPrefHelper.setStringList(_historyKey, updatedHistory);
    }
  }

  @override
  Future<void> clearHistory() async {
    await SharedPrefHelper.removeData(_historyKey);
  }
}
