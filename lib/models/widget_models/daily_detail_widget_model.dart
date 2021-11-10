import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/weather_forecast/forecast_controllers.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

import '../sun_time_model.dart';

class DailyDetailWidgetModel extends Equatable {
  const DailyDetailWidgetModel({
    required this.dailyTemp,
    required this.feelsLikeDay,
    required this.index,
    required this.highTemp,
    required this.lowTemp,
    required this.iconPath,
    required this.day,
    required this.month,
    required this.year,
    required this.date,
    required this.condition,
    required this.tempUnit,
    required this.speedUnit,
    required this.precipitationType,
    required this.extendedHourlyForecastKey,
    required this.sunTime,
    required this.precipitationAmount,
    required this.windSpeed,
    required this.precipitationProbability,
  });

  final int index;
  final int dailyTemp;
  final int feelsLikeDay;
  final int? highTemp;
  final int? lowTemp;

  final num precipitationAmount;
  final num windSpeed;
  final num precipitationProbability;

  final String precipitationType;
  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String condition;
  final String tempUnit;
  final String speedUnit;
  final String? extendedHourlyForecastKey;

  final SunTimesModel sunTime;

  factory DailyDetailWidgetModel.fromValues({
    required WeatherData values,
    required int index,
  }) {
    final settingsMap = StorageController.to.settingsMap;
    final precipInMm = settingsMap[precipInMmKey] as bool;
    final tempUnitsMetric = settingsMap[tempUnitsMetricKey] as bool;
    final now = CurrentWeatherController.to.currentTime;
    DateTimeFormatter.initNextDay(index);

    late List<int>? tempList;

    if (index.isInRange(0, 3)) {
      tempList = HourlyForecastController.to.minAndMaxTempList[index];
      tempList.sort();
    } else {
      tempList = null;
    }

    final dailyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(values.weatherCode);

    return DailyDetailWidgetModel(
      index: index,
      dailyTemp: tempUnitsMetric
          ? UnitConverter.toCelcius(temp: values.temperature)
          : values.temperature,
      feelsLikeDay: tempUnitsMetric
          ? UnitConverter.toCelcius(temp: values.feelsLikeTemp)
          : values.feelsLikeTemp,
      highTemp: tempList == null
          ? null
          : tempUnitsMetric
              ? UnitConverter.toCelcius(temp: tempList.last)
              : tempList.last,
      lowTemp: tempList == null
          ? null
          : tempUnitsMetric
              ? UnitConverter.toCelcius(temp: tempList.first)
              : tempList.first,
      precipitationAmount: _initPrecipAmount(
        precipIntensity: values.precipitationIntensity,
        precipInMm: precipInMm,
      ),
      windSpeed: _initWindSpeed(
        speed: values.windSpeed,
        speedInKm: settingsMap[speedInKphKey] as bool,
      ),
      precipitationProbability: values.precipitationProbability.round(),
      precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
        code: values.precipitationType,
      ),
      iconPath: IconController.getIconImagePath(
        hourly: false,
        condition: dailyCondition,
      ),
      day: DateTimeFormatter.getNext7Days(now.weekday + index),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      tempUnit: CurrentWeatherController.to.tempUnitString,
      speedUnit: CurrentWeatherController.to.speedUnitString,
      extendedHourlyForecastKey:
          HourlyForecastController.to.hourlyForecastMapKey(index: index),
      sunTime: SunTimeController.to.sunTimeList[index],
    );
  }

  static num _initWindSpeed({required num speed, required bool speedInKm}) {
    if (speedInKm) {
      return UnitConverter.convertMilesToKph(miles: speed);
    } else {
      return UnitConverter.convertFeetPerSecondToMph(feetPerSecond: speed)
          .round();
    }
  }

  static num _initPrecipAmount({
    num? precipIntensity,
    required bool precipInMm,
  }) {
    final precip = precipIntensity ?? 0.0;
    num convertedPrecip = num.parse(precip.toStringAsFixed(2));
    if (precipInMm) {
      convertedPrecip = UnitConverter.convertInchesToMillimeters(
        inches: convertedPrecip,
      );
    }
    return convertedPrecip;
  }

  @override
  List<Object?> get props => [
        dailyTemp,
        feelsLikeDay,
        index,
        highTemp,
        lowTemp,
        iconPath,
        day,
        month,
        year,
        date,
        condition,
        tempUnit,
        speedUnit,
        precipitationType,
        extendedHourlyForecastKey,
        sunTime,
        precipitationAmount,
        windSpeed,
        precipitationProbability,
      ];
}
