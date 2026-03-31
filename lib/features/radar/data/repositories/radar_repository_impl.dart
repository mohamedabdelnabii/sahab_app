import '../../domain/entities/radar_data.dart';
import '../../domain/entities/radar_frame.dart';
import '../../domain/repository/radar_repository.dart';
import '../datasource/radar_remote_data_source.dart';
import '../models/radar_frame_model.dart';

class RadarRepositoryImpl implements RadarRepository {
  final RadarRemoteDataSource remoteDataSource;

  RadarRepositoryImpl(this.remoteDataSource);

  @override
  Future<RadarDataEntity?> fetchRadarData() async {
    final response = await remoteDataSource.fetchRadarData();
    if (response == null) return null;

    return RadarDataEntity(
      host: response.host,
      past: response.radar.past.map((e) => _mapFrame(e)).toList(),
      nowcast: response.radar.nowcast.map((e) => _mapFrame(e)).toList(),
      satelliteInfrared: response.satellite.infrared.map((e) => _mapFrame(e)).toList(),
    );
  }

  RadarFrameEntity _mapFrame(RadarFrameModel model) {
    return RadarFrameEntity(
      time: model.time,
      path: model.path,
    );
  }
}
