import '../datasource/rain_viewer_remote_data_source.dart';
import '../models/radar_data_response_model.dart';

class RainViewerRepository {
  final RainViewerRemoteDataSource remoteDataSource;

  RainViewerRepository(this.remoteDataSource);

  Future<RadarDataResponseModel?> fetchRadarData() {
    return remoteDataSource.fetchRadarData();
  }
}