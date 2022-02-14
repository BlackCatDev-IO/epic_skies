import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:equatable/equatable.dart';

class HourlyForecastModel extends Equatable {
  const HourlyForecastModel({
    required this.iconPath,
    required this.time,
    required this.feelsLike,
    required this.precipitationType,
    required this.precipUnit,
    required this.speedUnit,
    required this.condition,
    required this.temp,
    required this.precipitationCode,
    required this.precipitationAmount,
    required this.precipitationProbability,
    required this.windSpeed,
  });

  final int temp;
  final int feelsLike;
  final int precipitationCode;

  final num precipitationAmount;
  final num precipitationProbability;
  final int windSpeed;

  final String iconPath;
  final String time;
  final String precipitationType;
  final String precipUnit;
  final String speedUnit;
  final String condition;

  factory HourlyForecastModel.fromWeatherData({
    required WeatherData data,
    required int index,
  }) {
    final hourlyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode);

    final startTime = WeatherRepository.to.weatherModel!
        .timelines[Timelines.hourly].intervals[index].data.startTime;

    final temp = data.unitSettings.tempUnitsMetric
        ? UnitConverter.toCelcius(temp: data.temperature)
        : data.temperature;

    final feelsLike = data.unitSettings.tempUnitsMetric
        ? UnitConverter.toCelcius(temp: data.feelsLikeTemp)
        : data.temperature;

    final iconPath = IconController.getIconImagePath(
      condition: hourlyCondition,
      time: startTime,
      index: index,
      temp: temp,
      tempUnitsMetric: data.unitSettings.tempUnitsMetric,
    );

    return HourlyForecastModel(
      temp: temp,
      feelsLike: feelsLike,
      precipitationAmount: _initPrecipAmount(
        precip: data.precipitationIntensity,
        precipInMm: data.unitSettings.precipInMm,
      ),
      precipitationCode: data.precipitationType,
      precipUnit: data.unitSettings.precipInMm ? 'mm' : 'in',
      precipitationProbability: data.precipitationProbability.round(),
      windSpeed: _initWindSpeed(
        speed: data.windSpeed,
        speedInKph: data.unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(time: startTime, timeIn24hrs: data.unitSettings.timeIn24Hrs),
      precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
        code: data.precipitationType,
      ),
      speedUnit: data.unitSettings.speedInKph ? 'kph' : 'mph',
      condition:
          WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode),
    );
  }

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        precipitationAmount,
        precipitationCode,
        precipUnit,
        precipitationProbability,
        windSpeed,
        iconPath,
        time,
        precipitationType,
        speedUnit,
        condition
      ];
}

num _initPrecipAmount({required bool precipInMm, required num precip}) {
  late num convertedPrecip;
  if (precipInMm) {
    convertedPrecip = UnitConverter.convertInchesToMillimeters(
      inches: precip,
    );
  } else {
    convertedPrecip = num.parse(precip.toStringAsFixed(2));
  }
  return convertedPrecip;
}

int _initWindSpeed({required num speed, required bool speedInKph}) {
  int convertedSpeed =
      UnitConverter.convertFeetPerSecondToMph(feetPerSecond: speed).round();
  if (speedInKph) {
    convertedSpeed = UnitConverter.convertMilesToKph(miles: convertedSpeed);
  }
  return convertedSpeed;
}
