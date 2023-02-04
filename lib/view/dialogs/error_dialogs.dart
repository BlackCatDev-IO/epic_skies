import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:flutter/material.dart';

class ErrorDialogs {
  static void showDialog(BuildContext context, ErrorModel errorModel) {
    if (errorModel == Errors.networkErrorModel) {
      return NetworkDialogs.showNoConnectionDialog(
        context,
        errorModel,
      );
    }

    if (errorModel == Errors.serverErrorModel) {
      return NetworkDialogs.showServerErrorDialog(
        context,
        errorModel,
      );
    }

    if (errorModel == Errors.locationTimeoutErrorModel) {
      return LocationDialogs.showGeocodingTimeoutDialog(
        context,
        errorModel,
      );
    }

    if (errorModel == Errors.locationServiceDisabledErrorModel) {
      return LocationDialogs.showLocationTurnedOffDialog(
        context,
        errorModel,
      );
    }

    if (errorModel == Errors.noAddressInfoFoundModel) {
      return LocationDialogs.showNoAddressInfoFoundDialog(
        context,
        errorModel,
      );
    }

    if (errorModel == Errors.networkErrorModel) {
      return NetworkDialogs.showNoConnectionDialog(
        context,
        errorModel,
      );
    }

    return NetworkDialogs.showNetworkErrorDialog(
      context,
      errorModel,
    );
  }
}
