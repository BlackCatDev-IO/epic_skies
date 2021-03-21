import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:get/get.dart';

class ConversionController {
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
    if (SettingsController.to.tempUnitsMetric.value) {
      return _convertMetersPerSecondToKph(speed);
    } else {
      return _convertFeetPerSecondToMph(speed);
    }
  }

  double roundTo2digitsPastDecimal(num precip) {
    if (precip == 0.0 || precip == 0.00 || precip == 0) {
      return 0;
    } else {
      return precip.toDouble().toPrecision(2);
    }
  }

  double _convertInchesToMillimeters(num inches) {
    if (inches == 0.0 || inches == 0) {
      return 0;
    } else {
      return (inches * 25.4).toDouble().toPrecision(2);
    }
  }

  double _millimetersToInches(num mm) {
    if (mm == 0.0 || mm == 0) {
      return 0;
    } else {
      return (mm / 25.4).toDouble().toPrecision(2);
    }
  }

  double _convertMilesToKph(num miles) =>
      (miles * 1.609344).toDouble().toPrecision(2);

  double _convertKilometersToMph(num kilometers) =>
      (kilometers * 0.62137119223733).toDouble().toPrecision(2);

/* -------------------------------------------------------------------------- */
/*                       GLOBAL APP TEMP UNIT CONVERSION                      */
/* -------------------------------------------------------------------------- */

  Future<void> convertAppTempUnit() async {
    _convertCurrentTempValues();
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }

/* -------------------------------------------------------------------------- */
/*                          CURRENT TEMP CONVERSIONS                          */
/* -------------------------------------------------------------------------- */

  Future<void> _convertCurrentTempValues() async {
    if (SettingsController.to.tempUnitsMetric.value) {
      _convertCurrentTempToCelcius();
    } else {
      _convertCurrentTempToFahrenheit();
    }
    StorageController.to.storeUpdatedCurrentTempValues(
        CurrentWeatherController.to.temp,
        CurrentWeatherController.to.feelsLike);
    CurrentWeatherController.to.update();
    SettingsController.to.update();
  }

  void _convertCurrentTempToCelcius() {
    CurrentWeatherController.to.temp =
        _toCelcius(CurrentWeatherController.to.temp);
    CurrentWeatherController.to.feelsLike =
        _toCelcius(CurrentWeatherController.to.feelsLike);
  }

  void _convertCurrentTempToFahrenheit() {
    CurrentWeatherController.to.temp =
        _toFahrenHeight(CurrentWeatherController.to.temp);
    CurrentWeatherController.to.feelsLike =
        _toFahrenHeight(CurrentWeatherController.to.feelsLike);
  }

