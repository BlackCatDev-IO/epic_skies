import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlatformDependentAppBar extends GetView<ViewController>
    with PreferredSizeWidget {
  final TabController tabController;

  const PlatformDependentAppBar({required this.tabController});
  @override
  Widget build(BuildContext context) {
    if (controller.iPhoneHasNotch) {
      return MyAppBar(tabController: tabController);
    } else {
      return SafeArea(child: MyAppBar(tabController: tabController));
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(controller.appBarHeight);
}

class MyAppBar extends StatelessWidget {
  final TabController tabController;

  const MyAppBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (controller) => AppBar(
        bottom: epicTabBar(tabController) as PreferredSizeWidget,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: controller.animationController.forward,
            color: controller.animation.value),
        toolbarHeight: screenHeight * 0.17,
        backgroundColor: controller.appBarColor,
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () => Get.to(() => const CustomSearchDelegate(),
                  binding: SearchControllerBinding()),
            ).paddingOnly(right: 20),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 15.0,
        title: BlurFilter(
          sigmaX: 0.20,
          sigmaY: 0.20,
          child: const MyTextWidget(
            text: 'Epic Skies',
            fontSize: 45,
            color: Colors.blueGrey,
            fontFamily: 'OpenSans',
            spacing: 7,
          ).paddingOnly(top: 15),
        ),
      ),
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
    title: BlurFilter(
      sigmaX: 0.20,
      sigmaY: 0.20,
      child: Column(
        children: [
          MyTextWidget(
            text: label,
            fontSize: 40,
            color: Colors.blueGrey[500],
            fontWeight: FontWeight.w200,
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
        fontSize: 15,
        color: Colors.white60,
      ),
    );
