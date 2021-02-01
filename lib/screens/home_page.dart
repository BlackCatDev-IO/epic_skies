import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/storage_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:epic_skies/widgets/current_weather_row.dart';
import 'package:epic_skies/widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/my_elevated_button.dart';
import 'package:epic_skies/widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

List<Widget> homeWidgetList = <Widget>[
  CurrentWeatherRow(),
  HourlyForecastRow(),
  WeeklyForecastRow(),
  MyElevatedButton(
    onPressed: () {
      Get.find<WeatherController>().getAllWeatherData();
    },
  ),
];

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        final bool searchIsLocal =
            Get.find<StorageController>().restoreSavedSearchIsLocal();
        if (searchIsLocal) {
          await Get.find<WeatherController>().getAllWeatherData();
        } else
          await Get.find<SearchController>().updateRemoteLocationData();
      },
      child: Column(
        children: [
          ListView.builder(
            itemCount: homeWidgetList.length,
            itemBuilder: (context, index) {
              return homeWidgetList[index];
            },
          ).expanded()
        ],
      ).paddingSymmetric(horizontal: 5, vertical: 15),
    );
  }
}
