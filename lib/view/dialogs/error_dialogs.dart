import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/view/dialogs/ad_dialogs.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:flutter/material.dart';

class ErrorDialogs {
  static void showDialog(BuildContext context, ErrorModel errorModel) {
    return switch (errorModel) {
      Errors.networkErrorModel => NetworkDialogs.showNetworkErrorDialog(
          context,
          errorModel,
        ),
      Errors.serverErrorModel => NetworkDialogs.showServerErrorDialog(
          context,
          errorModel,
        ),
      Errors.locationTimeoutErrorModel =>
        LocationDialogs.showGeocodingTimeoutDialog(
          context,
          errorModel,
        ),
      Errors.locationServiceDisabledErrorModel =>
        LocationDialogs.showLocationTurnedOffDialog(
          context,
          errorModel,
        ),
      Errors.noAddressInfoFoundModel =>
        LocationDialogs.showNoAddressInfoFoundDialog(
          context,
          errorModel,
        ),
      Errors.networkErrorModel => NetworkDialogs.showNoConnectionDialog(
          context,
          errorModel,
        ),
      Errors.noPurchasesFoundModel => AdDialogs.noPurchasesFound(
          context,
          errorModel,
        ),
      _ => NetworkDialogs.showNetworkErrorDialog(
          context,
          errorModel,
        ),
    };
  }
}
