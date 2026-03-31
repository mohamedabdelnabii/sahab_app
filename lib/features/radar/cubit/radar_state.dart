import '../domain/entities/radar_data.dart';

abstract class RadarState {}

class RadarInitial extends RadarState {}

class RadarLoading extends RadarState {}

class RadarLoaded extends RadarState {
  final RadarDataEntity data;

  RadarLoaded(this.data);
}

class RadarError extends RadarState {
  final String message;

  RadarError(this.message);
}
