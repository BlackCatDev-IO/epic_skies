import 'dart:convert';

import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import '../../services/settings/unit_settings/unit_settings_model.dart';
import '../../utils/conversions/unit_converter.dart';

@Entity()
class WeatherResponseModel {
  WeatherResponseModel({
    required this.id,
    this.timelines = const [],
  });

  @Id(assignable: true)
  final int id;
  List<_Timeline> timelines = [];

  factory WeatherResponseModel.fromMap({
    required Map map,
    required UnitSettings unitSettings,
  }) =>
      WeatherResponseModel(
        id: 1,
        timelines: List<_Timeline>.from(
          (map['timelines'] as List)
              .map((x) => _Timeline.fromMap(x as Map, unitSettings)),
        ),
      );

  Map toMap() => {
        'timelines': List.from(timelines.map((x) => x.toMap())),
      };

  factory WeatherResponseModel.updatedUnitSettings({
    required WeatherResponseModel model,
    required UnitSettings updatedSettings,
    required UnitSettings oldSettings,
  }) {
    final updatedTimeLineList = List<_Timeline>.from(
      model.timelines.map(
        (timeline) => _Timeline.updatedUnitSettings(
          timeline: timeline,
          unitSettings: updatedSettings,
          oldSettings: oldSettings,
        ),
      ),
      growable: false,
    );

    return WeatherResponseModel(
      id: 1,
      timelines: updatedTimeLineList,
    );
  }

  List<String> get dbTimelines {
    return List<String>.from(
      timelines.map(
        (timeline) => timeline.toRawJson(),
      ),
    );
  }

  set dbTimelines(List<String> list) {
    timelines = List<_Timeline>.from(
      list.map(
        (timeline) => _Timeline.fromStorage(rawJson: timeline),
      ),
    );
  }
}

class _Timeline extends Equatable {
  const _Timeline({
    required this.timestep,
    required this.startTimeString,
    required this.endTimeString,
    required this.intervals,
  });

  final String timestep;
  final String startTimeString;
  final String endTimeString;
  final List<_TimestepInterval> intervals;

  String toRawJson() => json.encode(toMap());

  factory _Timeline.fromMap(Map map, UnitSettings unitSettings) => _Timeline(
        timestep: map['timestep'] as String,
        startTimeString: map['startTime'] as String,
        endTimeString: map['endTime'] as String,
        intervals: List<_TimestepInterval>.from(
          (map['intervals'] as List).map(
            (x) => _TimestepInterval.fromMap(
              map: x as Map,
              timestep: map['timestep'] as String,
              unitSettings: unitSettings,
            ),
          ),
        ),
      );

  factory _Timeline.updatedUnitSettings({
    required _Timeline timeline,
    required UnitSettings unitSettings,
    required UnitSettings oldSettings,
  }) {
    final updatedIntervalList = List<_TimestepInterval>.from(timeline.intervals)
        .map(
          (interval) => _TimestepInterval.updatedUnitSettings(
            interval: interval,
            unitSettings: unitSettings,
            oldSettings: oldSettings,
            data: interval.data,
          ),
        )
        .toList();

    return _Timeline(
      startTimeString: timeline.startTimeString,
      endTimeString: timeline.endTimeString,
      intervals: updatedIntervalList,
      timestep: timeline.timestep,
    );
  }

  Map toMap() {
    return {
      'timestep': timestep,
      'startTime': startTimeString,
      'endTime': endTimeString,
      'intervals': List.from(
        intervals.map(
          (interval) => interval.toMap(),
        ),
      ),
    };
  }

  factory _Timeline.fromStorage({required String rawJson}) {
    final map = json.decode(rawJson) as Map;

    return _Timeline(
      timestep: map['timestep'] as String,
      startTimeString: map['startTime'] as String,
      endTimeString: map['endTime'] as String,
      intervals: List<_TimestepInterval>.from(
        (map['intervals'] as List).map(
          (x) => _TimestepInterval.fromStorage(
            map: x as Map,
            timestep: map['timestep'] as String,
          ),
        ),
      ),
    );
  }

  @override
  List<Object?> get props =>
      [timestep, startTimeString, endTimeString, intervals];
}

class _TimestepInterval extends Equatable {
  const _TimestepInterval({
    required this.startTimeString,
    required this.timestep,
    required this.data,
  });

  final String startTimeString;
  final String timestep;
  final WeatherData data;

  String toRawJson() => json.encode(toMap());

  factory _TimestepInterval.fromMap({
    required Map map,
    required String timestep,
    required UnitSettings unitSettings,
  }) {
    return _TimestepInterval(
      startTimeString: map['startTime'] as String,
      timestep: timestep,
      data: WeatherData.fromMap(
        map: map['values'] as Map,
        startTime: map['startTime'] as String,
        timestep: timestep,
        unitSettings: unitSettings,
      ),
    );
  }

