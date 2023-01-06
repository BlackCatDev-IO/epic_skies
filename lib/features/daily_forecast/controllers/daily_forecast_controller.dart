import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get/get.dart';

import '../../../models/weather_response_models/weather_data_model.dart';
import '../../forecast_controllers.dart';
import '../../main_weather/bloc/weather_bloc.dart';

class DailyForecastController extends GetxController {
  DailyForecastController({required this.hourlyForecastController});

  static DailyForecastController get to => Get.find();

  final HourlyForecastController hourlyForecastController;

  List<DailyScrollWidgetModel> dayColumnModelList = [];
  List<DailyForecastModel> dailyForecastModelList = [];
  List<DailyNavButtonModel> week1NavButtonList = [];
  List<DailyNavButtonModel> week2NavButtonList = [];
  List<String> dayLabelList = [];

  RxInt selectedDayIndex = 0.obs;

  late String? extendedHourlyForecastKey;

  late DailyForecastModel detailWidgetModel;

  late DailyData data;

  late WeatherState _weatherState;

  Future<void> refreshDailyData({
    required WeatherState updatedWeatherState,
  }) async {
    _weatherState = updatedWeatherState;

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
    final weatherModel = _weatherState.weatherModel;
    for (int i = 0; i < weatherModel!.days.length - 1; i++) {
      final interval = _initDailyInterval(i);
      data = weatherModel.days[interval];

      final dailyForecastModel = DailyForecastModel.fromWeatherData(
        data: data,
        index: interval,
        currentTime: TimeZoneUtil.getCurrentLocalOrRemoteTime(
          searchIsLocal: _weatherState.searchIsLocal,
        ),
        hourlyKey: hourlyForecastController.hourlyForecastMapKey(index: i),
        suntime: SunTimeController.to.sunTimeList[interval],
        unitSettings: _weatherState.unitSettings,
      );

      dayLabelList.add(dailyForecastModel.day);

      final dayColumnModel = DailyScrollWidgetModel(
        header: dailyForecastModel.day,
        iconPath: dailyForecastModel.iconPath,
        temp: dailyForecastModel.dailyTemp,
        precipitation: dailyForecastModel.precipitationProbability,
        month: DateTimeFormatter.getMonthAbbreviation(time: data.startTime),
        date: dailyForecastModel.date,
        index: i,
      );

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: data.startTime),
        date: dailyForecastModel.date,
        index: i,
      );

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(dailyNavButtonModel);
      } else if (i.isInRange(7, 13)) {
        week2NavButtonList.add(dailyNavButtonModel);
      }

      dayColumnModelList.add(dayColumnModel);
      dailyForecastModelList.add(dailyForecastModel);
    }
  }

  /// between 12am and 6am day @ index 0 is yesterday due to Tomorrow.io
  /// defining days from 6am to 6am, this accounts for that
  int _initDailyInterval(int i) {
    final searchIsLocal = _weatherState.searchIsLocal;
    int interval = i + 1;
    if (TimeZoneUtil.isBetweenMidnightAnd6Am(searchIsLocal: searchIsLocal)) {
      return interval++;
    } else {
      return interval;
    }
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
    int oldIndex = 0;
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

  void updatedSelectedDayIndex(int index) {
    updateSelectedDayStatus(newIndex: index);
    selectedDayIndex(index);
  }

  void _clearWidgetLists() {
    dayColumnModelList.clear();
    dayLabelList.clear();
    dailyForecastModelList.clear();
    week1NavButtonList.clear();
    week2NavButtonList.clear();
  }
}
