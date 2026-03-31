import '../api/radar_api_service.dart';
import '../models/radar_data_response_model.dart';

abstract class RadarRemoteDataSource {
  Future<RadarDataResponseModel?> fetchRadarData();
}

class RadarRemoteDataSourceImpl implements RadarRemoteDataSource {
  final RadarApiService apiService;

  RadarRemoteDataSourceImpl(this.apiService);

  @override
  Future<RadarDataResponseModel?> fetchRadarData() {
    return apiService.fetchRadarData();
  }
}
