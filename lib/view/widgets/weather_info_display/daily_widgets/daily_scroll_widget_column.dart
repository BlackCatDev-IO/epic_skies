import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/services/view_controllers/scroll_position_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DailyScrollWidgetColumn extends StatelessWidget {
  final DailyScrollWidgetModel model;

  const DailyScrollWidgetColumn({required this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScrollPositionController.to
          .jumpToDayFromHomeScreen(index: model.index),
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ScrollColumnDateWidget(
            month: model.month,
            date: model.date,
            time: model.header,
          ),
          TempWidget(temp: model.temp),
          Image(
            width: 4.h,
            image: AssetImage(model.iconPath),
          ),
          MyTextWidget(
            text: ' ${model.precipitation}%',
            fontSize: 10.sp,
            color: Colors.white54,
          ),
        ],
      ).paddingSymmetric(horizontal: 9),
    );
  }
}

class _ScrollColumnDateWidget extends StatelessWidget {
  final String month, date, time;

  const _ScrollColumnDateWidget({
    required this.date,
    required this.month,
    required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: time,
          color: Colors.blueAccent[100],
          fontSize: 10.5.sp,
        ),
        const SizedBox(height: 5),
        MyTextWidget(
          text: '$month $date',
          fontSize: 11.sp,
          fontWeight: FontWeight.w200,
          color: Colors.yellow[50],
        ),
      ],
    );
  }
}
