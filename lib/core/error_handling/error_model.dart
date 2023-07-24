import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class ErrorModel extends Equatable {
  const ErrorModel({
    required this.title,
    required this.message,
  });
  factory ErrorModel.fromException(Exception exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return Errors.networkErrorModel;
      case NoConnectionException:
        return Errors.noNetworkErrorModel;
      case ServerErrorException:
        return Errors.serverErrorModel;
      case LocationException:
        return Errors.locationErrorModel;
      case LocationTimeOutException:
        return Errors.locationTimeoutErrorModel;
      case LocationNoPermissionException:
        return Errors.locationPermissionErrorModel;
      case LocationServiceDisabledException:
        return Errors.locationServiceDisabledErrorModel;
      case NoAddressInfoFoundException:
        return Errors.noAddressInfoFoundModel;
      default:
        return Errors.networkErrorModel;
    }
  }

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  @override
  String toString() {
    return 'ErrorModel(title: $title, message: $message)';
  }
}
