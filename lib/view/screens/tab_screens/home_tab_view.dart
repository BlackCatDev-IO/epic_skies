import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/my_app_bar.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'current_weather_page.dart';
import 'daily_forecast_page.dart';
import 'hourly_forecast_page.dart';
import 'saved_locations_screen.dart';

class HomeTabView extends StatelessWidget {
  static const id = 'home_tab_controller';

  final List<Widget> _tabs = [
    CurrentWeatherPage(),
    HourlyForecastPage(),
    DailyForecastPage(),
    SavedLocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PlatformDependentAppBar(tabController: ViewController.to.tabController),
      body: WeatherImageContainer(
        child: TabBarView(
          controller: ViewController.to.tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const AlwaysScrollableScrollPhysics(),
          children: _tabs,
        ),
      ),
    );
  }
}
