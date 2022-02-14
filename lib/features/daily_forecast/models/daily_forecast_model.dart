import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

class DailyForecastModel extends Equatable {
  const DailyForecastModel({
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
    required this.precipUnit,
    required this.extendedHourlyForecastKey,
    required this.sunTime,
    required this.precipitationAmount,
    required this.windSpeed,
    required this.precipitationProbability,
    required this.precipIconPath,
  });

  final int index;
  final int dailyTemp;
  final int feelsLikeDay;
  final int? highTemp;
  final int? lowTemp;

  final num precipitationAmount;
  final int windSpeed;
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
  final String precipUnit;
  final String? extendedHourlyForecastKey;
  final String? precipIconPath;

  final SunTimesModel sunTime;

  factory DailyForecastModel.fromWeatherData({
    required WeatherData data,
    required int index,
    required int hourlyIndex,
  }) {
    final now = CurrentWeatherController.to.currentTime;
    DateTimeFormatter.initNextDay(index);

    late List<int>? tempList;

    if (hourlyIndex.isInRange(0, 3)) {
      tempList = HourlyForecastController.to.minAndMaxTempList[hourlyIndex];
      tempList.sort();
    } else {
      tempList = null;
    }

    final dailyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode);

    final dailyTemp = data.unitSettings.tempUnitsMetric
        ? UnitConverter.toCelcius(temp: data.temperature)
        : data.temperature;

    final precipType = WeatherCodeConverter.getPrecipitationTypeFromCode(
      code: data.precipitationType,
    );

    return DailyForecastModel(
      index: index,
      dailyTemp: dailyTemp,
      feelsLikeDay: data.unitSettings.tempUnitsMetric
          ? UnitConverter.toCelcius(temp: data.feelsLikeTemp)
          : data.feelsLikeTemp,
      highTemp: tempList == null
          ? null
          : data.unitSettings.tempUnitsMetric
              ? UnitConverter.toCelcius(temp: tempList.last)
              : tempList.last,
      lowTemp: tempList == null
          ? null
          : data.unitSettings.tempUnitsMetric
              ? UnitConverter.toCelcius(temp: tempList.first)
              : tempList.first,
      precipitationAmount: _initPrecipAmount(
        precipIntensity: data.precipitationIntensity,
        precipInMm: data.unitSettings.precipInMm,
      ),
      precipUnit: data.unitSettings.precipInMm ? 'mm' : 'in',
      windSpeed: _initWindSpeed(
        speed: data.windSpeed,
        speedInKph: data.unitSettings.speedInKph,
      ),
      precipitationProbability: data.precipitationProbability.round(),
      precipitationType: precipType,
      iconPath: IconController.getIconImagePath(
        condition: dailyCondition,
        temp: dailyTemp,
        tempUnitsMetric: data.unitSettings.tempUnitsMetric,
      ),
      day: DateTimeFormatter.getNext7Days(now.weekday + index),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      tempUnit: data.unitSettings.tempUnitsMetric ? 'C' : 'F',
      speedUnit: data.unitSettings.speedInKph ? 'kph' : 'mph',
      extendedHourlyForecastKey:
          HourlyForecastController.to.hourlyForecastMapKey(index: hourlyIndex),
      sunTime: SunTimeController.to.sunTimeList[index],
      precipIconPath: precipType == ''
          ? null
          : IconController.getPrecipIconPath(precipType: precipType),
    );
  }

  static int _initWindSpeed({required num speed, required bool speedInKph}) {
    if (speedInKph) {
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
