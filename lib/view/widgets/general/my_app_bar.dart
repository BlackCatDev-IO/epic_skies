import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../services/view_controllers/adaptive_layout_controller.dart';
import '../../screens/tab_screens/home_tab_view.dart';

class EpicSkiesAppBar extends StatelessWidget with PreferredSizeWidget {
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
            onPressed: () => Scaffold.of(context).openDrawer(),
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
                onPressed: () => Navigator.of(context).pushNamed(
                  SearchScreen.id,
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
      Size.fromHeight(GetIt.instance<AdaptiveLayout>().appBarPadding.h);
}

class EpicTabBar extends GetView<TabNavigationController>
    with PreferredSizeWidget {
  const EpicTabBar();

  @override
  Size get preferredSize =>
      Size.fromHeight(GetIt.instance<AdaptiveLayout>().appBarPadding.h);
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
    automaticallyImplyLeading:
        !(Get.currentRoute == HomeTabView.id) && backButtonShown,
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
