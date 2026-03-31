import 'package:sahab/core/networking/api_constants.dart';
import '../apis/alerts_api_services.dart';
import '../models/alerts_response.dart';

class AlertsRemoteDataSource {
  final AlertsApiServices _apiServices;

  AlertsRemoteDataSource(this._apiServices);

  Future<AlertsResponse> getAlerts(String city) async {
    return await _apiServices.getAlerts(city, ApiConstants.weatherApiKey);
  }
}
