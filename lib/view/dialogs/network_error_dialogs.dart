import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';

import '../../core/error_handling/error_model.dart';
import '../../features/location/bloc/location_bloc.dart';
import '../../global/app_theme.dart';
import '../../global/local_constants.dart';
import '../../services/ticker_controllers/tab_navigation_controller.dart';

class NetworkDialogs {
  static Future<void> _emailDeveloper(String subject) async {
    final Email email = Email(
      subject: subject,
      recipients: [myEmail],
    );
    await FlutterEmailSender.send(email);
  }

  static void showNetworkErrorDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final title = errorModel.title;
    final content = errorModel.message;
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

    showDialog(context: context, builder: (context) => dialog);
  }

  static void showNoConnectionDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final title = errorModel.title;
    final content = errorModel.message;
    const goToSettings = 'Go to network settings';
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openWIFISettings,
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
                onPressed: AppSettings.openWIFISettings,
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

    showDialog(context: context, builder: (context) => dialog);
  }

  static void show400ErrorDialog(
    BuildContext context, {
    required int statusCode,
  }) {
    const content =
        "Whoops! Something went wrong with the network. Please try again. The developer has been notified. Click below to send any more info that you'd like.";
    const title = 'Network Error';
    const contactDeveloper = 'Email Developer';
    const tryAgain = 'Try Again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
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
              TextButton(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
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
    showDialog(context: context, builder: (context) => dialog);
  }

  static void showServerErrorDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final content = errorModel.message;
    final title = errorModel.title;
    const contactDeveloper = 'Email Developer';
    const tryAgain = 'Try Again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => _emailDeveloper('Epic Skies Server Error'),
                child: const Text(contactDeveloper),
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
              TextButton(
                onPressed: () => _emailDeveloper('Epic Skies Server Error'),
                child:
                    const Text(contactDeveloper, style: dialogActionTextStyle),
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
    showDialog(context: context, builder: (context) => dialog);
  }
}
