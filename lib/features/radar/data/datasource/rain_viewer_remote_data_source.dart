import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/radar_data_response_model.dart';

class RainViewerRemoteDataSource {
  final Dio dio;

  RainViewerRemoteDataSource(this.dio);

  Future<RadarDataResponseModel?> fetchRadarData() async {
    try {
      final response = await dio.get(
        'https://api.rainviewer.com/public/weather-maps.json',
      );

      return RadarDataResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      log('Radar error: ${e.message}');
      return null;
    }
  }
}