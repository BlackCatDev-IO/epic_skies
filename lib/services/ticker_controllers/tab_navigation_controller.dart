import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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

        var tabRoute = 'home';

        switch (currentIndex) {
          case 0:
            break;
          case 1:
            tabRoute = 'hourly';
            break;
          case 2:
            tabRoute = 'daily';
            break;
          case 3:
            tabRoute = 'saved_locations';
            break;
        }

        GetIt.I<AnalyticsBloc>().add(NavigationEvent(route: 'tab_$tabRoute'));
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
