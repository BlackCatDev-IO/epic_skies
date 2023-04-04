import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LocationDialogs {
  static void showLocationPermissionDeniedDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    final content = errorModel.message;
    final title = errorModel.title;

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

    showDialog<void>(
      context: context,
      builder: (context) => dialog,
    );
  }

  static void showLocationTurnedOffDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    const goToSettings = 'Go to location settings';
    const tryAgain = 'Try Again';
    final content = errorModel.message;
    final title = errorModel.title;

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

    showDialog<void>(
      context: context,
      builder: (context) => dialog,
    );
  }

  static void showGeocodingTimeoutDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final content = errorModel.message;
    final title = errorModel.title;
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

    showDialog<void>(
      context: context,
      builder: (context) => dialog,
    );
  }

  static void showNoAddressInfoFoundDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final content = errorModel.message;
    final title = errorModel.title;
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

    showDialog<void>(
      context: context,
      builder: (context) => dialog,
    );
  }
}
