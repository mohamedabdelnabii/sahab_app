import 'package:sahab/features/radar/data/models/radar_frame_model.dart';

import 'radar_data_model.dart';

class RadarDataResponseModel {
  final String version;
  final int generated;
  final String host;
  final RadarDataModel radar;
  final SatelliteDataModel satellite;

  RadarDataResponseModel({
    required this.version,
    required this.generated,
    required this.host,
    required this.radar,
    required this.satellite,
  });

  factory RadarDataResponseModel.fromJson(Map<String, dynamic> json) {
    return RadarDataResponseModel(
      version: json['version'] ?? '',
      generated: json['generated'] ?? 0,
      host: json['host'] ?? '',
      radar: RadarDataModel.fromJson(json['radar'] ?? {}),
      satellite: SatelliteDataModel.fromJson(json['satellite'] ?? {}),
    );
  }
}

class SatelliteDataModel {
  final List<RadarFrameModel> infrared;

  SatelliteDataModel({required this.infrared});

  factory SatelliteDataModel.fromJson(Map<String, dynamic> json) {
    final list = json['infrared'] as List<dynamic>? ?? [];
    return SatelliteDataModel(
      infrared: list.map((e) => RadarFrameModel.fromJson(e)).toList(),
    );
  }
}
