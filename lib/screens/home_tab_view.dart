import 'package:epic_skies/services/utils/tab_controller.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/general/settings_drawer.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeTabView extends StatefulWidget {
  static const id = 'home_tab_controller';
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Get.find<TabBarController>().tabs.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: SettingsDrawer(),
        appBar: appBarNoBackButton(Get.find<TabBarController>().tabController),
        body: WeatherImageContainer(
          child: TabBarView(
            controller: Get.find<TabBarController>().tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: AlwaysScrollableScrollPhysics(),
            children: Get.find<TabBarController>().tabs,
          ),
        ),
      ),
    );
  }
}