  factory _TimestepInterval.updatedUnitSettings({
    required _TimestepInterval interval,
    required UnitSettings unitSettings,
    required UnitSettings oldSettings,
    required WeatherData data,
  }) {
    return _TimestepInterval(
      startTimeString: interval.startTimeString,
      timestep: interval.timestep,
      data: WeatherData.updatedUnitSettings(
        data: data,
        unitSettings: unitSettings,
        oldSettings: oldSettings,
      ),
    );
  }

  factory _TimestepInterval.fromStorage({
    required Map map,
    required String timestep,
  }) {
    return _TimestepInterval(
      startTimeString: map['startTime'] as String,
      timestep: timestep,
      data: WeatherData.fromStorage(
        map: map['values'] as Map,
        timestep: timestep,
      ),
    );
  }

  Map toMap() => {
        'startTime': startTimeString,
        'values': data.toMap(),
      };

  @override
  List<Object?> get props => [startTimeString, data];
}

class WeatherData extends Equatable {
  const WeatherData({
    required this.startTime,
    required this.temperature,
    required this.feelsLikeTemp,
    required this.humidity,
    required this.cloudBase,
    required this.cloudCeiling,
    required this.cloudCover,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitationProbability,
    required this.precipitationType,
    required this.precipitationIntensity,
    required this.visibility,
    required this.weatherCode,
    required this.sunsetTime,
    required this.sunriseTime,
    required this.timestep,
    required this.unitSettings,
  });
  final DateTime startTime;
  final int temperature;
  final int feelsLikeTemp;
  final double humidity;
  final double? cloudBase;
  final double? cloudCeiling;
  final double? cloudCover;
  final int windSpeed;
  final double windDirection;
  final num precipitationProbability;
  final int precipitationType;
  final num precipitationIntensity;
  final double visibility;
  final int weatherCode;
  final DateTime? sunsetTime;
  final DateTime? sunriseTime;
  final String timestep;
  final UnitSettings unitSettings;

  String toRawJson() => json.encode(toMap());

  factory WeatherData.updatedUnitSettings({
    required WeatherData data,
    required UnitSettings unitSettings,
    required UnitSettings oldSettings,
  }) {
    final tempSettingChanged =
        oldSettings.tempUnitsMetric != unitSettings.tempUnitsMetric;
    final precipSettingChanged =
        oldSettings.precipInMm != unitSettings.precipInMm;
    final speedSettingChanged =
        oldSettings.speedInKph != unitSettings.speedInKph;

    return WeatherData(
      startTime: data.startTime,
      temperature: tempSettingChanged
          ? UnitConverter.convertTemp(
              temp: data.temperature,
              tempUnitsMetric: unitSettings.tempUnitsMetric,
            )
          : data.temperature,
      feelsLikeTemp: tempSettingChanged
          ? UnitConverter.convertTemp(
              temp: data.feelsLikeTemp,
              tempUnitsMetric: unitSettings.tempUnitsMetric,
            )
          : data.feelsLikeTemp,
      humidity: data.humidity,
      cloudBase: data.cloudBase,
      cloudCeiling: data.cloudCeiling,
      cloudCover: data.cloudCover,
      windSpeed: speedSettingChanged
          ? UnitConverter.convertSpeed(
              speed: data.windSpeed,
              speedInKph: unitSettings.speedInKph,
            )
          : data.windSpeed,
      windDirection: data.windDirection,
      precipitationProbability: data.precipitationProbability,
      precipitationType: data.precipitationType,
      precipitationIntensity: precipSettingChanged
          ? UnitConverter.convertPrecipUnits(
              precip: data.precipitationIntensity,
              precipInMm: unitSettings.precipInMm,
            )
          : data.precipitationIntensity,
      visibility: data.visibility,
      weatherCode: data.weatherCode,
      sunsetTime: data.sunsetTime,
      sunriseTime: data.sunriseTime,
      timestep: data.timestep,
      unitSettings: unitSettings,
    );
  }

