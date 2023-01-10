import 'dart:developer';
import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/view/dialogs/location_error_dialogs.dart';
import 'package:epic_skies/view/dialogs/network_error_dialogs.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class FailureHandler {
  FailureHandler._();
/* -------------------------------------------------------------------------- */
/*                               NETWORK ERRORS                               */
/* -------------------------------------------------------------------------- */

  static Future<void> handleNetworkError({
    int? statusCode,
    required String method,
  }) async {
    log('failure on $method status code: $statusCode');
    if (statusCode == null) {
      log('null status code on $method status code: $statusCode');
    }
    // TODO: UI hangs when this happens, fix it
    if (statusCode!.isInRange(500, 599)) {
      NetworkDialogs.showTomorrowIOErrorDialog(statusCode: statusCode);
    } else {
      NetworkDialogs.show400ErrorDialog(statusCode: statusCode);
    }
    await Sentry.captureException(
      'network error on $method',
      stackTrace: 'response code: $statusCode',
    );

    log('failure on $method status code: $statusCode');

    throw HttpException;
  }

  static Future<void> handleNoConnection({required String method}) async {
    NetworkDialogs.showNoConnectionDialog();
    await Sentry.captureException(
      '$method attempted with no connection',
    );
  }

  static Future<void> logUnknownException({
    required String error,
    required String method,
  }) async {
    final message = 'Exception error: $error on method $method';
    log(message);
    await Sentry.captureException(message);
  }

/* -------------------------------------------------------------------------- */
/*                               LOCATION ERRORS                              */
/* -------------------------------------------------------------------------- */

// TODO: REFACTOR ENTIRE APP TO FIRE DIALOGS FROM UI AND PASS IN REGULAR BUILD CONTEXT
  static Future<void> handleLocationTurnedOff() async {
    LocationDialogs.showLocationTurnedOffDialog(Get.context!);
    await Sentry.captureException(
      '_getLocation attempted with location services disabled',
    );
  }

  static Future<void> handleLocationTimeout({
    required String message,
    required bool isTimeout,
  }) async {
    log(message);
    LocationDialogs.showLocationTimeoutDialog(Get.context!);
    if (isTimeout) {
      await Sentry.captureException(
        'location timeout on GeoLocation.getCurrentPosition error: $message',
      );
    } else {
      await Sentry.captureException(
        'unhandled exception on GeoLocation.getCurrentPosition error: $message',
      );
    }
  }

  static Future<void> reportNoAddressInfoFoundToSentry({
    required String endResult,
  }) async {
    await Sentry.captureException(
      'Platform exception on getLocationAndAddress. Failed to find address from coordinates. End result: $endResult',
    );
  }

/* -------------------------------------------------------------------------- */
/*                              PERMISSION ERRORS                             */
/* -------------------------------------------------------------------------- */

  static Future<void> handleLocationPermissionDenied() async {
    await Sentry.captureException(
      '_getLocation attempted with permission denied',
    );
  }

/* -------------------------------------------------------------------------- */
/*                                 FILE ERRORS                                */
/* -------------------------------------------------------------------------- */

  static Future<void> handleRestoreImageFileError({
    required String error,
  }) async {
    await Sentry.captureException(
      'error on FileController restoreImageFile function: $error',
    );
  }

  static Future<void> handleStoreImageToAppDirectoryError({
    required String error,
  }) async {
    await Sentry.captureException(
      'FirebaseException error on FirestoreDatabase controller storeImageToAppDirectoryError function: $error',
    );
  }

  static Future<void> handleInvalidPathToUpdateTextAndContainerColors({
    required String error,
  }) async {
    await Sentry.captureException(error);
  }

/* -------------------------------------------------------------------------- */
/*                              FIRESTORE ERRORS                              */
/* -------------------------------------------------------------------------- */
  static Future<void> handleFetchFirebaseImagesAndStoreLocallyError({
    required String error,
  }) async {
    await Sentry.captureException(
      'error on FirestoreDatabase controller FetchFirebaseImagesAndStoreLocally function: $error',
    );
  }
}
