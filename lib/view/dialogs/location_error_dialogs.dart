import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../features/location/bloc/location_bloc.dart';
import '../../global/app_theme.dart';
import '../../services/ticker_controllers/tab_navigation_controller.dart';

class LocationDialogs {
  static void showLocationTimeoutDialog(BuildContext context) {
    const content =
        'Failed to get your current location. Please ensure your GPS is turned on and try again.';
    const androidContent =
        'Failed to get your current location. Please ensure your GPS is turned on and try again. Certain Android devices require a phone reboot for location to be detected properly on the first install of Epic Skies. This will only need to be done one time';
    const title = 'Check Location Settings';
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(androidContent),
            actions: [
              const TextButton(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }

  static void showLocationPermissionDeniedDialog(BuildContext context) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    const content =
        'Please enable location permissions for Epic Skies so you can see your local weather forecast.';
    const title = 'Location permissions denied';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TabNavigationController.to.TabNavController.animateTo(0);
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              const TextButton(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  static void showLocationTurnedOffDialog(BuildContext context) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    const content =
        'Please turn on GPS so Epic Skies can get your local weather forecast.';
    const title = 'Location turned off';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              const TextButton(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }

  static void showGeocodingTimeoutDialog(BuildContext context) {
    const content =
        'An error occurred while attempting to access your current location. Please try again.';
    const title = 'Check Location Settings';
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              const TextButton(
                onPressed: AppSettings.openLocationSettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  GetIt.instance<TabNavigationController>().jumpToTab(index: 0);

                  context
                      .read<LocationBloc>()
                      .add(LocationUpdatePreviousRequest());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }
}
