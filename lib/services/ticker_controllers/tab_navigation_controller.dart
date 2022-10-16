import 'package:epic_skies/services/ticker_controllers/ticker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/screens/tab_screens/home_tab_view.dart';

class TabNavigationController extends GetXTickerController {
  static TabNavigationController get to => Get.find();

  late TabController tabController;

  void navigateToHome() {
    if (Get.currentRoute != HomeTabView.id) {
      Get.until((route) => Get.currentRoute == HomeTabView.id);
    }
    Get.back(closeOverlays: true);
    TabNavigationController.to.jumpToTab(index: 0);
  }

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

  bool overrideAndroidBackButton(BuildContext context) {
    final isOnSettingsPages = Scaffold.of(context).isDrawerOpen;
    if (isOnSettingsPages) {
      navigateToHome();
      return false;
    } else {
      if (tabController.index == 0) {
        return true;
      } else {
        jumpToTab(index: 0);
        return false;
      }
    }
  }
}
