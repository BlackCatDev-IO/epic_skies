import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:sizer/sizer.dart';

import '../../../services/view_controllers/adaptive_layout_controller.dart';
import '../../widgets/weather_info_display/current_weather/current_weather_row.dart';
import '../../widgets/weather_info_display/daily_widgets/weekly_forecast_row.dart';
import '../../widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';

class CurrentWeatherPage extends StatefulWidget {
  static const id = 'current_weather_page';

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  static const homeWidgetList = <Widget>[
    CurrentWeatherRow(),
    SizedBox(height: 2),
    RemoteTimeWidget(),
    HourlyForecastRow(),
    WeeklyForecastRow(),
  ];

  @override
  void initState() {
    super.initState();
    // This needs to run on app start but needs to happen after MaterialApp
    // and Sizer are initialized
    UpdateController.to.checkForFirstInstallOfUpdatedAppVersion();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async => WeatherRepository.to.refreshWeatherData(),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: AdaptiveLayoutController.to.appBarPadding.h),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: homeWidgetList.length,
                itemBuilder: (context, index) {
                  return homeWidgetList[index];
                },
              ).expanded()
            ],
          ).paddingSymmetric(horizontal: 2.5, vertical: 1),
          Obx(
            () => WeatherRepository.to.isLoading.value
                ? const MyCircularProgressIndicator()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class RemoteTimeWidget extends StatelessWidget {
  const RemoteTimeWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (controller) {
        return controller.searchIsLocal
            ? nil
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedContainer(
                    color: Colors.white70,
                    child: GetBuilder<CurrentWeatherController>(
                      id: 'remote_time',
                      builder: (currentWeatherController) {
                        return Text(
                          'Current time in ${RemoteLocationController.to.data.city}: ${currentWeatherController.currentTimeString}',
                        ).paddingSymmetric(horizontal: 10, vertical: 2.5);
                      },
                    ).center(),
                  ).paddingOnly(top: 5, bottom: 2.5),
                ],
              );
      },
    );
  }
}
