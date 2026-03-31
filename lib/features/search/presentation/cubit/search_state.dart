part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.history(List<String> cities) = _History;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.success(List<LocationSuggestion> locations) = _Success;
  const factory SearchState.error(String message) = _Error;
}
