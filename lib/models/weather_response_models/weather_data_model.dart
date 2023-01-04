import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import '../../utils/timezone/timezone_util.dart';

@Entity()
class WeatherResponseModel {
  WeatherResponseModel({
    required this.id,
    this.timelines = const [],
  });

  @Id(assignable: true)
  final int id;
  List<_Timeline> timelines = [];

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

  factory WeatherResponseModel.fromResponse({
    required bool searchIsLocal,
    required Map response,
  }) {
    final timelines = [];
    final responseList = response['timelines'] as List;

    Map<String, dynamic> current = {};
    Map<String, dynamic> hourly = {};
    Map<String, dynamic> daily = {};

    for (final map in responseList) {
      final timestep = (map as Map)['timestep'] as String;
      switch (timestep.toLowerCase()) {
        case 'current':
          current = map as Map<String, dynamic>;
          break;
        case '1h':
          hourly = map as Map<String, dynamic>;
          break;
        case '1d':
          daily = map as Map<String, dynamic>;
          break;
      }
    }

    timelines.add(current);
    timelines.add(hourly);
    timelines.add(daily);

    return WeatherResponseModel(
      id: 1,
      timelines: List<_Timeline>.from(
        timelines.map(
          (x) => _Timeline.fromResponse(
            searchIsLocal: searchIsLocal,
            data: x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }
  Map<String, dynamic> toMap() => {
        'timelines': List.from(timelines.map((x) => x.toMap())),
      };
}

class _Timeline extends Equatable {
  const _Timeline({
    required this.timestep,
    required this.endTimeString,
    required this.intervals,
  });

  final String timestep;
  final String endTimeString;
  final List<_TimestepInterval> intervals;

  String toRawJson() => json.encode(toMap());

  factory _Timeline.fromResponse({
    required Map<String, dynamic> data,
    required bool searchIsLocal,
  }) {
    return _Timeline(
      timestep: data['timestep'] as String,
      endTimeString: data['endTime'] as String,
      intervals: List<_TimestepInterval>.from(
        (data['intervals'] as List).map(
          (x) => _TimestepInterval.fromResponse(
            searchIsLocal: searchIsLocal,
            timestep: data['timestep'] as String,
            data: x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestep': timestep,
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
      endTimeString: map['endTime'] as String,
      intervals: List<_TimestepInterval>.from(
        (map['intervals'] as List).map(
          (x) => _TimestepInterval.fromStorage(
            map: x as Map<String, dynamic>,
            timestep: map['timestep'] as String,
          ),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [timestep, endTimeString, intervals];
}

class _TimestepInterval extends Equatable {
  const _TimestepInterval({
    required this.timestep,
    required this.data,
  });

  final String timestep;
  final WeatherData data;

  String toRawJson() => json.encode(toMap());

  factory _TimestepInterval.fromResponse({
    required Map<String, dynamic> data,
    required bool searchIsLocal,
    required String timestep,
  }) {
    return _TimestepInterval(
      timestep: timestep,
      data: WeatherData.fromResponse(
        searchIsLocal: searchIsLocal,
        startTime: data['startTime'] as String,
        timestep: timestep,
        data: data['values'] as Map<String, dynamic>,
      ),
    );
  }

  factory _TimestepInterval.fromStorage({
    required Map<String, dynamic> map,
    required String timestep,
  }) {
    return _TimestepInterval(
      timestep: timestep,
      data: WeatherData.fromStorage(
        map: map['values'] as Map<String, dynamic>,
        timestep: timestep,
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        'values': data.toMap(),
      };

  @override
  List<Object?> get props => [data];
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

  String toRawJson() => json.encode(toMap());

  factory WeatherData.fromResponse({
    required Map<String, dynamic> data,
    required bool searchIsLocal,
    required String startTime,
    required String timestep,
  }) {
    final temp = data['temperature'] as num;

    final windSpeed = data['windSpeed'] as num;

    final feelsLikeTemp = data['temperatureApparent'] as num;

    final num precipitationIntensity =
        (data['precipitationIntensity'] as num?) ?? 0;

    String? sunrise =
        data['sunriseTime'] != null ? data['sunriseTime'] as String : null;
    String? sunset =
        data['sunsetTime'] != null ? data['sunsetTime'] as String : null;

    if (timestep == '1h') {
      sunrise = null;
      sunset = null;
    }

    late DateTime? parsedSunset, parsedSunrise;

    if (sunrise != null && sunset != null) {
      parsedSunrise = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        searchIsLocal: searchIsLocal,
        time: sunrise,
      );

      parsedSunset = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        searchIsLocal: searchIsLocal,
        time: sunset,
      );
    } else {
      parsedSunrise = null;
      parsedSunset = null;
    }

    final parsedStartTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
      time: startTime,
      searchIsLocal: searchIsLocal,
    );

    return WeatherData(
      startTime: parsedStartTime,
      temperature: temp.round(),
      feelsLikeTemp: feelsLikeTemp.round(),
      humidity: (data['humidity'] as num).toDouble(),
      cloudBase: (data['cloudBase'] as num?) == null
          ? null
          : (data['cloudBase'] as num).toDouble(),
      cloudCeiling: (data['cloudCeiling'] as num?) == null
          ? null
          : (data['cloudCeiling'] as num).toDouble(),
      cloudCover: (data['cloudCover'] as num?) == null
          ? null
          : (data['cloudCover'] as num).toDouble(),
      windSpeed: windSpeed.round(),
      windDirection: (data['windDirection'] as num).toDouble(),
      precipitationProbability: data['precipitationProbability'] as num,
      precipitationType: data['precipitationType'] as int,
      precipitationIntensity: precipitationIntensity,
      visibility: (data['visibility'] as num).toDouble(),
      weatherCode: data['weatherCode'] as int,
      sunsetTime: parsedSunset,
      sunriseTime: parsedSunrise,
      timestep: timestep,
    );
  }

  factory WeatherData.fromStorage({
    required Map<String, dynamic> map,
    required String timestep,
  }) {
    final sunrise =
        map['sunriseTime'] != null ? map['sunriseTime'] as String : null;
    final sunset =
        map['sunsetTime'] != null ? map['sunsetTime'] as String : null;

    return WeatherData(
      startTime: TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: map['startTime'] as String,
        searchIsLocal: true,
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
    );
  }

  Map<String, dynamic> toMap() {
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
