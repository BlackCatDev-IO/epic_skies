// import 'package:flutter/material.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController textController;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    textController.addListener(() {
      debugPrint(textController.text);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
