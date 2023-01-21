class NetworkException implements Exception {
  const NetworkException({
    this.message = 'An unknown exception occurred.',
    this.statusCode,
    this.title = 'Network error',
  });

  final int? statusCode;

  final String message;

  final String title;
}

class NoConnectionException implements NetworkException {
  NoConnectionException({
    this.title = 'No Network Connection',
    this.message =
        'Epic Skies needs an internet connection to pull weather data',
  });

  @override
  final String message;

  @override
  final String title;

  @override
  int? get statusCode => null;
}

class ServerErrorException implements NetworkException {
  ServerErrorException({
    this.message =
        'The weather data provider has encountered a server error. The developer is aware and is contact with them. Please try again shortly.',
    this.title = 'Server Error',
    required this.statusCode,
  });

  @override
  final String message;

  @override
  final String title;

  @override
  final int statusCode;
}

class LocationException implements Exception {
  LocationException({
    this.message = 'An unknown exception occurred.',
    this.title = 'Location Error',
  });

  final String message;
  final String title;
}

class LocationTimeOutException implements LocationException {
  LocationTimeOutException({
    this.message =
        'An error occurred while attempting to access your current location. Please try again.',
    this.title = 'Check Location Settings',
  });

  @override
  final String message;

  @override
  final String title;
}

class LocationNoPermissionException implements LocationException {
  LocationNoPermissionException({
    this.message =
        'Please enable location permissions for Epic Skies so you can see your local weather forecast.',
    this.title = 'Location Permission Disabled',
  });

  @override
  final String message;

  @override
  final String title;
}

class LocationServiceDisableException implements LocationException {
  LocationServiceDisableException({
    this.message =
        'Please turn on GPS so Epic Skies can get your local weather forecast.',
    this.title = 'Check Location Settings',
  });

  @override
  final String message;

  @override
  final String title;
}

class NoAddressInfoFoundException implements LocationException {
  NoAddressInfoFoundException({
    this.message =
        'Please turn on GPS so Epic Skies can get your local weather forecast.',
    this.title = 'Check Location Settings',
  });

  @override
  final String message;

  @override
  final String title;
}
