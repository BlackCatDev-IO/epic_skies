import 'package:flutter/material.dart';

import '../../view/screens/tab_screens/home_tab_view.dart';

class TabNavigationController {
  final TabController tabController;
  TabNavigationController({
    required this.tabController,
  });

  void navigateToHome(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.settings.name == HomeTabView.id);

    jumpToTab(index: 0);
  }

  bool overrideAndroidBackButton(BuildContext context) {
    if (tabController.index == 0) {
      return true;
    } else {
      jumpToTab(index: 0);
      return false;
    }
  }

  Future<void> jumpToTab({required int index}) async {
    tabController.animateTo(index);
  }
}
