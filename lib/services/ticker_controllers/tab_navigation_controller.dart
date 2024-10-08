import 'package:epic_skies/services/analytics/analytics_service.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:flutter/material.dart';

class TabNavigationController {
  TabNavigationController({required this.tabController}) {
    _initTabListener();
  }

  final TabController tabController;

  int currentIndex = 0;

  void _initTabListener() {
    tabController.addListener(() {
      if (tabController.index != currentIndex) {
        currentIndex = tabController.index;

        final tabRoute = switch (currentIndex) {
          0 => 'home',
          1 => 'hourly',
          2 => 'daily',
          3 => 'saved_locations',
          _ => 'home',
        };

        getIt<AnalyticsService>().trackEvent(
          'tab_$tabRoute',
          isPageView: true,
        );
      }
    });
  }

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
