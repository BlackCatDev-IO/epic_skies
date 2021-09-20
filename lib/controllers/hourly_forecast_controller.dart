import 'dart:developer';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/scroll_widget_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntime_widget.dart';
import 'package:get/get.dart';

import 'current_weather_controller.dart';
import 'sun_time_controller.dart';

class HourlyForecastController extends GetxController {
  static HourlyForecastController get to => Get.find();

  List hourRowList = [];
  Map<String, List> hourlyForecastHorizontalScrollWidgetMap = {
    'next_24_hrs': [],
    'day_1': [],
    'day_2': [],
    'day_3': [],
    'day_4': [],
  };

  List<List<int>> minAndMaxTempList = [[], [], [], []];

  late DateTime _startTime;

  Map _dataMap = {};
  Map _valuesMap = {};
  Map _settingsMap = {};

  late String _precipitationType,
      _hourlyCondition,
      _feelsLike,
      _iconPath,
      _timeAtNextHour;

  late int _nowHour,
      _precipitationCode,
      _hoursUntilNext6am,
      _hourlyTemp,
      _extendedHourlyTemp;

  late num _precipitationAmount, _windSpeed, _precipitation;

  late ScrollWidgetColumn _hourColumn;

  late SunTimesModel _sunTimes;

  late DateTime _now;

