import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/scroll_position_controller.dart';
import 'package:epic_skies/services/weather_forecast/daily_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class DailyForecastPage extends StatefulWidget {
  static const id = 'daily_forecast_page';

  @override
  _DailyForecastPage createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

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
    WidgetsBinding.instance!.addPostFrameCallback(
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
      onRefresh: () async => WeatherRepository.to.refreshWeatherData(),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: StorageController.to.appBarPadding().h),
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
                  itemCount: controller.dayDetailedWidgetList.length,
                  itemBuilder: (context, index) {
                    return controller.dayDetailedWidgetList[index];
                  },
                ).expanded(),
              ),
            ],
          ).paddingSymmetric(horizontal: 2.5),
          Obx(
            () => WeatherRepository.to.isLoading.value
                ? const MyCircularProgressIndicator()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
