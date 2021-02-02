import 'package:epic_skies/screens/daily_forecast_page.dart';
import 'package:epic_skies/services/utils/tab_controller.dart';
import 'package:epic_skies/widgets/my_app_bar.dart';
import 'package:epic_skies/widgets/settings_drawer.dart';
import 'package:epic_skies/widgets/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';
import 'hourly_forecast_page.dart';
import 'location_screen.dart';

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
    Tab(child: DailyForecastPage()),
    Tab(child: SavedLocationScreen()),
  ];

  TabController _tabController = Get.find<TabBarController>().tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: SettingsDrawer(),
        appBar: appBarNoBackButton(_tabController),
        body: WeatherImageContainer(
          child: TabBarView(
            controller: _tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: AlwaysScrollableScrollPhysics(),
            children: _tabs,
          ),
        ),
      ),
    );
  }
}
