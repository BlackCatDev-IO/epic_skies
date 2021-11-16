import 'dart:developer';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/hourly_forecast_model.dart';
import 'package:epic_skies/models/widget_models/hourly_vertical_widget_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';

import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntimes/suntime_widget.dart';
import 'package:get/get.dart';

import 'current_weather_controller.dart';
import 'sun_time_controller.dart';

class HourlyForecastController extends GetxController {
  static HourlyForecastController get to => Get.find();

  List<HourlyForecastModel> houryForecastModelList = [];

  Map<String, List> hourlyForecastHorizontalScrollWidgetMap = {
    'next_24_hrs': [],
    'day_1': [],
    'day_2': [],
    'day_3': [],
    'day_4': [],
  };

  List<List<int>> minAndMaxTempList = [[], [], [], []];

  late DateTime _startTime;

  late int _nowHour, _hoursUntilNext6am;

  late HourlyScrollWidgetColumn _hourColumn;

  late SunTimesModel _sunTimes;

  late DateTime _now,
      _day1StartTime,
      _day2StartTime,
      _day3StartTime,
      _day4StartTime;

  late WeatherData _weatherData;

  Future<void> buildHourlyForecastWidgets() async {
    _now = CurrentWeatherController.to.currentTime;
    _nowHour = _now.hour;
    _initHoursUntilNext6am();
    _initReferenceTimes();
    _clearLists();
    _buildHourlyWidgets();
    update();
  }

  void _buildHourlyWidgets() {
    final weatherModel = WeatherRepository.to.weatherModel;

    /// 108 available hours of forecast
    for (int i = 0; i <= 107; i++) {
      _weatherData =
          weatherModel!.timelines[Timelines.hourly].intervals[i].data;
      _initHourlyTimeValues();

      final hourlyModel = HourlyVerticalWidgetModel.fromWeatherData(
        data: _weatherData,
        index: i,
      );

      _hourColumn = HourlyScrollWidgetColumn(model: hourlyModel);

      /// This is only for the next 24hrs in the HourlyForecastPage
      if (i.isInRange(1, 24)) {
        final hourlyForecastModel =
            HourlyForecastModel.fromWeatherData(index: i, data: _weatherData);

        houryForecastModelList.add(hourlyForecastModel);
      }

      _sortHourlyHorizontalScrollColumns(
        hour: i,
        temp: _weatherData.temperature,
      );
    }
  }

