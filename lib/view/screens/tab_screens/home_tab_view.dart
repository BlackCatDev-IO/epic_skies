import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/general/my_app_bar.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'current_weather_page.dart';
import 'daily_forecast_page.dart';
import 'hourly_forecast_page.dart';
import 'saved_locations_screen.dart';

class HomeTabView extends GetView<TabNavigationController> {
  static const id = '/home_tab_controller';

  final List<Widget> _tabs = [
    CurrentWeatherPage(),
    HourlyForecastPage(),
    DailyForecastPage(),
    SavedLocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.tabController.index == 0) {
          return true;
        } else {
          controller.jumpToTab(index: 0);
          return false;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const EpicSkiesAppBar(),
        body: WeatherImageContainer(
          child: TabBarView(
            controller: controller.tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const AlwaysScrollableScrollPhysics(),
            children: _tabs,
          ),
        ),
      ),
    );
  }
}
