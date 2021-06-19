import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_scroll_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalScrollWidget extends StatelessWidget {
  final List list;
  final bool layeredCard;
  final Widget header;
  const HorizontalScrollWidget(
      {required this.list, required this.layeredCard, required this.header});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HourlyForecastController>(
      builder: (_) => MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            GetBuilder<ViewController>(
              builder: (controller) => PartialRoundedContainer(
                height: ViewController.to.forecastWidgetHeight,
                color: layeredCard
                    ? controller.theme.layeredCardColor
                    : controller.theme.soloCardColor,
                bottomLeft: 10,
                bottomRight: 10,
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

class Next24HrsHeader extends StatelessWidget {
  const Next24HrsHeader();

  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MyTextWidget(
            text: 'Next 24 Hours',
            color: Colors.white54,
            fontSize: 15,
            spacing: 5,
          )
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}

class HourlyHeader extends StatelessWidget {
  const HourlyHeader();

  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MyTextWidget(
            text: 'Hourly',
            color: Colors.white54,
            fontSize: 15,
            spacing: 5,
          )
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}
