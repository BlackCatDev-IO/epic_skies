import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/daily_detail_widget_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_detail_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_scroll_widget_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  List<Widget> dayColumnList = [];
  List<Widget> dayDetailedWidgetList = [];
  List<DailyNavButtonModel> week1NavButtonList = [];
  List<DailyNavButtonModel> week2NavButtonList = [];
  List<String> dayLabelList = [];

  late String _monthAbbreviation;

  late String? extendedHourlyForecastKey;

  late DailyDetailWidgetModel detailWidgetModel;

  List<TimestepInterval> dailyIntervalList = [];

  Future<void> buildDailyForecastWidgets() async {
    final response = StorageController.to.restoreWeatherModel();
    final weatherModel = WeatherResponseModel.fromMap(response);
    dailyIntervalList = weatherModel.timelines[TimelineKeys.daily].intervals;
    _clearWidgetLists();
    _builDailyWidgets();
    update();
  }

  /// stores isSelected bools for DayLabelRow to show selected indicator
  List<bool> selectedDayList = [];

  @override
  void onInit() {
    super.onInit();
    _initSelectedDayList();
  }

  void _builDailyWidgets() {
    for (int i = 0; i < 14; i++) {
      final interval = _initDailyInterval(i);
      final dailyInterval = dailyIntervalList[interval];
      final dailyWidgetModel = DailyDetailWidgetModel.fromValues(
        values: dailyInterval.values,
        index: interval,
      );

      _initAndFormatDateStrings(interval);

      dayLabelList.add(dailyWidgetModel.day);

      final dayColumnModel = DailyScrollWidgetModel(
        header: dailyWidgetModel.day,
        iconPath: dailyWidgetModel.iconPath,
        temp: dailyWidgetModel.dailyTemp,
        precipitation: dailyWidgetModel.precipitationProbability,
        month: _monthAbbreviation,
        date: dailyWidgetModel.date,
        index: i,
      );

      final dayColumn = DailyScrollWidgetColumn(model: dayColumnModel);

      final dailyDetailWidget = DailyDetailWidget(model: dailyWidgetModel);

      final _dailyNavButtonModel = DailyNavButtonModel(
        day: dailyWidgetModel.day,
        month: _monthAbbreviation,
        date: dailyWidgetModel.date,
        index: i,
      );

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(_dailyNavButtonModel);
      } else if (i.isInRange(7, 13)) {
        week2NavButtonList.add(_dailyNavButtonModel);
      }

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
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

  void _initAndFormatDateStrings(int i) {
    final dateString = dailyIntervalList[i].startTime.toString();
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

  void updateSelectedDayStatus({required int index}) {
    for (int i = 0; i <= 13; i++) {
      if (index == i) {
        selectedDayList[i] = true;
      } else {
        selectedDayList[i] = false;
      }
    }
    update(['daily_nav_button']);
  }

  void _clearWidgetLists() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();
    week1NavButtonList.clear();
    week2NavButtonList.clear();
  }
}
