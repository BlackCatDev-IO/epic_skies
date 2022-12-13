import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/controllers/daily_forecast_controller.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/view_controllers/scroll_position_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DailyNavigationWidget extends GetView<DailyForecastController> {
  const DailyNavigationWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) {
        return RoundedContainer(
          color: colorController.theme.soloCardColor,
          child: Column(
            children: [
              Row(
                children: controller.week1NavButtonList
                    .map((model) => DailyNavButton(model: model))
                    .toList(),
              ),
              Row(
                children: controller.week2NavButtonList
                    .map((model) => DailyNavButton(model: model))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DailyNavButton extends StatelessWidget {
  const DailyNavButton({required this.model});

  final DailyNavButtonModel model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyForecastController>(
      id: 'daily_nav_button:${model.index}',
      builder: (controller) {
        return RoundedContainer(
          borderColor: controller.selectedDayList[model.index]
              ? Colors.blue[100]
              : Colors.transparent,
          radius: 12,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              ScrollPositionController.to.scrollToIndex(index: model.index);
              controller.updateSelectedDayStatus(newIndex: model.index);
            },
            child: Column(
              children: [
                sizedBox5High,
                MyTextWidget(
                  text: model.day,
                  color: Colors.blueAccent[100],
                  fontSize: 11.sp,
                ),
                MyTextWidget(
                  text: model.month,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.yellow[100],
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                MyTextWidget(
                  text: model.date,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                sizedBox5High,
              ],
            ),
          ),
        ).expanded();
      },
    );
  }
}
