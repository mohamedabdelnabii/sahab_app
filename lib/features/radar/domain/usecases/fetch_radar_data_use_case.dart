import '../entities/radar_data.dart';
import '../repository/radar_repository.dart';

class FetchRadarDataUseCase {
  final RadarRepository repository;

  FetchRadarDataUseCase(this.repository);

  Future<RadarDataEntity?> call() async {
    return await repository.fetchRadarData();
  }
}
