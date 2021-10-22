import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HorizontalScrollWidget extends StatelessWidget {
  final List list;
  final bool layeredCard;
  final Widget header;
  const HorizontalScrollWidget({
    required this.list,
    required this.layeredCard,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return GetBuilder<HourlyForecastController>(
      builder: (_) => MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            GetBuilder<ViewController>(
              builder: (controller) => PartialRoundedContainer(
                height: 20.h,
                color: layeredCard
                    ? controller.theme.layeredCardColor
                    : controller.theme.soloCardColor,
                bottomLeft: 10,
                bottomRight: 10,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  thickness: 2.0,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return list[index] as Widget;
                    },
                  ),
                ).paddingSymmetric(horizontal: 5),
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
        children: [
          MyTextWidget(
            text: 'Next 24 Hours',
            color: Colors.white54,
            fontSize: 11.sp,
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
        children: [
          MyTextWidget(
            text: 'Hourly',
            color: Colors.white54,
            fontSize: 11.sp,
            spacing: 5,
          )
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}
