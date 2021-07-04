import 'dart:io';

import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class FailureHandler extends GetxController {
  static FailureHandler get to => Get.find();

// TODO: Finish handling these errors

  Future<void> handleNetworkError(
      {required int statusCode, required String method}) async {
    // TODO: UI hangs when this happens, fix it
    if (statusCode.isInRange(500, 599)) {
      NetworkDialogs.showTomorrowIOErrorDialog(statusCode: statusCode);
    } else {
      NetworkDialogs.show400ErrorDialog(statusCode: statusCode);
    }
    await Sentry.captureException('network error on $method',
        stackTrace: 'response code: $statusCode');

    WeatherRepository.to.isLoading(false);
    debugPrint('failure on $method status code: $statusCode');

    throw HttpException;
  }

  Future<void> handleLocationFailure({required Exception exception}) async {}

  Future<void> handleNoConnection({required String method}) async {
    NetworkDialogs.showNoConnectionDialog();
    await Sentry.captureException(
      '$method attempted with no connection',
    );
  }

  Future<void> handleLocationTurnedOff() async {
    LocationDialogs.showLocationTurnedOffDialog();
    await Sentry.captureException(
      '_getLocation attempted with location services disabled',
    );
  }

  Future<void> handleLocationTimeout() async {
    LocationDialogs.showLocationTimeoutDialog();
    await Sentry.captureException(
      'location timeout on GeoLocation.getCurrentPosition',
    );
  }

  Future<void> handleLocationPermissionDenied() async {
    LocationDialogs.showLocationPermissionDeniedDialog();
    await Sentry.captureException(
      '_getLocation attempted with permission denied',
    );
  }
}
