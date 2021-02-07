import 'package:epic_skies/services/utils/tab_controller.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/general/settings_drawer.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabView extends StatelessWidget {
  static const id = 'home_tab_controller';

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.find<TabBarController>();
    return DefaultTabController(
      length: tabBarController.tabs.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: SettingsDrawer(),
        appBar: appBarNoBackButton(tabBarController.tabController),
        body: WeatherImageContainer(
          child: TabBarView(
            controller: tabBarController.tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: AlwaysScrollableScrollPhysics(),
            children: tabBarController.tabs,
          ),
        ),
      ),
    );
  }
}
