import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:get/get.dart';

class ConversionController {
/* -------------------------------------------------------------------------- */
/*                               RAW CONVERSIONS                              */
/* -------------------------------------------------------------------------- */

  int _toCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  int _toFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();

  double convertFeetPerSecondToMph(num feet) =>
      (feet / 1.467).toDouble().toPrecision(2);

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

  double _convertMilesToKph(num miles) =>
      (miles * 1.609344).toDouble().toPrecision(2);

/* -------------------------------------------------------------------------- */
/*                       GLOBAL APP TEMP UNIT CONVERSION                      */
/* -------------------------------------------------------------------------- */

  Future<void> convertAppTempUnit() async {
    convertCurrentTempValues();
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }

/* -------------------------------------------------------------------------- */
/*                          CURRENT TEMP CONVERSIONS                          */
/* -------------------------------------------------------------------------- */

  Future<void> convertCurrentTempValues() async {
    if (SettingsController.to.tempUnitsMetric) {
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

  void convertHourlyTempUnits(int i) {
    HourlyForecastController.to.hourlyTemp =
        _toCelcius(int.parse(HourlyForecastController.to.hourlyTemp))
            .toString();
    HourlyForecastController.to.feelsLike =
        _toCelcius(int.parse(HourlyForecastController.to.feelsLike)).toString();
  }

  void convertHourlyPrecipValues(int i) {
    HourlyForecastController.to.precipitationAmount =
        _convertInchesToMillimeters(
            HourlyForecastController.to.precipitationAmount);
  }

  void convertHourlyWindSpeedToKph(int i) {
    HourlyForecastController.to.windSpeed =
        _convertMilesToKph(HourlyForecastController.to.windSpeed);
  }
/* -------------------------------------------------------------------------- */
/*                        DAILY VALUE CONVERSIONS                             */
/* -------------------------------------------------------------------------- */

  void convertDailyTempUnits(int i) {
    DailyForecastController.to.dailyTemp =
        _toCelcius(DailyForecastController.to.dailyTemp);

    DailyForecastController.to.feelsLikeDay =
        _toCelcius(DailyForecastController.to.feelsLikeDay);
  }

  void convertDailyPrecipValues(int i) {
    DailyForecastController.to.precipitationAmount =
        _convertInchesToMillimeters(
            DailyForecastController.to.precipitationAmount);
  }

  void convertDailyWindSpeed(int i) {
    DailyForecastController.to.windSpeed =
        _convertMilesToKph(DailyForecastController.to.windSpeed);
  }
}
