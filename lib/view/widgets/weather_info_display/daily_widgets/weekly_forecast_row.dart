import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/view/screens/tab_screens/daily_forecast_page.dart';
import 'package:epic_skies/view/widgets/containers/partial_rounded_container.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/horizontal_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklyForecastRow extends StatelessWidget {
  const WeeklyForecastRow({
    this.isDailyPage = false,
    super.key,
  });

  final bool isDailyPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      builder: (context, state) {
        final homepageList = state.dayColumnModelList
            .map((model) => DailyScrollWidgetColumn(model: model))
            .toList();

        final dailyCubit = context.read<DailyForecastCubit>();

        final navButtonModelList = dailyCubit.state.navButtonModelList;

        final dailyPageList = navButtonModelList
            .map(
              (navModel) => DailyNavButton(
                model: navModel,
                onTap: () => dailyCubit.updatedSelectedDay(
                  navModel.date,
                  autoScroll: true,
                ),
              ),
            )
            .toList();

        return DailyHorizontalScrollWidget(
          header: const _Next10DaysHeader(),
          height: isDailyPage ? 80 : null,
          layeredCard: false,
          widgetList: isDailyPage ? dailyPageList : homepageList,
        );
      },
    );
  }
}

class _Next10DaysHeader extends StatelessWidget {
  const _Next10DaysHeader();
  @override
  Widget build(BuildContext context) {
    return const PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Daily Forecast',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 17,
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}
