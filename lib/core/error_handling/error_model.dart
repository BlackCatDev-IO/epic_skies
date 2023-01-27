import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:equatable/equatable.dart';

import 'error_messages.dart';

class ErrorModel extends Equatable {
  const ErrorModel({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

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
      case LocationServiceDisableException:
        return Errors.locationServiceDisabledErrorModel;
      case NoAddressInfoFoundException:
        return Errors.noAddressInfoFoundModel;
      default:
        return Errors.networkErrorModel;
    }
  }

  @override
  List<Object?> get props => [title, message];
}
