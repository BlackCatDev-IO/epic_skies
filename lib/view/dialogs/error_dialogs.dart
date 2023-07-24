import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/view/dialogs/ad_dialogs.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:flutter/material.dart';

class ErrorDialogs {
  static void showDialog(BuildContext context, ErrorModel errorModel) {
    switch (errorModel) {
      case Errors.networkErrorModel:
        return NetworkDialogs.showNetworkErrorDialog(
          context,
          errorModel,
        );
      case Errors.serverErrorModel:
        return NetworkDialogs.showServerErrorDialog(
          context,
          errorModel,
        );
      case Errors.locationTimeoutErrorModel:
        return LocationDialogs.showGeocodingTimeoutDialog(
          context,
          errorModel,
        );
      case Errors.locationServiceDisabledErrorModel:
        return LocationDialogs.showLocationTurnedOffDialog(
          context,
          errorModel,
        );
      case Errors.noAddressInfoFoundModel:
        return LocationDialogs.showNoAddressInfoFoundDialog(
          context,
          errorModel,
        );
      case Errors.networkErrorModel:
        return NetworkDialogs.showNoConnectionDialog(
          context,
          errorModel,
        );
      case Errors.noPurchasesFoundModel:
        return AdDialogs.noPurchasesFound(
          context,
          errorModel,
        );
      default:
        return NetworkDialogs.showNetworkErrorDialog(
          context,
          errorModel,
        );
    }
  }
}
