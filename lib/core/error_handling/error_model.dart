import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:geolocator/geolocator.dart';

part 'error_model.mapper.dart';

@MappableClass()
class ErrorModel with ErrorModelMappable {
  const ErrorModel({
    required this.title,
    required this.message,
  });

  factory ErrorModel.fromException(Exception exception) {
    return switch (exception.runtimeType) {
      NetworkException => Errors.networkErrorModel,
      NoConnectionException => Errors.noNetworkErrorModel,
      ServerErrorException => Errors.serverErrorModel,
      LocationException => Errors.locationErrorModel,
      LocationTimeOutException => Errors.locationTimeoutErrorModel,
      LocationNoPermissionException => Errors.locationPermissionErrorModel,
      LocationServiceDisabledException =>
        Errors.locationServiceDisabledErrorModel,
      NoAddressInfoFoundException => Errors.noAddressInfoFoundModel,
      _ => Errors.networkErrorModel
    };
  }

  final String title;
  final String message;

  @override
  String toString() {
    return 'ErrorModel(title: $title, message: $message)';
  }
}
