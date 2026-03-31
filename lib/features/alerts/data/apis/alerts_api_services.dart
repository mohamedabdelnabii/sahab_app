import 'package:dio/dio.dart';
import 'package:sahab/core/networking/api_constants.dart';
import '../models/alerts_response.dart';

class AlertsApiServices {
  final Dio _dio;

  AlertsApiServices(this._dio);

  Future<AlertsResponse> getAlerts(String city, String apiKey) async {
    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.alerts}',
      queryParameters: {
        'key': apiKey,
        'q': city,
      },
    );

    return AlertsResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}
