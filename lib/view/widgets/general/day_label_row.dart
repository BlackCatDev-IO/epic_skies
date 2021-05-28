import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class DayLabelRow extends GetView<DailyForecastController> {
  final Function scrollToIndex;
  final bool isThisWeek;

  const DayLabelRow({required this.scrollToIndex, required this.isThisWeek});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DayLabelWidget(
          day: controller.dayLabelList[0],
          index: 0,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[1],
          index: 1,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[2],
          index: 2,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[3],
          index: 3,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[4],
          index: 4,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[5],
          index: 5,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
        DayLabelWidget(
          day: controller.dayLabelList[6],
          index: 6,
          isThisWeek: isThisWeek,
          scrollToIndex: scrollToIndex,
        ),
      ],
    ).paddingOnly(bottom: 5);
  }
}

class DayLabelWidget extends GetView<DailyForecastController> {
  final String day;
  final Function scrollToIndex;
  final int index;
  final bool isThisWeek;

  const DayLabelWidget(
      {required this.isThisWeek,
      required this.day,
      required this.scrollToIndex,
      required this.index});
  @override
  Widget build(BuildContext context) {
    final newIndex = isThisWeek ? index : index + 7;

    return GestureDetector(
      onTap: () {
        scrollToIndex(newIndex);
        controller.updateSelectedDayStatus(newIndex);
      },
      child: GetBuilder<DailyForecastController>(
        builder: (_) {
          return RoundedContainer(
            color: Colors.black54,
            borderColor: controller.selectedDayList[newIndex]
                ? Colors.blue[100]
                : Colors.transparent,
            height: 30,
            child: MyTextWidget(text: day, fontSize: 17).center(),
          );
        },
      ),
    ).paddingSymmetric(horizontal: 3, vertical: 3).expanded();
  }
}
