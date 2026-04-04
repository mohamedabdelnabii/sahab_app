import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahab/core/networking/api_constants.dart';
import '../models/location_suggestion_model.dart';

part 'search_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SearchApiService {
  factory SearchApiService(Dio dio, {String baseUrl}) = _SearchApiService;

  @GET('/search.json')
  Future<List<LocationSuggestionModel>> searchLocations(
    @Query('key') String apiKey,
    @Query('q') String query,
  );
}
