import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:get/get.dart';

class ConversionController {
  HourlyForecastController hourlyForecastController;
  DailyForecastController dailyForecastController;
  CurrentWeatherController currentWeatherController;
  SettingsController settingsController;
  StorageController storageController;

  bool _needsConversion = false;

/* -------------------------------------------------------------------------- */
/*                               RAW CONVERSIONS                              */
/* -------------------------------------------------------------------------- */

  int _toCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  int _toFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();

  double _convertMetersPerSecondToKph(num meters) =>
      (meters * 3.6).toDouble().toPrecision(2);

  double _convertFeetPerSecondToMph(num feet) =>
      (feet / 1.467).toDouble().toPrecision(2);

  double convertSpeedUnitsToPerHour(num speed) {
    _findControllers();
    if (settingsController.tempUnitsMetric.value) {
      return _convertMetersPerSecondToKph(speed);
    } else {
      return _convertFeetPerSecondToMph(speed);
    }
  }

  double roundTo2digitsPastDecimal(num precip) {
    final conversion = precip.toDouble().toPrecision(2);
    if (conversion == 0.0 || conversion == 0.00) {
      return 0;
    } else {
      return conversion;
    }
  }

  double _convertInchesToMillimeters(num inches) =>
      (inches * 25.4).toDouble().toPrecision(2);

  double _convertMillimetersToInches(num mm) =>
      (mm / 25.4).toDouble().toPrecision(2);

  double _convertMilesToKph(num miles) =>
      (miles * 1.609344).toDouble().toPrecision(2);

  double _convertKilometersToMph(num kilometers) =>
      (kilometers * 0.62137119223733).toDouble().toPrecision(2);

/* -------------------------------------------------------------------------- */
/*                       GLOBAL APP TEMP UNIT CONVERSION                      */
/* -------------------------------------------------------------------------- */

  Future<void> convertAppTempUnit() async {
    _findControllers();
    _convertCurrentTempValues();
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }

/* -------------------------------------------------------------------------- */
/*                          CURRENT TEMP CONVERSIONS                          */
/* -------------------------------------------------------------------------- */

  Future<void> _convertCurrentTempValues() async {
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
        _toCelcius(currentWeatherController.temp);
    currentWeatherController.feelsLike =
        _toCelcius(currentWeatherController.feelsLike);
  }

  void _convertCurrentTempToFahrenheit() {
    currentWeatherController.temp =
        _toFahrenHeight(currentWeatherController.temp);
    currentWeatherController.feelsLike =
        _toFahrenHeight(currentWeatherController.feelsLike);
  }

/* -------------------------------------------------------------------------- */
/*                         HOURLY VALUE CONVERSIONS                           */
/* -------------------------------------------------------------------------- */

  void convertHourlyValues(int i) {
    _findControllers();
    _needsConversion = settingsController.needsConversion();

    if (settingsController.convertingTempUnits) {
      _convertHourlyTempUnits(i);
    }
    if (settingsController.convertingPrecipUnits ||
        settingsController.mismatchedPrecipUnitSetting()) {
      _convertHourlyPrecipValues(i);
    }
    if (settingsController.convertingSpeedUnits ||
        settingsController.mismatchedSpeedUnitSetting()) {
      _convertHourlyWindSpeed(i);
    }
  }

  void _convertHourlyTempUnits(int i) {
    if (_needsConversion) {
      if (settingsController.tempUnitsMetric.value) {
        hourlyForecastController.hourlyTemp =
            _toCelcius(int.parse(hourlyForecastController.hourlyTemp))
                .toString();
        hourlyForecastController.feelsLike =
            _toCelcius(int.parse(hourlyForecastController.feelsLike))
                .toString();
      } else {
        hourlyForecastController.hourlyTemp = _toFahrenHeight(
                int.parse(hourlyForecastController.hourlyTemp))
            .toString();
        hourlyForecastController.feelsLike = _toFahrenHeight(
                int.parse(hourlyForecastController.feelsLike))
            .toString();
      }
      _storeConvertedHourlyTempValues(i);
    }
  }

  void _convertHourlyPrecipValues(int i) {
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
    _storeConvertedHourlyPrecipValues(i);
  }

  void _convertHourlyWindSpeed(int i) {
    if (settingsController.tempUnitSettingChangesSinceRefresh.isOdd) {
      return;
    }
    switch (settingsController.speedInKm.value) {
      case true:
        {
          hourlyForecastController.windSpeed =
              _convertMilesToKph(hourlyForecastController.windSpeed);
        }
        break;
      case false:
        {
          hourlyForecastController.windSpeed =
              _convertKilometersToMph(hourlyForecastController.windSpeed);
        }
        break;
    }
    _storeConvertedWindSpeedValues(i);
  }

  void _storeConvertedHourlyTempValues(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperature'] = int.parse(hourlyForecastController.hourlyTemp);
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperatureApparent'] = int.parse(hourlyForecastController.feelsLike);

    storageController.updateDatamapStorage();
  }

  void _storeConvertedHourlyPrecipValues(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
            ['precipitationIntensity'] =
        hourlyForecastController.precipitationAmount;

    storageController.updateDatamapStorage();
  }

  void _storeConvertedWindSpeedValues(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['windSpeed'] = hourlyForecastController.windSpeed;

    storageController.updateDatamapStorage();
  }

/* -------------------------------------------------------------------------- */
/*                        DAILY VALUE CONVERSIONS                             */
/* -------------------------------------------------------------------------- */

  void handlePotentialDailyConversions(int i) {
    _findControllers();
    if (_needsConversion) {
      if (settingsController.tempUnitsMetric.value &&
          settingsController.convertingTempUnits) {
        _convertDailyValuesToCelcius(i);
      }

      if (!settingsController.tempUnitsMetric.value &&
          settingsController.convertingTempUnits) {
        _convertDailyValuesToFahrenHeight(i);
      }
    }
  }

  void _convertDailyValuesToCelcius(int i) {
    dailyForecastController.dailyTemp =
        _toCelcius(dailyForecastController.dailyTemp);

    dailyForecastController.feelsLikeDay =
        _toCelcius(dailyForecastController.feelsLikeDay);

    _storeUpdatedTempUnits(i);
  }

  void _convertDailyValuesToFahrenHeight(int i) {
    dailyForecastController.dailyTemp =
        _toFahrenHeight(dailyForecastController.dailyTemp);
    dailyForecastController.feelsLikeDay =
        _toFahrenHeight(dailyForecastController.feelsLikeDay);

    _storeUpdatedTempUnits(i);
  }

  void _storeUpdatedTempUnits(int i) {
    storageController.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperature'] = dailyForecastController.dailyTemp;
    storageController.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperatureApparent'] = dailyForecastController.feelsLikeDay;

    storageController.updateDatamapStorage();
  }

  void _findControllers() {
    hourlyForecastController = Get.find<HourlyForecastController>();
    dailyForecastController = Get.find<DailyForecastController>();
    currentWeatherController = Get.find<CurrentWeatherController>();
    settingsController = Get.find<SettingsController>();
    storageController = Get.find<StorageController>();
    settingsController = Get.find<SettingsController>();
  }
}
