import 'package:dio/dio.dart';
import '../models/radar_data_response_model.dart';

class RadarApiService {
  final Dio dio;
  static const String _baseUrl = 'https://api.rainviewer.com/public/weather-maps.json';

  RadarApiService(this.dio);

  Future<RadarDataResponseModel?> fetchRadarData() async {
    try {
      final response = await dio.get(_baseUrl);
      if (response.statusCode == 200) {
        return RadarDataResponseModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw Exception('Radar API Error: $e');
    }
  }
}
