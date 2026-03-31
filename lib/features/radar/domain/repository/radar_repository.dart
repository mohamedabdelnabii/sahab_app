import '../entities/radar_data.dart';

abstract class RadarRepository {
  Future<RadarDataEntity?> fetchRadarData();
}
