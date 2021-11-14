import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/daily_forecast_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

import 'package:get/get.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  List<DailyScrollWidgetModel> dayColumnModelList = [];
  List<DailyForecastModel> dailyForecastModelList = [];
  List<DailyNavButtonModel> week1NavButtonList = [];
  List<DailyNavButtonModel> week2NavButtonList = [];
  List<String> dayLabelList = [];

  late String _monthAbbreviation;

  late String? extendedHourlyForecastKey;

  late DailyForecastModel detailWidgetModel;

  late WeatherData data;

  Future<void> initDailyForecastModels() async {
    _clearWidgetLists();
    _builDailyModels();
    update();
  }

  /// stores isSelected bools for DayLabelRow to show selected indicator
  List<bool> selectedDayList = [];

  @override
  void onInit() {
    super.onInit();
    _initSelectedDayList();
  }

  void _builDailyModels() {
    final weatherModel = WeatherRepository.to.weatherModel;

    for (int i = 0; i < 14; i++) {
      final interval = _initDailyInterval(i);
      data = weatherModel!.timelines[Timelines.daily].intervals[interval].data;

      final dailyForecastModel = DailyForecastModel.fromWeatherData(
        data: data,
        index: interval,
        hourlyIndex: i,
      );

      _initAndFormatDateStrings();

      dayLabelList.add(dailyForecastModel.day);

      final dayColumnModel = DailyScrollWidgetModel(
        header: dailyForecastModel.day,
        iconPath: dailyForecastModel.iconPath,
        temp: dailyForecastModel.dailyTemp,
        precipitation: dailyForecastModel.precipitationProbability,
        month: _monthAbbreviation,
        date: dailyForecastModel.date,
        index: i,
      );

      final _dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: _monthAbbreviation,
        date: dailyForecastModel.date,
        index: i,
      );

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(_dailyNavButtonModel);
      } else if (i.isInRange(7, 13)) {
        week2NavButtonList.add(_dailyNavButtonModel);
      }

      dayColumnModelList.add(dayColumnModel);
      dailyForecastModelList.add(dailyForecastModel);
    }
  }

  /// between 12am and 6am day @ index 0 is yesterday due to Tomorrow.io
  /// defining days from 6am to 6am, this accounts for that
  int _initDailyInterval(int i) {
    int interval = i + 1;
    if (TimeZoneController.to.isBetweenMidnightAnd6Am()) {
      return interval++;
    } else {
      return interval;
    }
  }

  void _initAndFormatDateStrings() {
    final dateString = data.startTime.toString();
    final displayDate = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: dateString);
    _monthAbbreviation =
        DateTimeFormatter.getMonthAbbreviation(time: displayDate);
  }

  /// sets first day of DayLabelRow @ index 0 to selected, as a starting
  /// point when user navigates to Daily Tab
  void _initSelectedDayList() {
    for (int i = 0; i <= 13; i++) {
      if (i == 0) {
        selectedDayList.add(true);
      } else {
        selectedDayList.add(false);
      }
    }
  }

  void updateSelectedDayStatus({required int newIndex}) {
    late int oldIndex;
    for (int i = 0; i <= 13; i++) {
      if (selectedDayList[i] == true) {
        oldIndex = i;
      }
      if (newIndex == i) {
        selectedDayList[i] = true;
      } else {
        selectedDayList[i] = false;
      }
    }
    update(['daily_nav_button:$oldIndex']);
    update(['daily_nav_button:$newIndex']);
  }

  void _clearWidgetLists() {
    dayColumnModelList.clear();
    dayLabelList.clear();
    dailyForecastModelList.clear();
    week1NavButtonList.clear();
    week2NavButtonList.clear();
  }
}
