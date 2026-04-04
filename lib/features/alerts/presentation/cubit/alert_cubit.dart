import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/services/alert_service.dart';
import 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  final AlertService _alertService;

  AlertCubit(this._alertService) : super(AlertInitial());

  Future<void> loadAlerts() async {
    emit(AlertLoading());
    try {
      final alerts = await _alertService.getSavedAlerts();
      emit(AlertLoaded(alerts: alerts));
    } catch (e) {
      emit(AlertError(message: e.toString()));
    }
  }

  Future<void> clearAlerts() async {
    try {
      await _alertService.clearAlerts();
      emit(const AlertLoaded(alerts: []));
    } catch (e) {
      emit(AlertError(message: e.toString()));
    }
  }
}
