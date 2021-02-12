import 'package:epic_skies/screens/daily_forecast_page.dart';
import 'package:epic_skies/screens/home_page.dart';
import 'package:epic_skies/screens/hourly_forecast_page.dart';
import 'package:epic_skies/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(child: HomePage()),
    Tab(child: HourlyForecastPage()),
    Tab(child: DailyForecastPage()),
    Tab(child: SavedLocationScreen()),
  ];

  double alignment = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void scrollToIndex(int index) => itemScrollController.scrollTo(
      index: index,
      alignment: alignment,
      duration: Duration(milliseconds: 200));

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
