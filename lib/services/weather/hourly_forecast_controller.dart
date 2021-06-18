import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/scroll_widget_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import 'current_weather_controller.dart';

class HourlyForecastController extends GetxController {
  static HourlyForecastController get to => Get.find();

  final _weatherCodeConverter = const WeatherCodeConverter();
  final _dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  final _unitConverter = const UnitConverter();

  List twentyFourHourColumnList = [];
  List hourRowList = [];

  /// each index is for display on the hourly portion of the dailyDetailWidgets
  /// 4 lists for the next 4 days of the available 108 hours of hourly forecast
  List<List<Widget>> extendedHourlyColumnList = [[], [], [], []];
  List<List<int>> minAndMaxTempList = [[], [], [], []];

  late DateTime _startTime;

  late Duration _timezoneOffset;

  Map _dataMap = {};
  Map _valuesMap = {};
  Map _settingsMap = {};

  late String precipitationType,
      hourlyCondition,
      feelsLike,
      iconPath,
      timeAtNextHour;

  late int today,
      now,
      precipitationCode,
      hoursUntilNext6am,
      hourlyTemp,
      extendedHourlyTemp;

  late num precipitationAmount, windSpeed, precipitation;

  late bool isDay;

  late ScrollWidgetColumn hourColumn;

  @override
  void onInit() {
    super.onInit();
    if (!StorageController.to.firstTimeUse()) {
      buildHourlyForecastWidgets();
    }
  }

  Future<void> buildHourlyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    _settingsMap = StorageController.to.settingsMap;

    today = DateTime.now().weekday;
    now = DateTime.now().hour;
    hoursUntilNext6am = (24 - now) + 6;
    _clearLists();
    _buildHourlyWidgets();
    update();
  }

  void _buildHourlyWidgets() {
    for (int i = 0; i <= 107; i++) {
      _initHourlyData(i);

      hourColumn = ScrollWidgetColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: timeAtNextHour,
      );

      if (i.isInRange(1, 24)) {
        final hourlyDetailedRow = HoulyDetailedRow(
          temp: hourlyTemp,
          iconPath: iconPath,
          precipitationProbability: precipitation,
          time: timeAtNextHour,
          feelsLike: feelsLike,
          condition: hourlyCondition,
          precipitationType: precipitationType,
          precipitationCode: precipitationCode,
          precipitationAmount: precipitationAmount,
          precipUnit: CurrentWeatherController.to.precipUnitString,
          windSpeed: windSpeed,
          speedUnit: CurrentWeatherController.to.speedUnitString,
        );
        twentyFourHourColumnList.add(hourColumn);
        hourRowList.add(hourlyDetailedRow);
      }

      if (i >= hoursUntilNext6am) {
        _sortExtendedHourlyLists(i, extendedHourlyTemp);
      }
    }
  }

  Future<void> _initHourlyData(int i) async {
    _valuesMap = _dataMap['timelines'][0]['intervals'][i]['values'] as Map;

    if (i <= 24) {
      windSpeed = _unitConverter
          .convertFeetPerSecondToMph(_valuesMap['windSpeed'] as num)
          .round();
    }
    _initPrecipValues();
    _initHourlyConditions();
    _initHourlyTimeValues(i);
    _handlePotentialConversions(i);

    iconPath = iconController.getIconImagePath(
        condition: hourlyCondition, time: _startTime, origin: 'Hourly');
  }

  void _initPrecipValues() {
    precipitation = _valuesMap['precipitationProbability'].round() as num;
    precipitationCode = _valuesMap['precipitationType'] as int;
    precipitationType =
        _weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);

    if (precipitation == 0 || precipitation == 0.0) {
      precipitationType = '';
    }
    final precip = _valuesMap['precipitationIntensity'] ?? 0.0;
    precipitationAmount = precip.round() as int;
  }

  void _initHourlyTimeValues(int i) {
    hourlyTemp = _valuesMap['temperature'].round() as int;
    extendedHourlyTemp = hourlyTemp;
    _timezoneOffset = TimeZoneController.to.timezoneOffset;
    _startTime = DateTime.parse(
            _dataMap['timelines'][0]['intervals'][i]['startTime'] as String)
        .add(_timezoneOffset);
    // if (startTime.minute > 29) {
    //   startTime = startTime.add(const Duration(
    //       hours: 1)); // INTL formatting always rounds the hour down
    // }
    timeAtNextHour = _dateFormatter.formatTimeToHour(
        time: _startTime, timeIs24Hrs: _settingsMap[timeIs24HrsKey]! as bool);
  }

  void _initHourlyConditions() {
    final weatherCode = _valuesMap['weatherCode'];
    hourlyCondition =
        _weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int?);
    feelsLike = _valuesMap['temperatureApparent'].round().toString();
  }

  void _sortExtendedHourlyLists(int hour, int temp) {
    final nextDay = hoursUntilNext6am + 24;
    final nextHour = hour + 1;

    if (nextHour.isInRange(hoursUntilNext6am, nextDay)) {
      _distrubuteToList(0, temp);
    } else if (nextHour.isInRange(nextDay, nextDay + 24)) {
      _distrubuteToList(1, temp);
    } else if (nextHour.isInRange(nextDay + 24, nextDay + 48)) {
      _distrubuteToList(2, temp);
    } else if (nextHour.isInRange(nextDay + 24, nextDay + 72)) {
      _distrubuteToList(3, temp);
    }
  }

  void _distrubuteToList(int index, int temp) {
    extendedHourlyColumnList[index].add(hourColumn);

    /// range check prevents temps from after midnight being factored into daily high/low temps
    if (minAndMaxTempList[index].length <= 18) {
      minAndMaxTempList[index].add(temp);
    }
  }

  void _handlePotentialConversions(int i) {
    if (_settingsMap[precipInMmKey]! as bool) {
      precipitationAmount =
          _unitConverter.convertInchesToMillimeters(precipitationAmount);
    }

    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      hourlyTemp = _unitConverter.toCelcius(hourlyTemp);
      feelsLike = _unitConverter.toCelcius(int.parse(feelsLike)).toString();
    }

    if (_settingsMap[speedInKphKey]! as bool) {
      windSpeed = _unitConverter.convertMilesToKph(windSpeed);
    }
  }

  void _clearLists() {
    twentyFourHourColumnList.clear();
    hourRowList.clear();

    for (int i = 0; i < 4; i++) {
      extendedHourlyColumnList[i].clear();
      minAndMaxTempList[i].clear();
    }
  }
}
