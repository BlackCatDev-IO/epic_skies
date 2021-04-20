import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PlatformDependentAppBar extends StatelessWidget with PreferredSizeWidget {
  final TabController tabController;

  const PlatformDependentAppBar({required this.tabController});
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return MyAppBar(tabController: tabController);
    } else {
      return SafeArea(child: MyAppBar(tabController: tabController));
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.17);
}

class MyAppBar extends StatelessWidget {
  final TabController tabController;

  const MyAppBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) => AppBar(
        bottom: epicTabBar(tabController) as PreferredSizeWidget,
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.17,
        backgroundColor: controller.appBarColor,
        centerTitle: true,
        brightness: Brightness.light,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                SearchController.to.goToSearchPage();
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
      ),
    );
  }
}

AppBar settingsAppBar({required String label, bool? backButtonShown}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: backButtonShown ?? true,
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
          ),
        ],
      ),
    ),
  );
}

Widget epicTabBar([TabController? tabController]) {
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
        text: title,
        fontSize: 17,
        color: Colors.white60,
      ),
    );