  factory WeatherData.fromMap({
    required Map map,
    required String startTime,
    required String timestep,
    required UnitSettings unitSettings,
  }) {
    String? sunrise =
        map['sunriseTime'] != null ? map['sunriseTime'] as String : null;
    String? sunset =
        map['sunsetTime'] != null ? map['sunsetTime'] as String : null;

    if (timestep == '1h') {
      sunrise = null;
      sunset = null;
    }

    final temp = map['temperature'] as num;

    final windSpeed = map['windSpeed'] as num;

    final feelsLikeTemp = map['temperatureApparent'] as num;

    final precipitationIntensity = map['precipitationIntensity'] as num;

    return WeatherData(
      startTime: TimeZoneController.to
          .parseTimeBasedOnLocalOrRemoteSearch(time: startTime),
      temperature: unitSettings.tempUnitsMetric
          ? UnitConverter.toCelcius(temp: temp)
          : temp.round(),
      feelsLikeTemp: unitSettings.tempUnitsMetric
          ? UnitConverter.toCelcius(temp: feelsLikeTemp)
          : feelsLikeTemp.round(),
      humidity: (map['humidity'] as num).toDouble(),
      cloudBase: (map['cloudBase'] as num?) == null
          ? null
          : (map['cloudBase'] as num).toDouble(),
      cloudCeiling: (map['cloudCeiling'] as num?) == null
          ? null
          : (map['cloudCeiling'] as num).toDouble(),
      cloudCover: (map['cloudCover'] as num?) == null
          ? null
          : (map['cloudCover'] as num).toDouble(),
      windSpeed: unitSettings.speedInKph
          ? UnitConverter.convertMphToKph(mph: windSpeed)
          : windSpeed.round(),
      windDirection: (map['windDirection'] as num).toDouble(),
      precipitationProbability: map['precipitationProbability'] as num,
      precipitationType: map['precipitationType'] as int,
      precipitationIntensity: unitSettings.precipInMm
          ? UnitConverter.convertInchesToMillimeters(
              inches: precipitationIntensity,
            )
          : precipitationIntensity,
      visibility: (map['visibility'] as num).toDouble(),
      weatherCode: map['weatherCode'] as int,
      sunsetTime: sunset == null
          ? null
          : TimeZoneController.to
              .parseTimeBasedOnLocalOrRemoteSearch(time: sunset),
      sunriseTime: sunrise == null
          ? null
          : TimeZoneController.to
              .parseTimeBasedOnLocalOrRemoteSearch(time: sunrise),
      timestep: timestep,
      unitSettings: unitSettings,
    );
  }

  factory WeatherData.fromStorage({
    required Map map,
    required String timestep,
  }) {
    final sunrise =
        map['sunriseTime'] != null ? map['sunriseTime'] as String : null;
    final sunset =
        map['sunsetTime'] != null ? map['sunsetTime'] as String : null;

    return WeatherData(
      startTime: TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
        time: map['startTime'] as String,
      ),
      temperature: map['temperature'] as int,
      feelsLikeTemp: map['temperatureApparent'] as int,
      humidity: (map['humidity'] as num).toDouble(),
      cloudBase: (map['cloudBase'] as num?) == null
          ? null
          : (map['cloudBase'] as num).toDouble(),
      cloudCeiling: (map['cloudCeiling'] as num?) == null
          ? null
          : (map['cloudCeiling'] as num).toDouble(),
      cloudCover: (map['cloudCover'] as num?) == null
          ? null
          : (map['cloudCover'] as num).toDouble(),
      windSpeed: map['windSpeed'] as int,
      windDirection: (map['windDirection'] as num).toDouble(),
      precipitationProbability: map['precipitationProbability'] as num,
      precipitationType: map['precipitationType'] as int,
      precipitationIntensity: (map['precipitationIntensity'] as num).toDouble(),
      visibility: (map['visibility'] as num).toDouble(),
      weatherCode: map['weatherCode'] as int,
      sunsetTime: sunset == null ? null : DateTime.parse(sunset),
      sunriseTime: sunrise == null ? null : DateTime.parse(sunrise),
      timestep: timestep,
      unitSettings: UnitSettings.fromRawJson(map['unitSettings'] as String),
    );
  }

  Map toMap() {
    final sunset = sunsetTime == null ? null : sunsetTime!.toIso8601String();
    final sunrise = sunriseTime == null ? null : sunriseTime!.toIso8601String();
    return {
      'startTime': startTime.toString(),
      'temperature': temperature,
      'temperatureApparent': feelsLikeTemp,
      'humidity': humidity,
      'cloudBase': cloudBase,
      'cloudCeiling': cloudCeiling,
      'cloudCover': cloudCover,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'precipitationProbability': precipitationProbability,
      'precipitationType': precipitationType,
      'precipitationIntensity': precipitationIntensity,
      'visibility': visibility,
      'weatherCode': weatherCode,
      'sunsetTime': sunset,
      'sunriseTime': sunrise,
      'unitSettings': unitSettings.toRawJson(),
    };
  }

  @override
  List<Object?> get props => [
        temperature,
        feelsLikeTemp,
        humidity,
        cloudBase,
        cloudCeiling,
        cloudCover,
        windSpeed,
        windDirection,
        precipitationProbability,
        precipitationType,
        precipitationIntensity,
        visibility,
        weatherCode,
        sunsetTime,
        sunriseTime
      ];
}
