import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_scroll_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyScrollWidget extends StatelessWidget {
  final List list;
  final String title;
  final bool layeredCard;
  const HourlyScrollWidget(
      {required this.list, required this.title, required this.layeredCard});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HourlyForecastController>(
      builder: (_) => MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextWidget(
                    text: title,
                    color: Colors.white54,
                    fontSize: 16,
                    spacing: 5,
                  )
                ],
              ),
            ),
            GetBuilder<ViewController>(
              builder: (controller) => Container(
                height: ViewController.to.forecastWidgetHeight,
                decoration: BoxDecoration(
                  color: layeredCard
                      ? controller.layeredCardColor
                      : controller.soloCardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: MyScrollbar(
                  builder: (context, scrollController) => ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return list[index] as Widget;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
