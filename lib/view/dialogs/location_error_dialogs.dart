import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/location/bloc/location_bloc.dart';
import '../../global/app_theme.dart';
import '../../services/ticker_controllers/tab_navigation_controller.dart';

class LocationDialogs {
  static void showLocationPermissionDeniedDialog(
    BuildContext context,
    LocationNoPermissionException exception,
  ) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    final content = exception.message;
    final title = exception.title;

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
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
            title: Text(title),
            content: Text(content),
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

  static void showLocationTurnedOffDialog(
    BuildContext context,
    LocationServiceDisableException exception,
  ) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    final content = exception.message;
    final title = exception.title;

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
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
            title: Text(title),
            content: Text(content),
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

  static void showGeocodingTimeoutDialog(
    BuildContext context,
    LocationTimeOutException exception,
  ) {
    final content = exception.message;
    final title = exception.title;
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
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
            title: Text(title),
            content: Text(content),
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

  static void showNoAddressInfoFoundDialog(
    BuildContext context,
    NoAddressInfoFoundException exception,
  ) {
    final content = exception.message;
    final title = exception.title;
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
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
            title: Text(title),
            content: Text(content),
            actions: [
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
}
