import 'package:epic_skies/services/ticker_controllers/ticker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabNavigationController extends GetXTickerController {
  static TabNavigationController get to => Get.find();

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> jumpToTab({required int index}) async {
    tabController.animateTo(index);
  }
}
