import 'package:epic_skies/core/error_handling/error_model.dart';

class Errors {
/* ------------------------------ Network Error ----------------------------- */
  static const networkErrorMessage =
      'A network error occured. Please try again.';

  static const networkErrorTitle = 'Network error';

  static const networkErrorModel = ErrorModel(
    title: networkErrorTitle,
    message: networkErrorMessage,
  );

/* ------------------------------ Server Error ------------------------------ */
  static const serverErrorMessage =
      '''The weather data provider has encountered a server error. The developer is aware and is contact with them. Please try again shortly.''';

  static const serverErrorTitle = 'Server Error';

  static const serverErrorModel = ErrorModel(
    title: serverErrorTitle,
    message: serverErrorMessage,
  );

/* ----------------------- No Network Connection Error ---------------------- */

  static const noNetworkErrorTitle = 'No Network Connection';

  static const noNetworkErrorMessage =
      'Epic Skies needs an internet connection to pull weather data';

  static const noNetworkErrorModel = ErrorModel(
    title: noNetworkErrorTitle,
    message: noNetworkErrorMessage,
  );

/* ----------------------------- Location Error ----------------------------- */

  static const locationErrorTitle = 'Location Error';

  static const locationErrorMessage = 'An unknown exception occurred.';

  static const locationErrorModel = ErrorModel(
    title: locationErrorTitle,
    message: locationErrorMessage,
  );

/* ------------------------- Location Timeout Error ------------------------- */

  static const locationTimeoutErrorTitle = 'Check Location Settings';

  static const locationTimeoutErrorMessage =
      '''An error occurred while attempting to access your current location. Please try again.''';

  static const locationTimeoutErrorModel = ErrorModel(
    title: locationTimeoutErrorTitle,
    message: locationTimeoutErrorMessage,
  );

/* ------------------------ Location Permission Error ----------------------- */

  static const locationPermissionErrorTitle = 'Location Permission Disabled';

  static const locationPermissionErrorMessage =
      '''Please enable location permissions for Epic Skies so you can see your local weather forecast.''';

  static const locationPermissionErrorModel = ErrorModel(
    title: locationPermissionErrorTitle,
    message: locationPermissionErrorMessage,
  );

/* --------------------- Location Service Disabled Error -------------------- */

  static const locationServiceDisabledErrorTitle = 'Check Location Settings';

  static const locationServiceDisabledErrorMessage =
      'Please turn on GPS so Epic Skies can get your local weather forecast.';

  static const locationServiceDisabledErrorModel = ErrorModel(
    title: locationServiceDisabledErrorTitle,
    message: locationServiceDisabledErrorMessage,
  );

/* ----------------------- No Address Info Found Error ---------------------- */

  static const noAddressInfoFoundErrorTitle = 'Location Error';

  static const noAddressInfoFoundErrorMessage =
      'There was an error getting your current location, please try again.';

  static const noAddressInfoFoundModel = ErrorModel(
    title: noAddressInfoFoundErrorTitle,
    message: noAddressInfoFoundErrorMessage,
  );

/* ------------------------- AdFree Purchase Errors ------------------------- */

  static const adPurchaseError =
      'There was an error purchasing ad free. Please try again';

  static const adPurchaseCanceled = 'Your purchase has been canceled';
}
