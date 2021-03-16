import 'package:epic_skies/screens/forecast_screens/daily_forecast_page.dart';
import 'package:epic_skies/screens/forecast_screens/hourly_forecast_page.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'location_screen.dart';

class HomeTabView extends StatelessWidget {
  static const id = 'home_tab_controller';

  final List<Widget> tabs = [
    HomePage(),
    HourlyForecastPage(),
    DailyForecastPage(),
    SavedLocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.find<ViewController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: myAppBar(tabBarController.tabController),
      body: WeatherImageContainer(
        child: TabBarView(
          controller: tabBarController.tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const AlwaysScrollableScrollPhysics(),
          children: tabs,
        ),
      ),
    );
  }
}
