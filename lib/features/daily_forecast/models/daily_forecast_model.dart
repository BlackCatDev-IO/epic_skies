import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
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
    required this.suntime,
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

  final SunTimesModel suntime;

  factory DailyForecastModel.fromWeatherData({
    required WeatherData data,
    required int index,
    required DateTime currentTime,
    required int? highTemp,
    required int? lowTemp,
    required String? hourlyKey,
    required SunTimesModel suntime,
  }) {
    DateTimeFormatter.initNextDay(i: index, currentTime: currentTime);

    final dailyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode);

    final precipType = WeatherCodeConverter.getPrecipitationTypeFromCode(
      code: data.precipitationType,
    );

    final today = currentTime.weekday;

    return DailyForecastModel(
      index: index,
      dailyTemp: data.temperature,
      feelsLikeDay: data.feelsLikeTemp,
      highTemp: highTemp,
      lowTemp: lowTemp,
      precipitationAmount: _initPrecipAmount(
        precipIntensity: data.precipitationIntensity,
      ),
      precipUnit: data.unitSettings.precipInMm ? 'mm' : 'in',
      windSpeed: data.windSpeed,
      precipitationProbability: data.precipitationProbability.round(),
      precipitationType: precipType,
      iconPath: IconController.getIconImagePath(
        condition: dailyCondition,
        temp: data.temperature,
        tempUnitsMetric: data.unitSettings.tempUnitsMetric,
      ),
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      tempUnit: data.unitSettings.tempUnitsMetric ? 'C' : 'F',
      speedUnit: data.unitSettings.speedInKph ? 'kph' : 'mph',
      extendedHourlyForecastKey: hourlyKey,
      suntime: suntime,
      precipIconPath: precipType == ''
          ? null
          : IconController.getPrecipIconPath(precipType: precipType),
    );
  }

  static num _initPrecipAmount({
    num? precipIntensity,
  }) {
    final precip = precipIntensity ?? 0.0;

    return num.parse(precip.toStringAsFixed(2));
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
        suntime,
        precipitationAmount,
        windSpeed,
        precipitationProbability,
      ];
}
