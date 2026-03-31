import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sahab/features/radar/data/models/radar_data_response_model.dart';


class RainViewerService {
  static const String _baseUrl = 'https://api.rainviewer.com/public/weather-maps.json';

  Future<RadarDataResponseModel?> fetchRadarData() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return RadarDataResponseModel.fromJson(json);
      }

      return null;
    } catch (e) {
      throw Exception('Radar API Error: $e');
    }
  }
}