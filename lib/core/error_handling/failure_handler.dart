import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';

class FailureHandler {
  FailureHandler._();
/* -------------------------------------------------------------------------- */
/*                               NETWORK ERRORS                               */
/* -------------------------------------------------------------------------- */

  static Future<void> logUnknownException({
    required String error,
    required String method,
  }) async {
    final message = 'Exception error: $error on method $method';
    log(message);
    await Sentry.captureException(message);
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
