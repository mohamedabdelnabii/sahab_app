import 'radar_frame.dart';

class RadarDataEntity {
  final String host;
  final List<RadarFrameEntity> past;
  final List<RadarFrameEntity> nowcast;
  final List<RadarFrameEntity> satelliteInfrared;

  RadarDataEntity({
    required this.host,
    required this.past,
    required this.nowcast,
    required this.satelliteInfrared,
  });

  List<RadarFrameEntity> get allRadarFrames => [...past, ...nowcast];
}