  void _initReferenceTimes() {
    final startingHourInterval = WeatherRepository.to.weatherModel!
        .timelines[Timelines.hourly].intervals[0].data.startTime;

    _day1StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am));
    _day2StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 24));
    _day3StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 48));
    _day4StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 72));

    _sunTimes = SunTimeController.to.sunTimeList[0];
  }

  void _initHoursUntilNext6am() {
    final searchIsLocal = WeatherRepository.to.searchIsLocal;
    if (searchIsLocal) {
      _hoursUntilNext6am = (24 - _nowHour) + 6;
    } else {
      final currentHourInSearchCity =
          CurrentWeatherController.to.currentTime.hour;
      _hoursUntilNext6am = (24 - currentHourInSearchCity) + 6;
    }
  }

  void _initHourlyTimeValues() {
    _startTime = _weatherData.startTime;

    /// accounting for timezones that are offset by 30 minutes to most of the
    /// worlds other timezones
    if (_startTime.minute == 30) {
      _startTime = _startTime.add(const Duration(minutes: 30));
    }
  }

  void _sortHourlyHorizontalScrollColumns({
    required int hour,
    required int temp,
  }) {
    final nextHour = _startTime.add(const Duration(hours: 1));
    _updateSunTimeValue();

    if (hour.isInRange(1, 24)) {
      _distrubuteToList(hourlyMapKey: 'next_24_hrs', hour: hour, temp: temp);
    }

    if (nextHour.isBetween(
      startTime: _day1StartTime,
      endTime: _day2StartTime,
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day1StartTime, hourlyMapKey: 'day_1');

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: 'day_1',
        hourlyListIndex: 0,
      );
    }

    if (nextHour.isBetween(
      startTime: _day2StartTime,
      endTime: _day3StartTime,
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day2StartTime, hourlyMapKey: 'day_2');

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: 'day_2',
        hourlyListIndex: 1,
      );
    }
    if (nextHour.isBetween(
      startTime: _day3StartTime,
      endTime: _day4StartTime,
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day3StartTime, hourlyMapKey: 'day_3');

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: 'day_3',
        hourlyListIndex: 2,
      );
    }
    if (TimeZoneController.to.isSameTimeOrBetween(
      referenceTime: nextHour,
      startTime: _day4StartTime,
      endTime: _day4StartTime.add(const Duration(hours: 24)),
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day4StartTime, hourlyMapKey: 'day_4');

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: 'day_4',
        hourlyListIndex: 3,
      );
    }
  }

  /// For when sunrise is before 6am in hourly forecast rows that start at 6am
  void _checkForPre6amSunRise({
    required DateTime sixAM,
    required String hourlyMapKey,
  }) {
    final fourAM = sixAM.subtract(const Duration(hours: 2));

    /// returns true if sunrise is before 6am and _startTime is 6am
    /// so that it will insert the sunrise widget before the regular 6am hourly
    /// widget on the DailyForecastPage
    final isBetween = _sunTimes.sunriseTime!
            .isBetween(startTime: fourAM, endTime: sixAM, method: 'pre5am') &&
        _startTime.isAtSameMomentAs(sixAM);

    if (isBetween) {
      final sunriseColumn = SuntimeWidget(
        isSunrise: true,
        onPressed: () {},
        time: _sunTimes.sunriseString,
      );
      hourlyForecastHorizontalScrollWidgetMap[hourlyMapKey]!.add(sunriseColumn);
    }
  }

  void _distrubuteToList({
    required String hourlyMapKey,
    int? hourlyListIndex,
    required int temp,
    required int hour,
  }) {
    final durationToNextHour = _startTime.minute == 0
        ? const Duration(hours: 1)
        : const Duration(minutes: 30);

    final nextHourRoundedUp = _startTime.add(durationToNextHour);

    hourlyForecastHorizontalScrollWidgetMap[hourlyMapKey]!.add(_hourColumn);

    /// If a sun time happens to land on an even hour, this replaces the normal
    /// hourly widget with the sun time widget

    if (_sunTimes.sunriseTime!.isSameTime(comparisonTime: _startTime)) {
      _replaceHourlyWithSunTimeWidget(
        key: hourlyMapKey,
        timeString: _sunTimes.sunriseString,
        isSunrise: true,
      );
    }

    if (_sunTimes.sunsetTime!.isSameTime(comparisonTime: _startTime)) {
      _replaceHourlyWithSunTimeWidget(
        key: hourlyMapKey,
        timeString: _sunTimes.sunsetString,
        isSunrise: false,
      );
    }

    final bool sunriseInBetween = _sunTimes.sunriseTime!.isBetween(
      startTime: _startTime,
      endTime: nextHourRoundedUp,
      method: 'distributeToList',
      offset: TimeZoneController.to.timezoneOffset,
    );

    final bool sunsetInBetween = _sunTimes.sunsetTime!.isBetween(
      startTime: _startTime,
      endTime: nextHourRoundedUp,
      method: 'distributeToList',
      offset: TimeZoneController.to.timezoneOffset,
    );

    if (sunriseInBetween) {
      final sunriseColumn = SuntimeWidget(
        isSunrise: true,
        onPressed: () {},
        time: _sunTimes.sunriseString,
      );

      hourlyForecastHorizontalScrollWidgetMap[hourlyMapKey]!.add(sunriseColumn);
    }

    if (sunsetInBetween) {
      final sunsetColumn = SuntimeWidget(
        isSunrise: false,
        onPressed: () {},
        time: _sunTimes.sunsetString,
      );

      hourlyForecastHorizontalScrollWidgetMap[hourlyMapKey]!.add(sunsetColumn);
    }

    /// range check prevents temps from after midnight being factored into daily
    ///  high/low temps
    if (hourlyListIndex != null) {
      if (minAndMaxTempList[hourlyListIndex].length <= 18) {
        minAndMaxTempList[hourlyListIndex].add(temp);
      }
    }
  }

  /// Keeps the suntime object in sync with the hourly start times so the
  /// sun times are always being compared to the correct day
  void _updateSunTimeValue() {
    final nextMidnight = _now.endOfDay.add(const Duration(microseconds: 1));

    if (_startTime.isSameDay(_now)) {
      _sunTimes = SunTimeController.to.sunTimeList[0];
    } else if (_startTime.isSameDay(nextMidnight)) {
      _sunTimes = SunTimeController.to.sunTimeList[1];
    } else if (_startTime
        .isSameDay(nextMidnight.add(const Duration(days: 1)))) {
      _sunTimes = SunTimeController.to.sunTimeList[2];
    } else if (_startTime
        .isSameDay(nextMidnight.add(const Duration(days: 2)))) {
      _sunTimes = SunTimeController.to.sunTimeList[3];
    } else if (_startTime
        .isSameDay(nextMidnight.add(const Duration(days: 3)))) {
      _sunTimes = SunTimeController.to.sunTimeList[4];
    } else if (_startTime
        .isSameDay(nextMidnight.add(const Duration(days: 4)))) {
      _sunTimes = SunTimeController.to.sunTimeList[5];
    }
  }

  void _replaceHourlyWithSunTimeWidget({
    required String key,
    required String timeString,
    required bool isSunrise,
  }) {
    final list = hourlyForecastHorizontalScrollWidgetMap[key]!;
    final index = list.length - 1;
    list[index] = SuntimeWidget(
      isSunrise: isSunrise,
      onPressed: () {},
      time: timeString,
    );
  }

  /// Returns null after 3 because a null value  tells the DailyDetailWidget
  /// not to try and build the extended hourly forecast as there is no data
  /// available past 108 hours
  String? hourlyForecastMapKey({required int index}) {
    switch (index) {
      case 0:
        return 'day_1';
      case 1:
        return 'day_2';
      case 2:
        return 'day_3';
      case 3:
        return 'day_4';

      default:
        return null;
    }
  }

  void _clearLists() {
    hourlyForecastHorizontalScrollWidgetMap['next_24_hrs']!.clear();

    houryForecastModelList.clear();

    for (int i = 0; i < 4; i++) {
      minAndMaxTempList[i].clear();
    }

    for (final list in hourlyForecastHorizontalScrollWidgetMap.values) {
      list.clear();
    }
  }
}
