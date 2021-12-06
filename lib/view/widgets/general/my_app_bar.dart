import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/screens/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'notch_dependent_safe_area.dart';

class EpicSkiesAppBar extends GetView<DrawerAnimationController>
    with PreferredSizeWidget {
  const EpicSkiesAppBar();
  @override
  Widget build(BuildContext context) {
    return NotchDependentSafeArea(
      child: GetBuilder<ColorController>(
        id: 'app_bar',
        builder: (colorController) => AppBar(
          bottom: const EpicTabBar(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white38),
            onPressed: controller.animationController.forward,
            color: controller.drawerIconColorAnimation.value,
          ),
          toolbarHeight: 30.h,
          backgroundColor: colorController.theme.appBarColor,
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () => Get.to(
                  () => const CustomSearchDelegate(),
                  binding: SearchControllerBinding(),
                ),
              ).paddingOnly(right: 20),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white38),
          elevation: 15.0,
          title: const EpicSkiesHeader(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(StorageController.to.appBarHeight().h);
}

class EpicTabBar extends GetView<TabNavigationController>
    with PreferredSizeWidget {
  const EpicTabBar();

  @override
  Size get preferredSize =>
      Size.fromHeight(StorageController.to.appBarHeight().h);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller.tabController,
      tabs: const [
        WeatherTab(tabTitle: 'Home'),
        WeatherTab(tabTitle: 'Hourly'),
        WeatherTab(tabTitle: 'Daily'),
        WeatherTab(tabTitle: 'Locations'),
      ],
    );
  }
}

class WeatherTab extends StatelessWidget {
  final String tabTitle;
  const WeatherTab({required this.tabTitle});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: GetBuilder<ColorController>(
        builder: (controller) {
          return MyTextWidget(
            text: tabTitle,
            fontSize: 10.sp,
            color: controller.theme.tabTitleColor,
          );
        },
      ),
    );
  }
}

class EpicSkiesHeader extends StatelessWidget {
  const EpicSkiesHeader();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextWidget(
              text: 'Epic ',
              fontSize: 30.sp,
              color: controller.theme.epicSkiesHeaderFontColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            MyTextWidget(
              text: 'Skies',
              fontSize: 30.sp,
              color: controller.theme.epicSkiesHeaderFontColor,
              fontWeight: FontWeight.w100,
              fontFamily: 'Montserrat',
            ),
          ],
        ).paddingOnly(top: 15);
      },
    );
  }
}

AppBar settingsAppBar({required String label, required bool backButtonShown}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: backButtonShown,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    elevation: 15.0,
    title: MyTextWidget(
      text: label,
      fontSize: 28.sp,
      color: Colors.blueGrey[500],
      fontWeight: FontWeight.w200,
    ),
  );
}
