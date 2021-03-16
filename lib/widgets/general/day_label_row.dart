import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class DayLabelRow extends StatelessWidget {
  final Function onTap;

  const DayLabelRow({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecastController = Get.find<DailyForecastController>();
    final viewController = Get.find<ViewController>();
    return Row(
      children: [
        DayLabelWidget(
          day: forecastController.dayLabelList[0],
          onTap: () {
            viewController.scrollToIndex(0);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[1],
          onTap: () {
            viewController.scrollToIndex(1);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[2],
          onTap: () {
            viewController.scrollToIndex(2);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[3],
          onTap: () {
            viewController.scrollToIndex(3);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[4],
          onTap: () {
            viewController.scrollToIndex(4);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[5],
          onTap: () {
            viewController.scrollToIndex(5);
          },
        ),
        DayLabelWidget(
          day: forecastController.dayLabelList[6],
          onTap: () {
            viewController.scrollToIndex(6);
          },
        ),
      ],
    ).paddingSymmetric(vertical: 10);
  }
}

class DayLabelWidget extends StatelessWidget {
  final String day;
  final Function onTap;

  const DayLabelWidget({Key key, @required this.day, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: RoundedContainer(
        color: Colors.black54,
        height: 30,
        child: MyTextWidget(text: day, fontSize: 17).center(),
      ),
    ).paddingSymmetric(horizontal: 3).expanded();
  }
}
