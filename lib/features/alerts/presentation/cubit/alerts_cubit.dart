import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/helpers/shared_pref_helper.dart';
import 'package:sahab/core/networking/api_result.dart';
import '../../domain/usecases/get_alerts_use_case.dart';
import 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final GetAlertsUseCase _getAlertsUseCase;

  AlertsCubit(this._getAlertsUseCase) : super(const AlertsState.initial());

  Future<void> fetchAlertsForHomeCity() async {
    final city = await SharedPrefHelper.getHomeCity();
    await fetchAlerts(city);
  }

  Future<void> fetchAlerts(String city) async {
    emit(const AlertsState.loading());

    final result = await _getAlertsUseCase(city);

    result.when(
      success: (alerts) => emit(AlertsState.success(alerts)),
      failure: (error) => emit(AlertsState.error(error.message ?? 'Unknown error')),
    );
  }
}
