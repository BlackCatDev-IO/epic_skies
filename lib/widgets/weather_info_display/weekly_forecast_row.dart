import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class WeeklyForecastRow extends GetView<DailyForecastController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewController.to.tabController.animateTo(2);
      },
      child: forecastRowWidget(),
    );
  }

  Widget forecastRowWidget() {
    return GetBuilder<ColorController>(
      builder: (colorController) => MyCard(
        color: colorController.soloCardColor,
        elevation: 10,
        radius: 10,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MyTextWidget(
                    text: 'Next Week',
                    color: Colors.white54,
                    fontSize: 16,
                    spacing: 5,
                  )
                ],
              ),
            ),
            Container(
              height: screenHeight * .22,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: GetBuilder<DailyForecastController>(
                builder: (_) {
                  return Row(children: controller.dayColumnList);
                },
              ),
            ).paddingSymmetric(vertical: 10).paddingOnly(top: 10),
          ],
        ),
      ),
    );
  }
}

class DayColumn extends StatelessWidget {
  final String day;
  final int temp;
  final String iconPath;

  const DayColumn({Key key, this.day, this.temp, this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: day,
          fontSize: 16,
          color: Colors.blueGrey[400],
        ).expanded(),
        MyTextWidget(text: '$temp').expanded(),
        Image(
          width: 40,
          image: AssetImage(
              iconPath ?? 'assets/icons/vclouds_icons/moon_with_cloud.png'),
        ).expanded(),
      ],
    ).expanded();
  }
}
