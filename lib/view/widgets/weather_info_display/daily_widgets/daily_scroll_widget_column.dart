import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

class DailyScrollWidgetColumn extends StatelessWidget {
  const DailyScrollWidgetColumn({
    required this.model,
    super.key,
  });
  final DailyScrollWidgetModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GetIt.instance<TabNavigationController>().jumpToTab(index: 2);
        context.read<DailyForecastCubit>().updatedSelectedDayIndex(model.index);
      },
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
  const _ScrollColumnDateWidget({
    required this.date,
    required this.month,
    required this.time,
  });

  final String month;
  final String date;
  final String time;

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
