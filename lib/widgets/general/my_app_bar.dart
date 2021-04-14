import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final TabController tabController;

  const MyAppBar({Key key, this.tabController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) => AppBar(
        bottom: epicTabBar(tabController) as PreferredSizeWidget,
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.17,
        backgroundColor: controller.appBarColor,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
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

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.17);
}

AppBar settingsAppBar({@required String label, bool backButtonShown}) {
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
