import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sahab/core/networking/api_result.dart';
import '../../domain/entities/location_suggestion.dart';
import '../../domain/usecases/search_history_usecases.dart';
import '../../domain/usecases/search_locations_usecase.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchLocationsUseCase _searchLocationsUseCase;
  final GetSearchHistoryUseCase _getSearchHistoryUseCase;
  final AddToSearchHistoryUseCase _addToSearchHistoryUseCase;

  SearchCubit(
    this._searchLocationsUseCase,
    this._getSearchHistoryUseCase,
    this._addToSearchHistoryUseCase,
  ) : super(const SearchState.initial());

  Future<void> loadHistory() async {
    final history = await _getSearchHistoryUseCase();
    emit(SearchState.history(history));
  }

  Future<void> addToHistory(String city) async {
    await _addToSearchHistoryUseCase(city);
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      await loadHistory();
      return;
    }

    emit(const SearchState.loading());
    final result = await _searchLocationsUseCase(query);

    result.when(
      success: (data) {
        emit(SearchState.success(data));
      },
      failure: (error) {
        emit(SearchState.error(error.getAllMessages()));
      },
    );
  }
}
