import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class ConnectivityListener {
  ConnectivityListener._();

  static bool hasConnection = false;

  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static void initConnectivityListener() {
    _updateConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      hasConnection = result != ConnectivityResult.none;
      _logConnectivityListener(result: result);
    });
  }

  static void disposeConnectivityListener() {
    _connectivitySubscription.cancel();
    _logConnectivityListener(message: 'ConnectivityListener disposed');
  }

  static Future<void> _updateConnectivity() async {
    final result = await Connectivity().checkConnectivity();

    hasConnection = result != ConnectivityResult.none;

    _logConnectivityListener(result: result);
  }

  static void _logConnectivityListener({
    ConnectivityResult? result,
    String? message,
  }) {
    var logMessage = '';

    if (result != null) {
      logMessage = 'ConnectivityResult: $result';
    } else {
      logMessage = message!;
    }

    AppDebug.log(
      logMessage,
      name: 'ConnectivityListener',
    );
  }
}
