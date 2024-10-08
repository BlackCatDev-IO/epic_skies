import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationDialogs {
  static const goToSettings = 'Go to location settings';
  static const tryAgain = 'Try Again';

  static void _retryPreviousLocationRequest(BuildContext context) {
    Navigator.of(context).pop();
    getIt<TabNavigationController>().jumpToTab(index: 0);

    context.read<LocationBloc>().add(LocationUpdatePreviousRequest());
  }

  static void showLocationPermissionDeniedDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      goToSettings: () =>
          AppSettings.openAppSettings(type: AppSettingsType.location),
      tryAgain: () => _retryPreviousLocationRequest(context),
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }

  static void showLocationTurnedOffDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      goToSettings: () =>
          AppSettings.openAppSettings(type: AppSettingsType.location),
      tryAgain: () => _retryPreviousLocationRequest(context),
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }

  static void showGeocodingTimeoutDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      tryAgain: () => _retryPreviousLocationRequest(context),
    };
    Dialogs.showPlatformDialog(
      context,
      stringContent: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }

  static void showNoAddressInfoFoundDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      tryAgain: () => _retryPreviousLocationRequest(context),
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }
}
