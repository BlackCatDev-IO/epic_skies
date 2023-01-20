import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../../features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import '../../../../services/ticker_controllers/tab_navigation_controller.dart';
import 'horizontal_scroll_widget.dart';
import 'hourly_scroll_widget_column.dart';

class HourlyForecastRow extends StatelessWidget {
  const HourlyForecastRow();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          GetIt.instance<TabNavigationController>().jumpToTab(index: 1),
      child: BlocBuilder<HourlyForecastCubit, HourlyForecastState>(
        builder: (context, state) {
          final widgetList = state.sortedHourlyList.next24Hours
              .map(
                (model) => HourlyScrollWidgetColumn(
                  model: model,
                ),
              )
              .toList();
          return HorizontalScrollWidget(
            list: widgetList,
            header: const _Next24HrsHeader(),
            layeredCard: false,
          );
        },
      ),
    );
  }
}

class _Next24HrsHeader extends StatelessWidget {
  const _Next24HrsHeader();

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
