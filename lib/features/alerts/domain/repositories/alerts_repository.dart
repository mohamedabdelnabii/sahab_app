import 'package:sahab/core/networking/api_result.dart';
import '../entities/alert.dart';

abstract class AlertsRepository {
  Future<ApiResult<List<Alert>>> getAlerts(String city);
}
