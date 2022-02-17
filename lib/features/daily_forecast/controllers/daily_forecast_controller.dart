import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';

import '../../forecast_controllers.dart';

class DailyForecastController extends GetxController {
  DailyForecastController({
    required this.currentWeatherController,
    required this.hourlyForecastController,
    required this.weatherRepository,
  });

  static DailyForecastController get to => Get.find();

  final WeatherRepository weatherRepository;
  final CurrentWeatherController currentWeatherController;
  final HourlyForecastController hourlyForecastController;

  List<DailyScrollWidgetModel> dayColumnModelList = [];
  List<DailyForecastModel> dailyForecastModelList = [];
  List<DailyNavButtonModel> week1NavButtonList = [];
  List<DailyNavButtonModel> week2NavButtonList = [];
  List<String> dayLabelList = [];

  late String? extendedHourlyForecastKey;

  late DailyForecastModel detailWidgetModel;

  late WeatherData data;

  int selectedDayIndex = 0;

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
    final weatherModel = weatherRepository.weatherModel;

    for (int i = 0; i < 14; i++) {
      final interval = _initDailyInterval(i);
      data = weatherModel!.timelines[Timelines.daily].intervals[interval].data;

      late int? highTemp;
      late int? lowTemp;

      late List<int>? tempList;

      if (i.isInRange(0, 3)) {
        tempList = hourlyForecastController.minAndMaxTempList[i];
        tempList.sort();
        highTemp = tempList.last;
        lowTemp = tempList.first;
      } else {
        highTemp = null;
        lowTemp = null;
      }

      final dailyForecastModel = DailyForecastModel.fromWeatherData(
        data: data,
        index: interval,
        lowTemp: lowTemp,
        highTemp: highTemp,
        currentTime: currentWeatherController.currentTime,
        hourlyKey: hourlyForecastController.hourlyForecastMapKey(index: i),
        suntime: SunTimeController.to.sunTimeList[interval],
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

      final _dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: data.startTime),
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
    selectedDayIndex = newIndex;
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
