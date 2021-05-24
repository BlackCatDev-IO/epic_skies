import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class DayLabelRow extends GetView<DailyForecastController> {
  final Function scrollToIndex;

  const DayLabelRow({required this.scrollToIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DayLabelWidget(
          day: controller.dayLabelList[0],
          index: 0,
          onTap: () {
            scrollToIndex(0);
            controller.updateSelectedDayStatus(0);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[1],
          index: 1,
          onTap: () {
            scrollToIndex(1);
            controller.updateSelectedDayStatus(1);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[2],
          index: 2,
          onTap: () {
            scrollToIndex(2);
            controller.updateSelectedDayStatus(2);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[3],
          index: 3,
          onTap: () {
            scrollToIndex(3);
            controller.updateSelectedDayStatus(3);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[4],
          index: 4,
          onTap: () {
            scrollToIndex(4);
            controller.updateSelectedDayStatus(4);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[5],
          index: 5,
          onTap: () {
            scrollToIndex(5);
            controller.updateSelectedDayStatus(5);
          },
        ),
        DayLabelWidget(
          day: controller.dayLabelList[6],
          index: 6,
          onTap: () {
            scrollToIndex(6);
            controller.updateSelectedDayStatus(6);
          },
        ),
      ],
    ).paddingOnly(bottom: 5);
  }
}

class DayLabelWidget extends GetView<DailyForecastController> {
  final String day;
  final Function onTap;
  final int index;

  const DayLabelWidget(
      {required this.day, required this.onTap, required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: GetBuilder<DailyForecastController>(
        builder: (_) {
          return RoundedContainer(
            color: Colors.black54,
            borderColor: controller.selectedDayList[index]
                ? Colors.blue[100]
                : Colors.transparent,
            height: 30,
            child: MyTextWidget(text: day, fontSize: 17).center(),
          );
        },
      ),
    ).paddingSymmetric(horizontal: 3).expanded();
  }
}
