import 'package:sahab/core/networking/api_result.dart';
import '../entities/alert.dart';
import '../repositories/alerts_repository.dart';

class GetAlertsUseCase {
  final AlertsRepository _repository;

  GetAlertsUseCase(this._repository);

  Future<ApiResult<List<Alert>>> call(String city) async {
    return await _repository.getAlerts(city);
  }
}