/* -------------------------------------------------------------------------- */
/*                         HOURLY VALUE CONVERSIONS                           */
/* -------------------------------------------------------------------------- */

  void convertHourlyValues(int i) {
    _needsConversion = SettingsController.to.needsConversion();

    if (SettingsController.to.convertingTempUnits) {
      _convertHourlyTempUnits(i);
    }
    if (SettingsController.to.convertingPrecipUnits ||
        SettingsController.to.mismatchedPrecipUnitSetting()) {
      _convertHourlyPrecipValues(i);
    }
    if (SettingsController.to.convertingSpeedUnits ||
        SettingsController.to.mismatchedSpeedUnitSetting()) {
      _convertHourlyWindSpeed(i);
    }
  }

  void _convertHourlyTempUnits(int i) {
    if (_needsConversion) {
      if (SettingsController.to.tempUnitsMetric.value) {
        HourlyForecastController.to.hourlyTemp =
            _toCelcius(int.parse(HourlyForecastController.to.hourlyTemp))
                .toString();
        HourlyForecastController.to.feelsLike =
            _toCelcius(int.parse(HourlyForecastController.to.feelsLike))
                .toString();
      } else {
        HourlyForecastController.to.hourlyTemp =
            _toFahrenHeight(int.parse(HourlyForecastController.to.hourlyTemp))
                .toString();
        HourlyForecastController.to.feelsLike =
            _toFahrenHeight(int.parse(HourlyForecastController.to.feelsLike))
                .toString();
      }
      _storeConvertedHourlyTempValues(i);
    }
  }

  void _convertHourlyPrecipValues(int i) {
    switch (SettingsController.to.precipInMm.value) {
      case true:
        {
          HourlyForecastController.to.precipitationAmount =
              _convertInchesToMillimeters(
                  HourlyForecastController.to.precipitationAmount);
        }
        break;
      case false:
        {
          HourlyForecastController.to.precipitationAmount =
              _millimetersToInches(
                  HourlyForecastController.to.precipitationAmount);
        }
        break;
    }
    _storeConvertedHourlyPrecipValues(i);
  }

  void _convertHourlyWindSpeed(int i) {
    if (SettingsController.to.tempUnitSettingChangesSinceRefresh.isOdd) {
      return;
    }
    switch (SettingsController.to.speedInKm.value) {
      case true:
        {
          HourlyForecastController.to.windSpeed =
              _convertMilesToKph(HourlyForecastController.to.windSpeed);
        }
        break;
      case false:
        {
          HourlyForecastController.to.windSpeed =
              _convertKilometersToMph(HourlyForecastController.to.windSpeed);
        }
        break;
    }
    _storeConvertedWindSpeedValues(i);
  }

  void _storeConvertedHourlyTempValues(int i) {
    StorageController.to.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperature'] = int.parse(HourlyForecastController.to.hourlyTemp);
    StorageController.to.dataMap['timelines'][0]['intervals'][i]['values']
            ['temperatureApparent'] =
        int.parse(HourlyForecastController.to.feelsLike);

    StorageController.to.updateDatamapStorage();
  }

  void _storeConvertedHourlyPrecipValues(int i) {
    StorageController.to.dataMap['timelines'][0]['intervals'][i]['values']
            ['precipitationIntensity'] =
        HourlyForecastController.to.precipitationAmount;

    StorageController.to.updateDatamapStorage();
  }

  void _storeConvertedWindSpeedValues(int i) {
    StorageController.to.dataMap['timelines'][0]['intervals'][i]['values']
        ['windSpeed'] = HourlyForecastController.to.windSpeed;

    StorageController.to.updateDatamapStorage();
  }

/* -------------------------------------------------------------------------- */
/*                        DAILY VALUE CONVERSIONS                             */
/* -------------------------------------------------------------------------- */

  void convertDailyValues(int i) {
    _needsConversion = SettingsController.to.needsConversion();

    if (SettingsController.to.convertingTempUnits) {
      _convertDailyTempUnits(i);
    }
    if (SettingsController.to.convertingPrecipUnits ||
        SettingsController.to.mismatchedPrecipUnitSetting()) {
      _convertDailyPrecipValues(i);
    }
    if (SettingsController.to.convertingSpeedUnits ||
        SettingsController.to.mismatchedSpeedUnitSetting()) {
      _convertDailyWindSpeed(i);
    }
  }

  void _convertDailyTempUnits(int i) {
    if (_needsConversion) {
      if (SettingsController.to.tempUnitsMetric.value &&
          SettingsController.to.convertingTempUnits) {
        DailyForecastController.to.dailyTemp =
            _toCelcius(DailyForecastController.to.dailyTemp);

        DailyForecastController.to.feelsLikeDay =
            _toCelcius(DailyForecastController.to.feelsLikeDay);
      } else {
        DailyForecastController.to.dailyTemp =
            _toFahrenHeight(DailyForecastController.to.dailyTemp);
        DailyForecastController.to.feelsLikeDay =
            _toFahrenHeight(DailyForecastController.to.feelsLikeDay);
      }
      _storeUpdatedTempUnits(i);
    }
  }

  void _convertDailyPrecipValues(int i) {
    switch (SettingsController.to.precipInMm.value) {
      case true:
        {
          DailyForecastController.to.precipitationAmount =
              _convertInchesToMillimeters(
                  DailyForecastController.to.precipitationAmount);
        }
        break;
      case false:
        {
          DailyForecastController.to.precipitationAmount = _millimetersToInches(
              DailyForecastController.to.precipitationAmount);
        }
        break;
    }
    _storeConvertedHourlyPrecipValues(i);
  }

  void _convertDailyWindSpeed(int i) {}

  void _storeUpdatedTempUnits(int i) {
    StorageController.to.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperature'] = DailyForecastController.to.dailyTemp;
    StorageController.to.dataMap['timelines'][1]['intervals'][i]['values']
        ['temperatureApparent'] = DailyForecastController.to.feelsLikeDay;

    StorageController.to.updateDatamapStorage();
  }
}
