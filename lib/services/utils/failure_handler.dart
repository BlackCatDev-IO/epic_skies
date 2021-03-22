
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailureHandler extends GetxController {
  static FailureHandler get to => Get.find();

  void handleHttpError(int statusCode) {}

  void handleNoConnection() {}

 
  void handleLocationTurnedOff() {
    showLocationTurnedOffDialog(context: Get.context);
  }
}

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyTextWidget(text: 'Fah Q brah'),
    );
  }
}
