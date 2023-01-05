import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/view_controllers/scroll_position_controller.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../../../features/main_weather/bloc/weather_bloc.dart';
import '../../../services/view_controllers/adaptive_layout_controller.dart';
import '../../widgets/general/loading_indicator.dart';
import '../../widgets/weather_info_display/daily_widgets/daily_forecast_widget.dart';
import '../../widgets/weather_info_display/daily_widgets/daily_nav_widget.dart';

class DailyForecastPage extends StatefulWidget {
  static const id = 'daily_forecast_page';

  @override
  _DailyForecastPage createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  bool hasBuiltOnce = false;

  @override
  Widget build(BuildContext context) {
    /// runs only once to ensure scrollToIndex happens after the very first build
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final fromHomeTab =
            ScrollPositionController.to.navigateToDailyTabFromHome;
        if (!hasBuiltOnce && fromHomeTab) {
          ScrollPositionController.to.scrollAfterFirstBuild();
          hasBuiltOnce = true;
        }
      },
    );
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async =>
          context.read<WeatherBloc>().add(RefreshWeatherData()),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: AdaptiveLayoutController.to.appBarPadding.h),
              const RemoteLocationLabel(),
              const DailyNavigationWidget(),
              sizedBox5High,
              GetBuilder<DailyForecastController>(
                builder: (controller) => ScrollablePositionedList.builder(
                  itemScrollController:
                      ScrollPositionController.to.itemScrollController,
                  itemPositionsListener:
                      ScrollPositionController.to.itemPositionsListener,
                  padding: EdgeInsets.zero,
                  itemCount: controller.dailyForecastModelList.length,
                  itemBuilder: (context, index) {
                    return DailyForecastWidget(
                      model: controller.dailyForecastModelList[index],
                    );
                  },
                ).expanded(),
              ),
            ],
          ).paddingSymmetric(horizontal: 2.5),
          const LoadingIndicator(),
        ],
      ),
    );
  }
}
