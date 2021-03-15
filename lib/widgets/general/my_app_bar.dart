import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar myAppBar(TabController tabController) {
  return AppBar(
    bottom: epicTabBar(tabController),
    automaticallyImplyLeading: false,
    toolbarHeight: 120,
    backgroundColor: Colors.black38,
    centerTitle: true,
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.search,
            size: 25,
          ),
          onPressed: () {
            Get.find<SearchController>().showSearchSuggestions();
          },
        ).paddingOnly(right: 20),
      ),
    ],
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    elevation: 15.0,
    title: BlurFilter(
      sigmaX: 0.20,
      sigmaY: 0.20,
      child: Column(
        children: [
          MyTextWidget(
            text: 'Epic Skies',
            fontSize: 40,
            color: Colors.blueGrey[500],
            spacing: 7,
          ).paddingOnly(top: 15),
        ],
      ),
    ),
  );
}

AppBar settingsAppBar({@required String label}) {
  return AppBar(
    toolbarHeight: 120,
    backgroundColor: Colors.black38,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    elevation: 15.0,
    title: BlurFilter(
      sigmaX: 0.20,
      sigmaY: 0.20,
      child: Column(
        children: [
          MyTextWidget(
            text: label,
            fontSize: 40,
            color: Colors.blueGrey[500],
            spacing: 7,
          ).paddingOnly(top: 15),
        ],
      ),
    ),
  );
}

Widget epicTabBar([TabController tabController]) {
  return TabBar(
    controller: tabController,
    tabs: [
      weatherTab('Home'),
      weatherTab('Hourly'),
      weatherTab('Daily'),
      weatherTab('Locations'),
    ],
  );
}

Widget weatherTab(String title) => Tab(
      child: MyTextWidget(
        text: title ?? 'FahQ',
        fontSize: 17,
        color: Colors.white60,
      ),
    );

AppBar appBarWithBackButton() {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
    ],
    iconTheme: IconThemeData(color: Colors.blue[600]),
    leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        }),
    elevation: 15.0,
  );
}
