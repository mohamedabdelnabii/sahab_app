import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectionStatus { connected, disconnected }

class ConnectionCubit extends Cubit<ConnectionStatus> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectionCubit() : super(ConnectionStatus.connected) {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<void> _initConnectivity() async {
    late List<ConnectivityResult> results;
    try {
      results = await _connectivity.checkConnectivity();
    } catch (e) {
      results = [ConnectivityResult.none];
    }
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    final isConnected = connectivityResults.any(
      (result) => result != ConnectivityResult.none,
    );

    if (isConnected) {
      emit(ConnectionStatus.connected);
    } else {
      emit(ConnectionStatus.disconnected);
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
