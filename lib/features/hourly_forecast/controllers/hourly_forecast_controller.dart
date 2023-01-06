import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/features/sun_times/controllers/sun_time_controller.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/hourly_vertical_widget_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntimes/suntime_widget.dart';
import 'package:get/get.dart';

import '../../../services/asset_controllers/icon_controller.dart';
import '../../main_weather/bloc/weather_bloc.dart';

class HourlyForecastController extends GetxController {
  static const _next24Hours = 'next_24_hrs';
  static const _day1 = 'day1';
  static const _day2 = 'day2';
  static const _day3 = 'day3';
  static const _day4 = 'day4';

  static HourlyForecastController get to => Get.find();

  List<HourlyForecastModel> houryForecastModelList = [];

  Map<String, List> hourlyForecastHorizontalScrollWidgetMap = {
    _next24Hours: [],
    _day1: [],
    _day2: [],
    _day3: [],
    _day4: [],
  };

  @override
  void onClose() {
    super.onClose();
    AppDebug.log('Hourly Closed', name: 'HourlyForecastController');
  }

  List<List<int>> minAndMaxTempList = [[], [], [], []];

  late WeatherState _weatherState;

  late DateTime _startTime;

  late int _nowHour, _hoursUntilNext6am;

  late HourlyScrollWidgetColumn _hourColumn;

  late SunTimesModel _sunTimes;

  late DateTime _now,
      _day1StartTime,
      _day2StartTime,
      _day3StartTime,
      _day4StartTime;

  late HourlyData _weatherData;

  Future<void> refreshHourlyData({
    required WeatherState updatedWeatherState,
  }) async {
    _weatherState = updatedWeatherState;
    _now = DateTime.now();
    _nowHour = _now.hour;
    _initHoursUntilNext6am();
    _initReferenceTimes();
    _clearLists();
    _initHourlyData();
    update();
  }

  void _initHourlyData() {
    final dayList = _weatherState.weatherModel!.days;

    final List<HourlyData> hourlyList = [];

    for (final dayModel in dayList) {
      hourlyList.addAll(dayModel.hours!);
    }

    AppDebug.log('length: ${hourlyList.length}');

    for (int i = 0; i <= hourlyList.length - 1; i++) {
      _weatherData = hourlyList[i];

      _initHourlyTimeValues();

      final referenceTime = SunTimeController.to
          .referenceSuntime(refTime: _weatherData.startTime);

      final isDay = TimeZoneUtil.getForecastDayOrNight(
        forecastTime: _weatherData.startTime,
        referenceTime: referenceTime,
      );

      final hourlyCondition = _weatherData.condition;

      final iconPath = IconController.getIconImagePath(
        condition: hourlyCondition,
        temp: _weatherData.temperature,
        tempUnitsMetric: _weatherState.unitSettings.tempUnitsMetric,
        isDay: isDay,
      );

      final hourlyModel = HourlyVerticalWidgetModel.fromWeatherData(
        data: _weatherData,
        iconPath: iconPath,
        unitSettings: _weatherState.unitSettings,
      );

      _hourColumn = HourlyScrollWidgetColumn(model: hourlyModel);

      final isNext24Hours = _weatherData.startTime.isAfter(_now) &&
          _weatherData.startTime.isBefore(_now.add(const Duration(hours: 24)));

      AppDebug.log('$i is24Hrs: $isNext24Hours');

      if (isNext24Hours) {
        final hourlyForecastModel = HourlyForecastModel.fromWeatherData(
          data: _weatherData,
          iconPath: iconPath,
          unitSettings: _weatherState.unitSettings,
        );

        houryForecastModelList.add(hourlyForecastModel);
      }

      _sortHourlyHorizontalScrollColumns(
        hour: i,
        temp: _weatherData.temperature,
      );
    }
  }

  void _initReferenceTimes() {
    final timeString = _weatherState.weatherModel!.currentCondition!.startTime;

    final startingHourInterval = timeString;

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
    final searchIsLocal = _weatherState.searchIsLocal;
    if (searchIsLocal) {
      _hoursUntilNext6am = (24 - _nowHour) + 6;
    } else {
      final currentTime = TimeZoneUtil.getCurrentLocalOrRemoteTime(
        searchIsLocal: _weatherState.searchIsLocal,
      );
      final currentHourInSearchCity = currentTime.hour;
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

    final isNext24Hours = _weatherData.startTime.isAfter(_now) &&
        _weatherData.startTime.isBefore(_now.add(const Duration(hours: 24)));

    if (isNext24Hours) {
      _distrubuteToList(hourlyMapKey: _next24Hours, hour: hour, temp: temp);
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
        hourlyMapKey: _day1,
        hourlyListIndex: 0,
      );
    }

    if (nextHour.isBetween(
      startTime: _day2StartTime,
      endTime: _day3StartTime,
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day2StartTime, hourlyMapKey: _day2);

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: _day2,
        hourlyListIndex: 1,
      );
    }
    if (nextHour.isBetween(
      startTime: _day3StartTime,
      endTime: _day4StartTime,
      method: 'sortHourly',
    )) {
      _checkForPre6amSunRise(sixAM: _day3StartTime, hourlyMapKey: _day3);

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: _day3,
        hourlyListIndex: 2,
      );
    }
    if (TimeZoneUtil.isSameTimeOrBetween(
      referenceTime: nextHour,
      startTime: _day4StartTime,
      endTime: _day4StartTime.add(const Duration(hours: 24)),
    )) {
      _checkForPre6amSunRise(sixAM: _day4StartTime, hourlyMapKey: 'day_4');

      _distrubuteToList(
        temp: temp,
        hour: hour,
        hourlyMapKey: _day4,
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
      offset: TimeZoneUtil.timezoneOffset,
    );

    final bool sunsetInBetween = _sunTimes.sunsetTime!.isBetween(
      startTime: _startTime,
      endTime: nextHourRoundedUp,
      method: 'distributeToList',
      offset: TimeZoneUtil.timezoneOffset,
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

  /// Returns null after 4 because a null value tells the DailyDetailWidget
  /// not to try and build the extended hourly forecast as there is no data
  /// available past 108 hours
  String? hourlyForecastMapKey({required int index}) {
    switch (index) {
      case 0:
        return _day1;
      case 1:
        return _day2;
      case 2:
        return _day3;
      case 3:
        return _day4;

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
