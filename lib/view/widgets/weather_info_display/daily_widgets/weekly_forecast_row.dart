import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/horizontal_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklyForecastRow extends StatelessWidget {
  const WeeklyForecastRow({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      builder: (context, state) {
        return DailyHorizontalScrollWidget(
          header: const _Next14DaysHeader(),
          layeredCard: false,
          list: List<DailyScrollWidgetColumn>.generate(
            state.dayColumnModelList.length,
            (int index) => DailyScrollWidgetColumn(
              model: state.dayColumnModelList[index],
            ),
            growable: false,
          ),
        );
      },
    );
  }
}

class _Next14DaysHeader extends StatelessWidget {
  const _Next14DaysHeader();
  @override
  Widget build(BuildContext context) {
    return const PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
            text: 'Next 14 Days',
            color: Colors.white60,
            fontSize: 17,
            spacing: 4,
          )
        ],
      ),
    );
  }
}
