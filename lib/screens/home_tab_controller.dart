import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:epic_skies/widgets/my_app_bar.dart';
import 'package:epic_skies/widgets/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';
import 'hourly_forecast_page.dart';

class HomeTabController extends StatefulWidget {
  static const id = 'home_tab_controller';
  @override
  _HomeTabControllerState createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(child: HomePage()),
    Tab(child: HourlyForecastPage()),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    // Get.find<WeatherController>().getAllWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBarNoBackButton(),
        body: WeatherImageContainer(
          child: TabBarView(
            controller: _tabController,
            dragStartBehavior: DragStartBehavior.down,
            children: _tabs,
          ),
        ),
      ),
    );
  }
}
