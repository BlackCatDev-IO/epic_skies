import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/services/email_service.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class NetworkDialogs {
  static const contactDeveloper = 'Email Developer';
  static const tryAgain = 'Try Again';

  static Future<void> _emailDeveloper(
    BuildContext context,
    String subject,
  ) async {
    Navigator.of(context).pop();

    final emailService = EmailService();

    await emailService.sendEmail(context);
  }

  static void _retryWeatherSearch(BuildContext context) {
    Navigator.of(context).pop();
    GetIt.I<TabNavigationController>().jumpToTab(index: 0);

    context.read<LocationBloc>().add(LocationUpdatePreviousRequest());
  }

  static void showNetworkErrorDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {'Try again': () => _retryWeatherSearch(context)};

    Dialogs.showPlatformDialog(
      context,
      content: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }

  static void showNoConnectionDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      'Go to network settings': () =>
          AppSettings.openAppSettings(type: AppSettingsType.wifi),
      tryAgain: () => _retryWeatherSearch(context),
    };

    Dialogs.showPlatformDialog(
      context,
      content: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }

  static void show400ErrorDialog(
    BuildContext context, {
    required int statusCode,
  }) {
    const content =
        '''Whoops! Something went wrong with the network. Please try again. The developer has been notified. Click below to send any more info that you'd like.''';

    final actions = {
      contactDeveloper: () =>
          _emailDeveloper(context, 'Epic Skies Error: $statusCode'),
      tryAgain: () => _retryWeatherSearch(context),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
      title: 'Network Error',
    );
  }

  static void showServerErrorDialog(
    BuildContext context,
    ErrorModel errorModel,
  ) {
    final actions = {
      contactDeveloper: () =>
          _emailDeveloper(context, 'Epic Skies Server Error'),
      tryAgain: () => _retryWeatherSearch(context),
    };

    Dialogs.showPlatformDialog(
      context,
      content: errorModel.message,
      dialogActions: actions,
      title: errorModel.title,
    );
  }
}
