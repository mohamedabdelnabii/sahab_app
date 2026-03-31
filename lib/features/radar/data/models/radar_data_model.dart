import 'radar_frame_model.dart';

class RadarDataModel {
  final List<RadarFrameModel> past;
  final List<RadarFrameModel> nowcast;

  RadarDataModel({
    required this.past,
    required this.nowcast,
  });

  factory RadarDataModel.fromJson(Map<String, dynamic> json) {
    final pastList = json['past'] as List<dynamic>? ?? [];
    final nowcastList = json['nowcast'] as List<dynamic>? ?? [];

    return RadarDataModel(
      past: pastList.map((e) => RadarFrameModel.fromJson(e)).toList(),
      nowcast: nowcastList.map((e) => RadarFrameModel.fromJson(e)).toList(),
    );
  }

  List<RadarFrameModel> get allFrames => [...past, ...nowcast];
}