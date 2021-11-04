import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeatherResponseModel extends Equatable {
  const WeatherResponseModel({
    required this.timelines,
  });

  final List<Timeline> timelines;

  String toRawJson() => json.encode(toMap());

  factory WeatherResponseModel.fromMap(Map<String, dynamic> map) =>
      WeatherResponseModel(
        timelines: List<Timeline>.from(
          (map['timelines'] as List)
              .map((x) => Timeline.fromMap(x as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toMap() => {
        'timelines': List.from(timelines.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [timelines];
}

class Timeline extends Equatable {
  const Timeline({
    required this.timestep,
    required this.startTime,
    required this.endTime,
    required this.intervals,
  });

  final String timestep;
  final DateTime startTime;
  final DateTime endTime;
  final List<TimestepInterval> intervals;

  String toRawJson() => json.encode(toMap());

  factory Timeline.fromMap(Map<String, dynamic> json) => Timeline(
        timestep: json['timestep'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        intervals: List<TimestepInterval>.from(
          (json['intervals'] as List)
              .map((x) => TimestepInterval.fromMap(x as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toMap() => {
        'timestep': timestep,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'intervals': List.from(intervals.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [timestep, startTime, endTime, intervals];
}

class TimestepInterval extends Equatable {
  const TimestepInterval({
    required this.startTime,
    required this.values,
  });

  final DateTime startTime;
  final Values values;

  String toRawJson() => json.encode(toMap());

  factory TimestepInterval.fromMap(Map<String, dynamic> map) =>
      TimestepInterval(
        startTime: DateTime.parse(map['startTime'] as String),
        values: Values.fromMap(map['values'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'startTime': startTime.toIso8601String(),
        'values': values.toMap(),
      };

  @override
  List<Object?> get props => [startTime, values];
}

class Values extends Equatable {
  const Values({
    required this.temperature,
    required this.temperatureApparent,
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
  });

  final double temperature;
  final double temperatureApparent;
  final double humidity;
  final double? cloudBase;
  final double? cloudCeiling;
  final double cloudCover;
  final double windSpeed;
  final double windDirection;
  final num precipitationProbability;
  final int precipitationType;
  final num precipitationIntensity;
  final double visibility;
  final int weatherCode;
  final DateTime? sunsetTime;
  final DateTime? sunriseTime;

  String toRawJson() => json.encode(toMap());

  factory Values.fromMap(Map<String, dynamic> json) => Values(
        temperature: (json['temperature'] as num).toDouble(),
        temperatureApparent: (json['temperatureApparent'] as num).toDouble(),
        humidity: (json['humidity'] as num).toDouble(),
        cloudBase: (json['cloudBase'] as num?) == null
            ? null
            : (json['cloudBase'] as num).toDouble(),
        cloudCeiling: (json['cloudCeiling'] as num?) == null
            ? null
            : (json['cloudCeiling'] as num).toDouble(),
        cloudCover: (json['cloudCover'] as num).toDouble(),
        windSpeed: (json['windSpeed'] as num).toDouble(),
        windDirection: (json['windDirection'] as num).toDouble(),
        precipitationProbability: json['precipitationProbability'] as num,
        precipitationType: json['precipitationType'] as int,
        precipitationIntensity: json['precipitationIntensity'] as num,
        visibility: (json['visibility'] as num).toDouble(),
        weatherCode: json['weatherCode'] as int,
        sunsetTime: json['sunsetTime'] == null
            ? null
            : DateTime.parse(json['sunsetTime'] as String),
        sunriseTime: json['sunriseTime'] == null
            ? null
            : DateTime.parse(json['sunriseTime'] as String),
      );

  Map<String, dynamic> toMap() => {
        'temperature': temperature,
        'temperatureApparent': temperatureApparent,
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
        temperatureApparent,
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
