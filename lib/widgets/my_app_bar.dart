import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hourly_forecast_row.dart';

AppBar appBarNoBackButton() {
  return AppBar(
    bottom: TabBar(
      tabs: [
        weatherTab('Home'),
        weatherTab('24 Hrs'),
      ],
    ),
    backgroundColor: Colors.black54,
    centerTitle: true,
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.search,
            size: 25,
          ),
          onPressed: () {
            Get.find<ForecastController>()
                .hourRowList
                .add(const HourlyDetailedRow());
          },
        ).paddingOnly(right: 20),
      ),
    ],
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    elevation: 15.0,
    title: BlurFilter(
      sigmaX: 0.20,
      sigmaY: 0.20,
      child: MyTextWidget(
        text: 'E p i c   S k i e s',
        fontSize: 37,
        color: Colors.blueGrey[500],
      ),
    ),
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
