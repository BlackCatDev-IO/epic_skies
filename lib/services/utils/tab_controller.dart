import 'package:epic_skies/screens/daily_forecast_page.dart';
import 'package:epic_skies/screens/home_page.dart';
import 'package:epic_skies/screens/hourly_forecast_page.dart';
import 'package:epic_skies/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController with SingleGetTickerProviderMixin{
  TabController tabController;

    final List<Tab> tabs = <Tab>[
    Tab(child: HomePage()),
    Tab(child: HourlyForecastPage()),
    Tab(child: DailyForecastPage()),
    Tab(child: SavedLocationScreen()),
  ];

  void animateTo(int page) {
    tabController.animateTo(page);
  }

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(vsync: this, length: tabs.length);
  }

    @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
