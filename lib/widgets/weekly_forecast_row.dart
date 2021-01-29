import 'package:epic_skies/screens/hourly_forecast_page.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class WeeklyForecastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HourlyForecastPage());
      },
      child: forecastRowWidget(),
    );
  }

  Widget forecastRowWidget() {
    return Card(
      color: Colors.black54,
      elevation: 10,
      child: Column(
        children: [
            RoundedContainer(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTextWidget(
                    text: 'Next Week',
                    color: Colors.white54,
                    fontSize: 16,
                    spacing: 5,
                  )
                ],
              ),
            ),
          RoundedContainer(
            height: screenHeight * .22,
            child: GetX<ForecastController>(
              builder: (controller) {
                if (controller.dayColumnList == null) {
                  Get.snackbar('Null list', "you're fucked");
                  throw 'Null dayColumnList';
                }
                return Row(children: controller.dayColumnList);
              },
            ).paddingSymmetric(vertical: 10),
          ).paddingOnly(top: 10),
        ],
      ),
    );
  }
}

class DayColumn extends StatelessWidget {
  final String day;
  final String temp;
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
        MyTextWidget(text: temp).expanded(),
        Image(
          width: 40,
          image: AssetImage(
              iconPath ?? 'assets/icons/vclouds_icons/moon_with_cloud.png'),
          // color: null,
          // color: Colors.black,
        ).expanded(),
      ],
    ).expanded();
  }
}
