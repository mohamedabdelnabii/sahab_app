import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/features/radar/presentation/cubit/radar_state.dart';

import '../../data/repository/rain_viewer_repository.dart';

class RadarCubit extends Cubit<RadarState> {
  final RainViewerRepository repository;

  RadarCubit(this.repository) : super(RadarInitial());

  Future<void> fetchRadarData() async {
    emit(RadarLoading());

    try {
      final data = await repository.fetchRadarData();

      if (data != null) {
        emit(RadarLoaded(data));
      } else {
        emit(RadarError('Failed to load radar data'));
      }
    } catch (e) {
      emit(RadarError(e.toString()));
    }
  }
}
