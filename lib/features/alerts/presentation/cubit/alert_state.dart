import 'package:equatable/equatable.dart';
import '../../data/models/alert_model.dart';

abstract class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertLoaded extends AlertState {
  final List<AlertModel> alerts;

  const AlertLoaded({required this.alerts});

  @override
  List<Object> get props => [alerts];
}

class AlertError extends AlertState {
  final String message;

  const AlertError({required this.message});

  @override
  List<Object> get props => [message];
}
