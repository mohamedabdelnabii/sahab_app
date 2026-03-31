import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/alert.dart';

part 'alerts_state.freezed.dart';

@freezed
class AlertsState with _$AlertsState {
  const factory AlertsState.initial() = _Initial;
  const factory AlertsState.loading() = _Loading;
  const factory AlertsState.success(List<Alert> alerts) = _Success;
  const factory AlertsState.error(String message) = _Error;
}
