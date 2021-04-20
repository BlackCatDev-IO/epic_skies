import 'dart:io';

import 'package:epic_skies/global/alert_dialogs/search_dialogs.dart';
import 'package:epic_skies/global/alert_dialogs/error_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailureHandler extends GetxController {
  static FailureHandler get to => Get.find();

// TODO: Finish handling these errors

  void handleHttpError(int statusCode) {
    // TODO: UI hangs when this happens, fix it
    debugPrint('getWeatherData error code $statusCode');
    throw HttpException;
  }

  void handleNoConnection() {}

  void handleNon200Response(int statusCode) {
    throw Exception('Failed to fetch suggestion response: $statusCode');
  }

  void handleLocationTurnedOff() {
    showLocationTurnedOffDialog(context: Get.context);
  }

  void handleFailedPlaceDetailsSearch(int statusCode) {
    debugPrint('failed status code from getPlaceDetailsFromId: $statusCode');
    throw Exception('Failed to fetch suggestion');
  }
}
