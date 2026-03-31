import 'package:sahab/core/networking/api_error_handler.dart';
import 'package:sahab/core/networking/api_result.dart';
import '../../domain/entities/alert.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/alerts_remote_data_source.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  final AlertsRemoteDataSource _remoteDataSource;

  AlertsRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<Alert>>> getAlerts(String city) async {
    try {
      final response = await _remoteDataSource.getAlerts(city);
      return ApiResult.success(response.toEntityList());
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
