import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:flutter/material.dart';

class ErrorDialogs {
  static void showDialog(BuildContext context, Exception exception) {
    switch (exception.runtimeType) {
      case NoConnectionException:
        return NetworkDialogs.showNoConnectionDialog(
          context,
          exception as NoConnectionException,
        );
      case ServerErrorException:
        return NetworkDialogs.showServerErrorDialog(
          context,
          exception as ServerErrorException,
        );
      case LocationTimeOutException:
        return LocationDialogs.showGeocodingTimeoutDialog(
          context,
          exception as LocationTimeOutException,
        );

      case LocationServiceDisableException:
        return LocationDialogs.showLocationTurnedOffDialog(
          context,
          exception as LocationServiceDisableException,
        );
      case NoAddressInfoFoundException:
        return LocationDialogs.showNoAddressInfoFoundDialog(
          context,
          exception as NoAddressInfoFoundException,
        );
      case NetworkException:
        return NetworkDialogs.showNetworkErrorDialog(
          context,
          exception as NetworkException,
        );
    }
  }
}
