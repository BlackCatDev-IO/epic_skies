import 'dart:async';

import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityListener {
  ConnectivityListener._();

  static bool hasConnection = false;

  static late StreamSubscription<InternetConnectionStatus>
      _connectivitySubscription;

  static void initConnectivityListener() {
    _updateConnectivity();
    _connectivitySubscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus result) {
      hasConnection = result == InternetConnectionStatus.connected;
      _logConnectivityListener(hasConnection);
    });
  }

  static void disposeConnectivityListener() {
    _connectivitySubscription.cancel();
    _logConnectivityListener(hasConnection);
  }

  static Future<void> _updateConnectivity() async {
    hasConnection = await InternetConnectionChecker().hasConnection;

    _logConnectivityListener(hasConnection);
  }

  static void _logConnectivityListener(
    bool result,
  ) {
    final logMessage = 'ConnectivityListener: hasConnection: $result';

    AppDebug.log(
      logMessage,
      name: 'ConnectivityListener',
    );
  }
}