  Future<void> buildHourlyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    _settingsMap = StorageController.to.settingsMap;
    _now = DateTime.now();
    // _now = _initNow();
    _nowHour = _now.hour;
    _initHoursUntilNext6am();
    _clearLists();
    _buildHourlyWidgets();
    update();
  }

  DateTime _initNow() {
    final searchIsLocal = WeatherRepository.to.searchIsLocal;
    if (searchIsLocal) {
      return DateTime.now();
    } else {
      final timezoneOffset = TimeZoneController.to.timezoneOffset;
      return DateTime.now().subtract(timezoneOffset);
    }
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

  void _buildHourlyWidgets() {
    /// 108 available hours of forecast
    for (int i = 0; i <= 107; i++) {
      _initHourlyData(i);

      _hourColumn = ScrollWidgetColumn(
        temp: _hourlyTemp,
        iconPath: _iconPath,
        precipitation: _precipitation,
        header: _timeAtNextHour,
      );

      if (i.isInRange(1, 24)) {
        final hourlyDetailedRow = HoulyDetailedRow(
          temp: _hourlyTemp,
          iconPath: _iconPath,
          precipitationProbability: _precipitation,
          time: _timeAtNextHour,
          feelsLike: _feelsLike,
          condition: _hourlyCondition,
          precipitationType: _precipitationType,
          precipitationCode: _precipitationCode,
          precipitationAmount: _precipitationAmount,
          precipUnit: CurrentWeatherController.to.precipUnitString,
          windSpeed: _windSpeed,
          speedUnit: CurrentWeatherController.to.speedUnitString,
        );

        hourRowList.add(hourlyDetailedRow);
      }
      _sortHourlyHorizontalScrollColumns(hour: i, temp: _extendedHourlyTemp);
    }
  }

  Future<void> _initHourlyData(int i) async {
    _valuesMap = _dataMap['timelines'][0]['intervals'][i]['values'] as Map;

    /// Range check is because hourly wind speed is only displayed in the Hourly
    /// tab in the HourlyDetail widgets for the next 24 hours
    if (i <= 24) {
      _windSpeed = UnitConverter.convertFeetPerSecondToMph(
              feetPerSecond: _valuesMap['windSpeed'] as num)
          .round();
    }
    _initPrecipValues();
    _initHourlyConditions();
    _initHourlyTimeValues(i);
    _handlePotentialConversions(i);

    _iconPath = IconController.getIconImagePath(
        hourly: true, condition: _hourlyCondition, time: _startTime, index: i);
  }

  void _initPrecipValues() {
    _precipitation = _valuesMap['precipitationProbability'].round() as num;
    _precipitationCode = _valuesMap['precipitationType'] as int;
    _precipitationType =
        WeatherCodeConverter.getPrecipitationTypeFromCode(_precipitationCode);

    if (_precipitation == 0 || _precipitation == 0.0) {
      _precipitationType = '';
    }
    final precip = _valuesMap['precipitationIntensity'] ?? 0.0;
    _precipitationAmount = precip.round() as int;
  }

  void _initHourlyTimeValues(int i) {
    _extendedHourlyTemp = _hourlyTemp;
    _startTime = TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
        time: _dataMap['timelines'][0]['intervals'][i]['startTime'] as String);

    _timeAtNextHour = DateTimeFormatter.formatTimeToHour(time: _startTime);
  }

  void _initHourlyConditions() {
    final weatherCode = _valuesMap['weatherCode'];
    _hourlyTemp = _valuesMap['temperature'].round() as int;
    _hourlyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(weatherCode as int?);
    _feelsLike = _valuesMap['temperatureApparent'].round().toString();
  }

  void _sortHourlyHorizontalScrollColumns(
      {required int hour, required int temp}) {
    final nextHour = _now.add(Duration(hours: hour + 1));

    final day1StartTime = _now.add(Duration(hours: _hoursUntilNext6am));
    final day2StartTime = _now.add(Duration(hours: _hoursUntilNext6am + 24));
    final day3StartTime = _now.add(Duration(hours: _hoursUntilNext6am + 48));
    final day4StartTime = _now.add(Duration(hours: _hoursUntilNext6am + 72));

    if (hour.isInRange(1, 24)) {
      _sunTimes = SunTimeController.to.sunTimeList[0];

      if (TimeZoneController.to.isMidnightOrAfter(time: nextHour)) {
        _sunTimes = SunTimeController.to.sunTimeList[1];
      }

      _distrubuteToList(hourlyMapKey: 'next_24_hrs', hour: hour, temp: temp);
    }

    if (nextHour.isBetween(startTime: day1StartTime, endTime: day2StartTime)) {
      _sunTimes = SunTimeController.to.sunTimeList[1];

      _distrubuteToList(
          temp: temp, hour: hour, hourlyMapKey: 'day_1', hourlyListIndex: 0);
    }
    if (nextHour.isBetween(startTime: day2StartTime, endTime: day3StartTime)) {
      _sunTimes = SunTimeController.to.sunTimeList[2];

      _distrubuteToList(
          temp: temp, hour: hour, hourlyMapKey: 'day_2', hourlyListIndex: 1);
    }
    if (nextHour.isBetween(startTime: day3StartTime, endTime: day4StartTime)) {
      _sunTimes = SunTimeController.to.sunTimeList[3];

      _distrubuteToList(
          temp: temp, hour: hour, hourlyMapKey: 'day_3', hourlyListIndex: 2);
    }
    if (nextHour.isAfter(day4StartTime)) {
      _sunTimes = SunTimeController.to.sunTimeList[4];

      _distrubuteToList(
          temp: temp, hour: hour, hourlyMapKey: 'day_4', hourlyListIndex: 3);
    }
  }

  void _distrubuteToList({
    required String hourlyMapKey,
    int? hourlyListIndex,
    required int temp,
    required int hour,
  }) {
    final nextHourRoundedDown =
        _now.add(Duration(hours: hour)).roundedDownToNearestHour();
    final nextHourRoundedUp =
        _now.add(Duration(hours: hour)).roundedUpToNearestHour();

    hourlyForecastHorizontalScrollWidgetMap[hourlyMapKey]!.add(_hourColumn);

    /// If a sun time happens to land on an even hour, this replaces the normal
    /// hourly widget with the sun time widget

    if (_sunTimes.sunriseTime!
        .isSameTime(comparisonTime: nextHourRoundedDown)) {
      _replaceHourlyWithSunTimeWidget(
          key: hourlyMapKey, timeString: _sunTimes.sunriseString);
    }

    if (_sunTimes.sunsetTime!.isSameTime(comparisonTime: nextHourRoundedDown)) {
      _replaceHourlyWithSunTimeWidget(
          key: hourlyMapKey, timeString: _sunTimes.sunsetString);
    }

    final bool sunriseInBetween = TimeZoneController.to.sunTimeIsInBetween(
        sunTime: _sunTimes.sunriseTime!,
        start: nextHourRoundedDown,
        end: nextHourRoundedUp);

    final bool sunsetInBetween = TimeZoneController.to.sunTimeIsInBetween(
        sunTime: _sunTimes.sunsetTime!,
        start: nextHourRoundedDown,
        end: nextHourRoundedUp);

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

  void _replaceHourlyWithSunTimeWidget(
      {required String key, required String timeString}) {
    final list = hourlyForecastHorizontalScrollWidgetMap[key]!;
    final index = list.length - 1;
    list[index] = ScrollWidgetColumn(
      temp: _hourlyTemp,
      iconPath: sunriseIcon,
      precipitation: _precipitation,
      header: timeString,
    );
  }

  void _handlePotentialConversions(int i) {
    if (_settingsMap[precipInMmKey]! as bool) {
      _precipitationAmount = UnitConverter.convertInchesToMillimeters(
          inches: _precipitationAmount);
    }

    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      _hourlyTemp = UnitConverter.toCelcius(_hourlyTemp);
      _feelsLike = UnitConverter.toCelcius(int.parse(_feelsLike)).toString();
    }

    if (_settingsMap[speedInKphKey]! as bool) {
      _windSpeed = UnitConverter.convertMilesToKph(miles: _windSpeed);
    }
  }

  void _clearLists() {
    hourlyForecastHorizontalScrollWidgetMap['next_24_hrs']!.clear();

    hourRowList.clear();

    for (int i = 0; i < 4; i++) {
      minAndMaxTempList[i].clear();
    }

    for (final list in hourlyForecastHorizontalScrollWidgetMap.values) {
      list.clear();
    }
  }
}
