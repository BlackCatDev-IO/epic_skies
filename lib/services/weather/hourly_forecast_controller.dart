import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HourlyForecastController extends GetxController {
  static HourlyForecastController get to => Get.find();

  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  final conversionController = ConversionController();

  RxList hourColumns = [].obs;
  RxList hourRowList = [].obs;

  Map dataMap = {};
  Map valuesMap = {};

  String precipitation,
      precipitationType,
      hourlyTemp,
      hourlyCondition,
      feelsLike,
      iconPath,
      timeAtNextHour;

  int today, now, precipitationCode;

  num precipitationAmount, windSpeed;

  Future<void> buildHourlyForecastWidgets() async {
    dataMap = StorageController.to.dataMap;
    today = DateTime.now().weekday;
    now = DateTime.now().hour;

    _build24HrWidgets();
  }

  void _build24HrWidgets() {
    if (hourColumns.isNotEmpty && hourRowList.isNotEmpty) {
      hourColumns.clear();
      hourRowList.clear();
    }

    for (int i = 0; i <= 24; i++) {
      _initHourlyData(i);
      final hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: timeAtNextHour,
      );

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
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  Future<void> _initHourlyData(int i) async {
    valuesMap = dataMap['timelines'][0]['intervals'][i]['values'] as Map;
    final bool timeSetting = SettingsController.to.timeIs24Hrs.value;

    timeAtNextHour =
        dateFormatter.formatTime(hour: now + 1 + i, timeIs24hrs: timeSetting);

    final weatherCode = valuesMap['weatherCode'];
    hourlyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int);

    hourlyTemp = valuesMap['temperature'].round().toString();
    feelsLike = valuesMap['temperatureApparent'].round().toString();

    precipitation = valuesMap['precipitationProbability'].round().toString();
    precipitationCode = valuesMap['precipitationType'] as int;
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = valuesMap['precipitationIntensity'] ?? 0.0;
    precipitationAmount =
        conversionController.roundTo2digitsPastDecimal(precip as num);
    windSpeed = conversionController
        .convertSpeedUnitsToPerHour(valuesMap['windSpeed'] as num);
    final startTime =
        dataMap['timelines'][0]['intervals'][i]['startTime'] as String;

    // debugPrint(
    //     'wind speed before: ${valuesMap['windSpeed']} wind speed after hour conversion: $windSpeed');
    iconPath = iconController.getIconImagePath(
        condition: hourlyCondition, time: startTime, origin: 'Hourly');
    // debugPrint('mismatch: ${settingsController.mismatchedMetricSettings()}');
    if (SettingsController.to.settingHasChanged ||
        SettingsController.to.mismatchedMetricSettings()) {
      conversionController.convertHourlyValues(i);
      // debugPrint('wind speed after final conversion: $windSpeed');
    }
  }
}
