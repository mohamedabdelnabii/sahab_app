import '../../data/models/radar_data_response_model.dart';

abstract class RadarState {}

class RadarInitial extends RadarState {}

class RadarLoading extends RadarState {}

class RadarLoaded extends RadarState {
  final RadarDataResponseModel data;

  RadarLoaded(this.data);
}

class RadarError extends RadarState {
  final String message;

  RadarError(this.message);
}