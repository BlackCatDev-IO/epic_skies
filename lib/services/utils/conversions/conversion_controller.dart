import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ConversionController {
  var hourlyForecastController;
  var dailyForecastController;
  var currentWeatherController;
  var settingsController;
  var storageController;

  void findControllers() {
    debugPrint('Controllers found');
    hourlyForecastController = Get.find<HourlyForecastController>();
    dailyForecastController = Get.find<DailyForecastController>();
    currentWeatherController = Get.find<CurrentWeatherController>();
    settingsController = Get.find<SettingsController>();
    storageController = Get.find<StorageController>();
    settingsController = Get.find<SettingsController>();
  }

  int _convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  int _convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();

  num _convertInchesToMillimeters(num inches) => inches * 25.4;

  num _convertMillimetersToInches(num mm) => mm / 25.4;

  Future<void> convertAppToCelcius() async {
    findControllers();
    _convertCurrentTempValues();
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }

  Future<void> _convertCurrentTempValues() async {
    debugPrint('convertCurrentTempValues');

    if (settingsController.tempUnitsMetric.value) {
      _convertCurrentTempToCelcius();
    } else {
      _convertCurrentTempToFahrenheit();
    }
    storageController.storeUpdatedCurrentTempValues(
        currentWeatherController.temp, currentWeatherController.feelsLike);
    currentWeatherController.update();
    settingsController.update();
  }

  void _convertCurrentTempToCelcius() {
    currentWeatherController.temp =
        _convertToCelcius(currentWeatherController.temp);
    currentWeatherController.feelsLike =
        _convertToCelcius(currentWeatherController.feelsLike);
  }

  void _convertCurrentTempToFahrenheit() {
    currentWeatherController.temp =
        _convertToFahrenHeight(currentWeatherController.temp);
    currentWeatherController.feelsLike =
        _convertToFahrenHeight(currentWeatherController.feelsLike);
  }

/* -------------------------------------------------------------------------- */
/*                         HOURLY VALUE CONVERSIONS                           */
/* -------------------------------------------------------------------------- */

  void handlePotentialHourlyConversions(int i) {
    findControllers();
    if (settingsController.convertingTempUnits) {
      _convertHourlyTempUnits(i);
    }
    if (settingsController.convertingMeasurementUnits) {
      _convertHourlyMeasurementUnits(i);
    }
    if (settingsController.convertingSpeedUnits) {
      _convertWindSpeed(i);
    }
  }

  void _convertHourlyTempUnits(int i) {
    if (settingsController.tempUnitsMetric.value) {
      hourlyForecastController.hourlyTemp =
          _convertToCelcius(int.parse(hourlyForecastController.hourlyTemp))
              .toString();
      hourlyForecastController.feelsLike =
          _convertToCelcius(int.parse(hourlyForecastController.feelsLike))
              .toString();
    } else {
      hourlyForecastController.hourlyTemp =
          _convertToFahrenHeight(int.parse(hourlyForecastController.hourlyTemp))
              .toString();
      hourlyForecastController.feelsLike =
          _convertToFahrenHeight(int.parse(hourlyForecastController.feelsLike))
              .toString();
    }
    _storeUpdatedHoulyTempUnits(i);
  }

  void _convertHourlyMeasurementUnits(int i) {
    final bool needsConversion =
        settingsController.unitSettingChangesSinceRefresh.isOdd;

    if (needsConversion) {
      switch (settingsController.precipInMm.value) {
        case true:
          {
            hourlyForecastController.precipitationAmount =
                _convertInchesToMillimeters(
                    hourlyForecastController.precipitationAmount);
          }
          break;
        case false:
          {
            hourlyForecastController.precipitationAmount =
                _convertMillimetersToInches(
                    hourlyForecastController.precipitationAmount);
          }
          break;
      }
    }
    _storeUpdatedMeasurementUnits(i);
  }

  void _convertWindSpeed(int i) {}

  void _storeUpdatedHoulyTempUnits(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperature'] = int.parse(hourlyForecastController.hourlyTemp);
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperatureApparent'] = int.parse(hourlyForecastController.feelsLike);

    storageController.updateDatamapStorage();
  }

  void _storeUpdatedMeasurementUnits(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
            ['precipitationIntensity'] =
        hourlyForecastController.precipitationAmount;

    storageController.updateDatamapStorage();
  }

/* -------------------------------------------------------------------------- */
/*                        DAILY VALUE CONVERSIONS                             */
/* -------------------------------------------------------------------------- */

  void handlePotentialDailyConversions(int i) {
    findControllers();
    if (settingsController.tempUnitsMetric.value &&
        settingsController.convertingTempUnits) {
      _convertDailyValuesToCelcius(i);
    }

    if (!settingsController.tempUnitsMetric.value &&
        settingsController.convertingTempUnits) {
      _convertDailyValuesToFahrenHeight(i);
    }
  }

  void _convertDailyValuesToCelcius(int i) {
    dailyForecastController.dailyTemp =
        _convertToCelcius(dailyForecastController.dailyTemp);

    dailyForecastController.feelsLikeDay =
        _convertToCelcius(dailyForecastController.feelsLikeDay);

    _storeUpdatedTempUnits(i);
  }

  void _convertDailyValuesToFahrenHeight(int i) {
    dailyForecastController.dailyTemp =
        _convertToFahrenHeight(dailyForecastController.dailyTemp);
    dailyForecastController.feelsLikeDay =
        _convertToFahrenHeight(dailyForecastController.feelsLikeDay);

    _storeUpdatedTempUnits(i);
  }

  void _storeUpdatedTempUnits(int i) {
    storageController.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperature'] = dailyForecastController.dailyTemp;
    storageController.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperatureApparent'] = dailyForecastController.feelsLikeDay;

    storageController.updateDatamapStorage();
  }
}
