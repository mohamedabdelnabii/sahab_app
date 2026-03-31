import '../repositories/search_repository.dart';

/// Use case for getting search history
class GetSearchHistoryUseCase {
  final SearchRepository _repository;

  const GetSearchHistoryUseCase(this._repository);

  /// Get search history
  Future<List<String>> call() {
    return _repository.getSearchHistory();
  }
}

/// Use case for adding to search history
class AddToSearchHistoryUseCase {
  final SearchRepository _repository;

  const AddToSearchHistoryUseCase(this._repository);

  /// Add a city to search history
  Future<void> call(String city) {
    return _repository.addToHistory(city);
  }
}
