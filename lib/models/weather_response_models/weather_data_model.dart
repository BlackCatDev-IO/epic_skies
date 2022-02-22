import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import '../../services/settings/unit_settings/unit_settings_model.dart';
import '../../utils/conversions/unit_converter.dart';
import '../../utils/timezone/timezone_util.dart';

class WeatherDataInitModel {
  WeatherDataInitModel({
    required this.unitSettings,
    required this.searchIsLocal,
    this.oldSettings,
  });

  final UnitSettings unitSettings;
  final UnitSettings? oldSettings;
  final bool searchIsLocal;

  Map<String, dynamic> toMap() {
    return {
      'unitSettings': unitSettings.toRawJson(),
      'searchIsLocal': searchIsLocal,
    };
  }
}

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
    required WeatherDataInitModel model,
    required Map<String, dynamic> response,
  }) =>
      WeatherResponseModel(
        id: 1,
        timelines: List<_Timeline>.from(
          (response['timelines'] as List).map(
            (x) => _Timeline.fromResponse(
              model: model,
              data: x as Map<String, dynamic>,
            ),
          ),
        ),
      );

  Map<String, dynamic> toMap() => {
        'timelines': List.from(timelines.map((x) => x.toMap())),
      };

  factory WeatherResponseModel.updatedUnitSettings({
    required WeatherDataInitModel data,
    required WeatherResponseModel model,
  }) {
    final updatedTimeLineList = List<_Timeline>.from(
      model.timelines.map(
        (timeline) => _Timeline.updatedUnitSettings(
          timeline: timeline,
          data: data,
        ),
      ),
      growable: false,
    );

    return WeatherResponseModel(
      id: 1,
      timelines: updatedTimeLineList,
    );
  }
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
    required WeatherDataInitModel model,
  }) {
    return _Timeline(
      timestep: data['timestep'] as String,
      endTimeString: data['endTime'] as String,
      intervals: List<_TimestepInterval>.from(
        (data['intervals'] as List).map(
          (x) => _TimestepInterval.fromResponse(
            model: model,
            timestep: data['timestep'] as String,
            data: x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }
  factory _Timeline.updatedUnitSettings({
    required _Timeline timeline,
    required WeatherDataInitModel data,
  }) {
    final updatedIntervalList = List<_TimestepInterval>.from(timeline.intervals)
        .map(
          (interval) => _TimestepInterval.updatedUnitSettings(
            interval: interval,
            data: interval.data,
            model: data,
          ),
        )
        .toList();

    return _Timeline(
      endTimeString: timeline.endTimeString,
      intervals: updatedIntervalList,
      timestep: timeline.timestep,
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
    required WeatherDataInitModel model,
    required String timestep,
  }) {
    return _TimestepInterval(
      timestep: timestep,
      data: WeatherData.fromResponse(
        model: model,
        startTime: data['startTime'] as String,
        timestep: timestep,
        data: data['values'] as Map<String, dynamic>,
      ),
    );
  }

  factory _TimestepInterval.updatedUnitSettings({
    required _TimestepInterval interval,
    required WeatherDataInitModel model,
    required WeatherData data,
  }) {
    return _TimestepInterval(
      timestep: interval.timestep,
      data: WeatherData.updatedUnitSettings(
        data: data,
        model: model,
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
    required WeatherDataInitModel model,
  }) {
    final newSettings = model.unitSettings;

    final tempSettingChanged =
        model.oldSettings!.tempUnitsMetric != newSettings.tempUnitsMetric;
    final precipSettingChanged =
        model.oldSettings!.precipInMm != newSettings.precipInMm;
    final speedSettingChanged =
        model.oldSettings!.speedInKph != newSettings.speedInKph;

    return WeatherData(
      startTime: data.startTime,
      temperature: tempSettingChanged
          ? UnitConverter.convertTemp(
              temp: data.temperature,
              tempUnitsMetric: newSettings.tempUnitsMetric,
            )
          : data.temperature,
      feelsLikeTemp: tempSettingChanged
          ? UnitConverter.convertTemp(
              temp: data.feelsLikeTemp,
              tempUnitsMetric: newSettings.tempUnitsMetric,
            )
          : data.feelsLikeTemp,
      humidity: data.humidity,
      cloudBase: data.cloudBase,
      cloudCeiling: data.cloudCeiling,
      cloudCover: data.cloudCover,
      windSpeed: speedSettingChanged
          ? UnitConverter.convertSpeed(
              speed: data.windSpeed,
              speedInKph: newSettings.speedInKph,
            )
          : data.windSpeed,
      windDirection: data.windDirection,
      precipitationProbability: data.precipitationProbability,
      precipitationType: data.precipitationType,
      precipitationIntensity: precipSettingChanged
          ? UnitConverter.convertPrecipUnits(
              precip: data.precipitationIntensity,
              precipInMm: newSettings.precipInMm,
            )
          : data.precipitationIntensity,
      visibility: data.visibility,
      weatherCode: data.weatherCode,
      sunsetTime: data.sunsetTime,
      sunriseTime: data.sunriseTime,
      timestep: data.timestep,
      unitSettings: newSettings,
    );
  }

  factory WeatherData.fromResponse({
    required Map<String, dynamic> data,
    required WeatherDataInitModel model,
    required String startTime,
    required String timestep,
  }) {
    final temp = data['temperature'] as num;

    final windSpeed = data['windSpeed'] as num;

    final feelsLikeTemp = data['temperatureApparent'] as num;

    final precipitationIntensity = data['precipitationIntensity'] as num;

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
        searchIsLocal: model.searchIsLocal,
        time: sunrise,
      );

      parsedSunset = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        searchIsLocal: model.searchIsLocal,
        time: sunset,
      );
    } else {
      parsedSunrise = null;
      parsedSunset = null;
    }

    final parsedStartTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
      time: startTime,
      searchIsLocal: model.searchIsLocal,
    );

    return WeatherData(
      startTime: parsedStartTime,
      temperature: model.unitSettings.tempUnitsMetric
          ? UnitConverter.toCelcius(temp: temp)
          : temp.round(),
      feelsLikeTemp: model.unitSettings.tempUnitsMetric
          ? UnitConverter.toCelcius(temp: feelsLikeTemp)
          : feelsLikeTemp.round(),
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
      windSpeed: model.unitSettings.speedInKph
          ? UnitConverter.convertMphToKph(mph: windSpeed)
          : windSpeed.round(),
      windDirection: (data['windDirection'] as num).toDouble(),
      precipitationProbability: data['precipitationProbability'] as num,
      precipitationType: data['precipitationType'] as int,
      precipitationIntensity: model.unitSettings.precipInMm
          ? UnitConverter.convertInchesToMillimeters(
              inches: precipitationIntensity,
            )
          : precipitationIntensity,
      visibility: (data['visibility'] as num).toDouble(),
      weatherCode: data['weatherCode'] as int,
      sunsetTime: parsedSunset,
      sunriseTime: parsedSunrise,
      timestep: timestep,
      unitSettings: model.unitSettings,
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
      unitSettings: UnitSettings.fromRawJson(map['unitSettings'] as String),
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
