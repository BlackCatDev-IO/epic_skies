import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyNavigationWidget extends GetView<DailyForecastController> {
  final Function onTap;

  const DailyNavigationWidget({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (viewController) => RoundedContainer(
        color: viewController.theme.soloCardColor,
        child: Column(
          children: [
            Row(
              children: [
                for (final model in controller.week1NavButtonList)
                  DailyNavButton(model: model, onTap: onTap)
              ],
            ),
            Row(
              children: [
                for (final model in controller.week2NavButtonList)
                  DailyNavButton(model: model, onTap: onTap)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DailyNavButton extends StatelessWidget {
  final DailyNavButtonModel model;

  final Function onTap;

  const DailyNavButton({
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyForecastController>(
      builder: (controller) => RoundedContainer(
        borderColor: controller.selectedDayList[model.index]
            ? Colors.blue[100]
            : Colors.transparent,
        radius: 12,
        child: GestureDetector(
          onTap: () {
            onTap(model.index);
            controller.updateSelectedDayStatus(model.index);
          },
          child: Column(
            children: [
              sizedBox10High,
              MyTextWidget(
                text: model.day,
                color: Colors.blueAccent[100],
                fontSize: 17,
              ),
              const SizedBox(height: 2),
              MyTextWidget(
                text: '${model.month} ${model.date}',
                fontSize: 13,
                fontWeight: FontWeight.w200,
                color: Colors.yellow[50],
              ),
              sizedBox10High,
            ],
          ),
        ),
      ).expanded(),
    );
  }
}
