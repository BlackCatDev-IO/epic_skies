import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DayLabelRow extends StatelessWidget {
  final Function scrollToIndex;
  final ItemScrollController? itemScrollController;

  const DayLabelRow({required this.scrollToIndex, this.itemScrollController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[0],
          onTap: () {
            scrollToIndex(0);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[1],
          onTap: () {
            scrollToIndex(1);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[2],
          onTap: () {
            scrollToIndex(2);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[3],
          onTap: () {
            scrollToIndex(3);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[4],
          onTap: () {
            scrollToIndex(4);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[5],
          onTap: () {
            scrollToIndex(5);
          },
        ),
        DayLabelWidget(
          day: DailyForecastController.to.dayLabelList[6],
          onTap: () {
            scrollToIndex(6);
          },
        ),
      ],
    ).paddingSymmetric(vertical: 10);
  }
}

class DayLabelWidget extends StatelessWidget {
  final String? day;
  final Function? onTap;

  const DayLabelWidget({Key? key, required this.day, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: RoundedContainer(
        color: Colors.black54,
        height: 30,
        child: MyTextWidget(text: day!, fontSize: 17).center(),
      ),
    ).paddingSymmetric(horizontal: 3).expanded();
  }
}
