import 'dart:convert';

import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:equatable/equatable.dart';

class WeatherResponseModel extends Equatable {
  const WeatherResponseModel({
    required this.timelines,
  });

  final List<_Timeline> timelines;

  String toRawJson() => json.encode(toMap());

  factory WeatherResponseModel.fromMap(Map<String, dynamic> map) =>
      WeatherResponseModel(
        timelines: List<_Timeline>.from(
          (map['timelines'] as List)
              .map((x) => _Timeline.fromMap(x as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toMap() => {
        'timelines': List.from(timelines.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [timelines];
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

  factory _Timeline.fromMap(Map<String, dynamic> map) => _Timeline(
        timestep: map['timestep'] as String,
        startTimeString: map['startTime'] as String,
        endTimeString: map['endTime'] as String,
        intervals: List<_TimestepInterval>.from(
          (map['intervals'] as List).map(
            (x) => _TimestepInterval.fromMap(
              map: x as Map<String, dynamic>,
              timestep: map['timestep'] as String,
            ),
          ),
        ),
      );

  Map<String, dynamic> toMap() => {
        'timestep': timestep,
        'startTime': startTimeString,
        'endTime': endTimeString,
        'intervals': List.from(intervals.map((x) => x.toMap())),
      };

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
    required Map<String, dynamic> map,
    required String timestep,
  }) {
    return _TimestepInterval(
      startTimeString: map['startTime'] as String,
      timestep: timestep,
      data: WeatherData.fromMap(
        map: map['values'] as Map<String, dynamic>,
        startTime: map['startTime'] as String,
        timestep: timestep,
      ),
    );
  }

  Map<String, dynamic> toMap() => {
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
  });
  final DateTime startTime;
  final int temperature;
  final int feelsLikeTemp;
  final double humidity;
  final double? cloudBase;
  final double? cloudCeiling;
  final double? cloudCover;
  final double windSpeed;
  final double windDirection;
  final num precipitationProbability;
  final int precipitationType;
  final num precipitationIntensity;
  final double visibility;
  final int weatherCode;
  final DateTime? sunsetTime;
  final DateTime? sunriseTime;
  final String timestep;

  String toRawJson() => json.encode(toMap());

  factory WeatherData.fromMap({
    required Map<String, dynamic> map,
    required String startTime,
    required String timestep,
  }) {
    String? sunrise =
        map['sunriseTime'] != null ? map['sunriseTime'] as String : null;
    String? sunset =
        map['sunsetTime'] != null ? map['sunsetTime'] as String : null;
    if (timestep == '1h') {
      sunrise = null;
      sunset = null;
    }
    return WeatherData(
      startTime: TimeZoneController.to
          .parseTimeBasedOnLocalOrRemoteSearch(time: startTime),
      temperature: (map['temperature'] as num).round(),
      feelsLikeTemp: (map['temperatureApparent'] as num).round(),
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
      windSpeed: (map['windSpeed'] as num).toDouble(),
      windDirection: (map['windDirection'] as num).toDouble(),
      precipitationProbability: map['precipitationProbability'] as num,
      precipitationType: map['precipitationType'] as int,
      precipitationIntensity: map['precipitationIntensity'] as num,
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
    );
  }

  Map<String, dynamic> toMap() => {
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
        'sunsetTime': sunsetTime!.toIso8601String(),
        'sunriseTime': sunriseTime!.toIso8601String(),
      };

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
