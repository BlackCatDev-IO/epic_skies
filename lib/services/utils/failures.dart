import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailureHandler {
  const FailureHandler();

  void checkNetworkConnection() async {
    bool hasConnection = await DataConnectionChecker().hasConnection;
    if (!hasConnection) {
      debugPrint('Connection result: $hasConnection');
      // Get.snackbar('no internet fucko', 'is this the title');
      Get.dialog(MyDialog());
      throw SocketException;
    }
  }

  void handleError(int statusCode) {}

  void handleNoConnection() {}
}

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyTextWidget(text: 'Fah Q brah'),
    );
  }
}
