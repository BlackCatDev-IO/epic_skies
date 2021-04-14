import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class HourlyForecastController extends GetxController {
  static HourlyForecastController get to => Get.find();

  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  final _unitConverter = UnitConverter();

  List twentyFourHourColumnList = [];
  List hourRowList = [];

  /// each index is for display on the hourly portion of the dailyDetailWidgets
  /// 4 lists for the next 4 days of the available 108 hours of hourly forecast
  List<List<Widget>> extendedHourlyColumnList = [[], [], [], []];

  DateTime startTime;

  Duration timezoneOffset;

  Map dataMap = {};
  Map valuesMap = {};

  String precipitation,
      precipitationType,
      hourlyTemp,
      hourlyCondition,
      feelsLike,
      iconPath,
      timeAtNextHour;

  int today, now, precipitationCode, hoursUntilNext6am;

  num precipitationAmount, windSpeed;

  bool isDay;

  Future<void> buildHourlyForecastWidgets() async {
    dataMap = StorageController.to.dataMap;
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

      final hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: timeAtNextHour,
      );
      if (i.isInRange(1, 24)) {
        final hourlyDetailedRow = HourlyDetailedRow(
          temp: hourlyTemp,
          iconPath: iconPath,
          precipitationProbability: precipitation,
          time: timeAtNextHour,
          feelsLike: feelsLike,
          condition: hourlyCondition,
          precipitationType: precipitationType,
          precipitationCode: precipitationCode,
          precipitationAmount: precipitationAmount,
          precipUnit: SettingsController.to.precipUnitString,
          windSpeed: windSpeed,
          speedUnit: SettingsController.to.speedUnitString,
        );
        twentyFourHourColumnList.add(hourColumn);
        hourRowList.add(hourlyDetailedRow);
      }

      if (i >= hoursUntilNext6am) {
        _sortExtendedHourlyLists(i, hourColumn);
      }
    }
  }

  Future<void> _initHourlyData(int i) async {
    valuesMap = dataMap['timelines'][0]['intervals'][i]['values'] as Map;

    if (i <= 24) {
      windSpeed = _unitConverter
          .convertFeetPerSecondToMph(valuesMap['windSpeed'] as num);
    }
    _initPrecipValues();
    _initHourlyConditions();
    _initHourlyTimeValues(i);
    _handlePotentialConversions(i);

    iconPath = iconController.getIconImagePath(
        condition: hourlyCondition, time: startTime, origin: 'Hourly');
  }

  void _initPrecipValues() {
    precipitation = valuesMap['precipitationProbability'].round().toString();
    precipitationCode = valuesMap['precipitationType'] as int;
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = valuesMap['precipitationIntensity'] ?? 0.0;
    precipitationAmount =
        _unitConverter.roundTo2digitsPastDecimal(precip as num);
  }

  void _initHourlyTimeValues(int i) {
    hourlyTemp = valuesMap['temperature'].round().toString();
    timezoneOffset = TimeZoneController.to.timezoneOffset;
    startTime = DateTime.parse(
            dataMap['timelines'][0]['intervals'][i]['startTime'] as String)
        .add(timezoneOffset);
    // if (startTime.minute > 29) {
    //   startTime = startTime.add(const Duration(
    //       hours: 1)); // INTL formatting always rounds the hour down
    // }
    timeAtNextHour = dateFormatter.formatTimeToHour(time: startTime);
  }

  void _initHourlyConditions() {
    final weatherCode = valuesMap['weatherCode'];
    hourlyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int);
    feelsLike = valuesMap['temperatureApparent'].round().toString();
  }

  void _sortExtendedHourlyLists(int hour, HourColumn hourColumn) {
    final nextDay = hoursUntilNext6am + 24;
    final nextHour = hour + 1;

    if (nextHour.isInRange(hoursUntilNext6am, nextDay)) {
      extendedHourlyColumnList[0].add(hourColumn);
    } else if (nextHour.isInRange(nextDay, nextDay + 24)) {
      extendedHourlyColumnList[1].add(hourColumn);
    } else if (nextHour.isInRange(nextDay + 24, nextDay + 48)) {
      extendedHourlyColumnList[2].add(hourColumn);
    } else if (nextHour.isInRange(nextDay + 24, nextDay + 72)) {
      extendedHourlyColumnList[3].add(hourColumn);
    }
  }

  void _handlePotentialConversions(int i) {
    if (SettingsController.to.precipInMm) {
      precipitationAmount =
          _unitConverter.convertInchesToMillimeters(precipitationAmount);
    }

    if (SettingsController.to.tempUnitsMetric) {
      hourlyTemp = _unitConverter.toCelcius(int.parse(hourlyTemp)).toString();
      feelsLike = _unitConverter.toCelcius(int.parse(feelsLike)).toString();
    }

    if (SettingsController.to.speedInKm) {
      windSpeed = _unitConverter.convertMilesToKph(windSpeed);
    }
  }

  void _clearLists() {
    twentyFourHourColumnList.clear();
    hourRowList.clear();

    for (int i = 0; i < 4; i++) {
      extendedHourlyColumnList[i].clear();
    }
  }
}
