class NetworkException implements Exception {}

class NoConnectionException implements Exception {}

class ServerErrorException implements Exception {}

class LocationException implements Exception {}

class LocationTimeOutException implements Exception {
  LocationTimeOutException(this.message);

  final String message;

  @override
  String toString() => message;
}

class LocationNoPermissionException implements Exception {}

class NoAddressInfoFoundException implements Exception {}

class AddressFormatException implements Exception {}

class WeatherKitFailureException implements Exception {
  WeatherKitFailureException(this.message);

  final String message;

  @override
  String toString() => message;
}

class EpicSkiesApiException implements Exception {
  EpicSkiesApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
