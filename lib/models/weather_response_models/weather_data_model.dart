import 'dart:convert';

import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class WeatherResponseModel {
  WeatherResponseModel({
    this.id = 1,
    this.currentCondition,
    this.days = const [],
    this.queryCost,
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.tzoffset,
    this.description,
  });

  @Id(assignable: true)
  final int id;
  CurrentConditionData? currentCondition;
  List<DailyData> days;
  final num? queryCost;
  final double? latitude;
  final double? longitude;
  final String? resolvedAddress;
  final String? address;
  final String? timezone;
  final int? tzoffset;
  final String? description;

  String get dbCurrentCondition {
    return currentCondition!.toJson();
  }

  set dbCurrentCondition(String json) {
    currentCondition = CurrentConditionData.fromJson(json);
  }

  List<String> get dbDays {
    return List<String>.from(
      days.map(
        (timeline) => timeline.toJson(),
      ),
    );
  }

  set dbDays(List<String> list) {
    days = List<DailyData>.from(
      list.map(
        (json) => DailyData.fromStorage(json),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'queryCost': queryCost,
      'latitude': latitude,
      'longitude': longitude,
      'resolvedAddress': resolvedAddress,
      'address': address,
      'timezone': timezone,
      'tzoffset': tzoffset,
      'description': description,
      'days': days.map((x) => x.toMap()).toList(),
      // 'alerts': alerts?.map((x) => x.toMap()).toList(),
      'currentConditions': currentCondition!.toMap(),
    };
  }

  factory WeatherResponseModel.fromResponse({
    required Map<String, dynamic> response,
  }) {
    return WeatherResponseModel(
      queryCost: response['queryCost'] as num?,
      latitude: (response['latitude'] as num?)?.toDouble(),
      longitude: (response['longitude'] as num?)?.toDouble(),
      resolvedAddress: response['resolvedAddress'] as String?,
      address: response['address'] as String,
      timezone: response['timezone'] as String,
      tzoffset: (response['tzoffset'] as num?)?.toInt(),
      description: response['description'] as String,
      days: (response['days'] as List)
          .map(
            (dayMap) => DailyData.fromMap(
              map: dayMap as Map<String, dynamic>,
            ),
          )
          .toList(),
      currentCondition: CurrentConditionData.fromMap(
        response['currentConditions'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());
}

class CurrentConditionData {
  CurrentConditionData({
    required this.startTime,
    required this.condition,
    required this.temperature,
    required this.feelsLikeTemp,
    required this.windSpeed,
    this.datetimeEpoch,
    this.humidity,
    this.dew,
    this.precip,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.preciptype,
    this.windgust,
    this.windDirection,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.icon,
    this.source,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
  });

  final DateTime startTime;
  final int? datetimeEpoch;
  final int temperature;
  final int feelsLikeTemp;
  final double? humidity;
  final double? dew;
  final int? precip;
  final int? precipprob;
  final int? snow;
  final int? snowdepth;
  final List? preciptype;
  final int? windgust;
  final int windSpeed;
  final int? windDirection;
  final int? pressure;
  final int? visibility;
  final int? cloudcover;
  final int? solarradiation;
  final double? solarenergy;
  final int? uvindex;
  final String condition;
  final String? icon;
  final String? source;
  final String? sunrise;
  final int? sunriseEpoch;
  final String? sunset;
  final int? sunsetEpoch;
  final double? moonphase;

  Map<String, dynamic> toMap() {
    return {
      'datetime': startTime.toString(),
      'datetimeEpoch': datetimeEpoch,
      'temp': temperature,
      'feelslike': feelsLikeTemp,
      'humidity': humidity,
      'dew': dew,
      'precip': precip,
      'precipprob': precipprob,
      'snow': snow,
      'snowdepth': snowdepth,
      'preciptype': preciptype,
      'windgust': windgust,
      'windspeed': windSpeed,
      'winddir': windDirection,
      'pressure': pressure,
      'visibility': visibility,
      'cloudcover': cloudcover,
      'solarradiation': solarradiation,
      'solarenergy': solarenergy,
      'uvindex': uvindex,
      'conditions': condition,
      'icon': icon,
      'source': source,
      'sunrise': sunrise,
      'sunriseEpoch': sunriseEpoch,
      'sunset': sunset,
      'sunsetEpoch': sunsetEpoch,
      'moonphase': moonphase,
    };
  }

  factory CurrentConditionData.fromMap(
    Map<String, dynamic> map,
  ) {
    final epoch = map['datetimeEpoch'] as int;
    return CurrentConditionData(
      startTime: TimeZoneUtil.secondsFromEpoch(
        secondsSinceEpoch: epoch,
        searchIsLocal: true,
      ),
      datetimeEpoch: (map['datetimeEpoch'] as num?)?.toInt(),
      temperature: (map['temp'] as num).toInt(),
      feelsLikeTemp: (map['feelslike'] as num).toInt(),
      humidity: (map['humidity'] as num?)?.toDouble(),
      dew: (map['dew'] as num?)?.toDouble(),
      precip: (map['precip'] as num?)?.toInt(),
      precipprob: (map['precipprob'] as num?)?.toInt(),
      snow: (map['snow'] as num?)?.toInt(),
      snowdepth: (map['snowdepth'] as num?)?.toInt(),
      preciptype: map['preciptype'] as List<String>?,
      windgust: (map['windgust'] as num?)?.toInt(),
      windSpeed: (map['windspeed'] as num).toInt(),
      windDirection: (map['winddir'] as num?)?.toInt(),
      pressure: (map['pressure'] as num?)?.toInt(),
      visibility: (map['visibility'] as num?)?.toInt(),
      cloudcover: (map['cloudcover'] as num?)?.toInt(),
      solarradiation: (map['solarradiation'] as num?)?.toInt(),
      solarenergy: (map['solarenergy'] as num?)?.toDouble(),
      uvindex: (map['uvindex'] as num?)?.toInt(),
      condition: map['conditions'] as String,
      icon: map['icon'] as String,
      source: map['source'] as String,
      sunrise: map['sunrise'] as String,
      sunriseEpoch: (map['sunriseEpoch'] as num?)?.toInt(),
      sunset: map['sunset'] as String,
      sunsetEpoch: (map['sunsetEpoch'] as num?)?.toInt(),
      moonphase: (map['moonphase'] as num?)?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentConditionData.fromJson(
    String source,
  ) {
    final map = json.decode(source) as Map<String, dynamic>;
    return CurrentConditionData.fromMap(map);
  }
}

class DailyData {
  DailyData({
    required this.startTime,
    required this.datetimeEpoch,
    required this.temp,
    required this.feelslike,
    required this.condition,
    required this.windSpeed,
    this.tempMax,
    this.tempMin,
    this.feelslikemax,
    this.feelslikemin,
    this.dew,
    this.humidity,
    this.precipAmount,
    this.precipitationProbability,
    this.precipcover,
    this.precipitationType,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.winddir,
    this.pressure,
    this.cloudCover,
    this.visibility,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.sunriseTime,
    this.sunriseEpoch,
    this.sunsetTime,
    this.sunsetEpoch,
    this.moonphase,
    this.description,
    this.icon,
    this.source,
    this.hours,
  });

  final DateTime startTime;
  final int datetimeEpoch;
  final int? tempMax;
  final int? tempMin;
  final int temp;
  final double? feelslikemax;
  final double? feelslikemin;
  final int feelslike;
  final double? dew;
  final double? humidity;
  final double? precipAmount;
  final double? precipitationProbability;
  final double? precipcover;
  final List? precipitationType;
  final int? snow;
  final int? snowdepth;
  final double? windgust;
  final int windSpeed;
  final double? winddir;
  final double? pressure;
  final double? cloudCover;
  final double? visibility;
  final double? solarradiation;
  final double? solarenergy;
  final int? uvindex;
  final int? severerisk;
  final DateTime? sunriseTime;
  final int? sunriseEpoch;
  final DateTime? sunsetTime;
  final int? sunsetEpoch;
  final double? moonphase;
  final String condition;
  final String? description;
  final String? icon;
  final String? source;
  final List<HourlyData>? hours;

  Map<String, dynamic> toMap() {
    return {
      'datetime': startTime.toString(),
      'datetimeEpoch': datetimeEpoch,
      'tempmax': tempMax,
      'tempmin': tempMin,
      'temp': temp,
      'feelslikemax': feelslikemax,
      'feelslikemin': feelslikemin,
      'feelslike': feelslike,
      'dew': dew,
      'humidity': humidity,
      'precip': precipAmount,
      'precipprob': precipitationProbability,
      'precipcover': precipcover,
      'preciptype': precipitationType,
      'snow': snow,
      'snowdepth': snowdepth,
      'windgust': windgust,
      'windspeed': windSpeed,
      'winddir': winddir,
      'pressure': pressure,
      'cloudcover': cloudCover,
      'visibility': visibility,
      'solarradiation': solarradiation,
      'solarenergy': solarenergy,
      'uvindex': uvindex,
      'severerisk': severerisk,
      'sunrise': sunriseTime.toString(),
      'sunriseEpoch': sunriseEpoch,
      'sunset': sunsetTime.toString(),
      'sunsetEpoch': sunsetEpoch,
      'moonphase': moonphase,
      'conditions': condition,
      'description': description,
      'icon': icon,
      'source': source,
      'hours': hours?.map((x) => x.toMap()).toList(),
    };
  }

  factory DailyData.fromMap({
    required Map<String, dynamic> map,
  }) {
    String condition = map['conditions'] as String;

    final epoch = map['datetimeEpoch'] as int;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }
    final sunriseEpoch = map['sunriseEpoch'] as int;
    final sunsetEpoch = map['sunsetEpoch'] as int;
    final sunrise = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: sunriseEpoch,
      searchIsLocal: true,
    );

    final sunset = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: sunsetEpoch,
      searchIsLocal: true,
    );

    return DailyData(
      startTime: TimeZoneUtil.secondsFromEpoch(
        secondsSinceEpoch: epoch,
        searchIsLocal: true,
      ),
      datetimeEpoch: (map['datetimeEpoch'] as num).toInt(),
      tempMax: (map['tempmax'] as num?)?.toInt(),
      tempMin: (map['tempmin'] as num?)?.toInt(),
      temp: (map['temp'] as num).toInt(),
      feelslikemax: (map['feelslikemax'] as num?)?.toDouble(),
      feelslikemin: (map['feelslikemin'] as num?)?.toDouble(),
      feelslike: (map['feelslike'] as num).toInt(),
      dew: (map['dew'] as num?)?.toDouble(),
      humidity: (map['humidity'] as num?)?.toDouble(),
      precipAmount: (map['precip'] as num?)?.toDouble(),
      precipitationProbability: (map['precipprob'] as num?)?.toDouble(),
      precipcover: (map['precipcover'] as num?)?.toDouble(),
      precipitationType: map['preciptype'] as List?,
      snow: (map['snow'] as num?)?.toInt(),
      snowdepth: (map['snowdepth'] as num?)?.toInt(),
      windgust: (map['windgust'] as num?)?.toDouble(),
      windSpeed: (map['windspeed'] as num).toInt(),
      winddir: (map['winddir'] as num?)?.toDouble(),
      pressure: (map['pressure'] as num?)?.toDouble(),
      cloudCover: (map['cloudcover'] as num?)?.toDouble(),
      visibility: (map['visibility'] as num?)?.toDouble(),
      solarradiation: (map['solarradiation'] as num?)?.toDouble(),
      solarenergy: (map['solarenergy'] as num?)?.toDouble(),
      uvindex: (map['uvindex'] as num?)?.toInt(),
      severerisk: (map['severerisk'] as num?)?.toInt(),
      sunriseTime: sunrise,
      sunsetTime: sunset,
      sunriseEpoch: (map['sunriseEpoch'] as num?)?.toInt(),
      sunsetEpoch: (map['sunsetEpoch'] as num?)?.toInt(),
      moonphase: (map['moonphase'] as num?)?.toDouble(),
      condition: condition,
      description: map['description'] as String,
      icon: map['icon'] as String,
      source: map['source'] as String,
      hours: (map['hours'] as List?)
          ?.map(
            (e) => HourlyData.fromMap(
              map: e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  factory DailyData.fromStorage(String jsonString) {
    final map = json.decode(jsonString) as Map<String, dynamic>;
    final startEpoch = map['datetimeEpoch'] as int;

    final sunriseEpoch = map['sunriseEpoch'] as int;
    final sunsetEpoch = map['sunsetEpoch'] as int;
    final sunrise = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: sunriseEpoch,
      searchIsLocal: true,
    );
    final sunset = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: sunsetEpoch,
      searchIsLocal: true,
    );

    final startTime = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: startEpoch,
      searchIsLocal: true,
    );
    return DailyData(
      startTime: startTime,
      datetimeEpoch: (map['datetimeEpoch'] as num).toInt(),
      tempMax: (map['tempmax'] as num?)?.toInt(),
      tempMin: (map['tempmin'] as num?)?.toInt(),
      temp: (map['temp'] as num).toInt(),
      feelslikemax: (map['feelslikemax'] as num?)?.toDouble(),
      feelslikemin: (map['feelslikemin'] as num?)?.toDouble(),
      feelslike: (map['feelslike'] as num).toInt(),
      dew: (map['dew'] as num?)?.toDouble(),
      humidity: (map['humidity'] as num?)?.toDouble(),
      precipAmount: (map['precip'] as num?)?.toDouble(),
      precipitationProbability: (map['precipprob'] as num?)?.toDouble(),
      precipcover: (map['precipcover'] as num?)?.toDouble(),
      precipitationType: map['preciptype'] as List?,
      snow: (map['snow'] as num?)?.toInt(),
      snowdepth: (map['snowdepth'] as num?)?.toInt(),
      windgust: (map['windgust'] as num?)?.toDouble(),
      windSpeed: (map['windspeed'] as num).toInt(),
      winddir: (map['winddir'] as num?)?.toDouble(),
      pressure: (map['pressure'] as num?)?.toDouble(),
      cloudCover: (map['cloudcover'] as num?)?.toDouble(),
      visibility: (map['visibility'] as num?)?.toDouble(),
      solarradiation: (map['solarradiation'] as num?)?.toDouble(),
      solarenergy: (map['solarenergy'] as num?)?.toDouble(),
      uvindex: (map['uvindex'] as num?)?.toInt(),
      severerisk: (map['severerisk'] as num?)?.toInt(),
      sunriseTime: sunrise,
      sunsetTime: sunset,
      sunriseEpoch: (map['sunriseEpoch'] as num?)?.toInt(),
      sunsetEpoch: (map['sunsetEpoch'] as num?)?.toInt(),
      moonphase: (map['moonphase'] as num?)?.toDouble(),
      condition: map['conditions'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      source: map['source'] as String,
      hours: (map['hours'] as List?)
          ?.map(
            (e) => HourlyData.fromStorage(
              jsonString: jsonString,
            ),
          )
          .toList(),
    );
  }
  String toJson() => json.encode(toMap());
}

class HourlyData {
  HourlyData({
    required this.startTime,
    required this.temperature,
    required this.iconPath,
    required this.condition,
    required this.feelsLike,
    required this.windSpeed,
    this.humidity,
    this.dew,
    this.precipitationIntensity,
    this.precipitationProbability,
    this.snow,
    this.snowDepth,
    this.precipitationType,
    this.windgust,
    this.winddir,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.source,
  });

  final DateTime startTime;
  final int temperature;
  final int feelsLike;
  final double? humidity;
  final double? dew;
  final int? precipitationIntensity;
  final int? precipitationProbability;
  final int? snow;
  final double? snowDepth;
  final List? precipitationType;
  final double? windgust;
  final int windSpeed;
  final double? winddir;
  final double? pressure;
  final double? visibility;
  final double? cloudcover;
  final double? solarradiation;
  final double? solarenergy;
  final int? uvindex;
  final int? severerisk;
  final String condition;
  final String iconPath;
  final String? source;

  Map<String, dynamic> toMap() {
    return {
      'datetime': startTime.toString(),
      'temp': temperature,
      'feelslike': feelsLike,
      'humidity': humidity,
      'dew': dew,
      'precip': precipitationIntensity,
      'precipprob': precipitationProbability,
      'snow': snow,
      'snowdepth': snowDepth,
      'preciptype': precipitationType,
      'windgust': windgust,
      'windspeed': windSpeed,
      'winddir': winddir,
      'pressure': pressure,
      'visibility': visibility,
      'cloudcover': cloudcover,
      'solarradiation': solarradiation,
      'solarenergy': solarenergy,
      'uvindex': uvindex,
      'severerisk': severerisk,
      'conditions': condition,
      'icon': iconPath,
      'source': source,
    };
  }

  factory HourlyData.fromMap({
    required Map<String, dynamic> map,
  }) {
    String condition = map['conditions'] as String;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }

    final epoch = map['datetimeEpoch'] as int;

    return HourlyData(
      startTime: TimeZoneUtil.secondsFromEpoch(
        secondsSinceEpoch: epoch,
        searchIsLocal: true,
      ),
      temperature: (map['temp'] as num).toInt(),
      feelsLike: (map['feelslike'] as num).toInt(),
      humidity: (map['humidity'] as num?)?.toDouble(),
      dew: (map['dew'] as num?)?.toDouble(),
      precipitationIntensity: (map['precip'] as num?)?.toInt(),
      precipitationProbability: (map['precipprob'] as num?)?.toInt(),
      snow: (map['snow'] as num?)?.toInt(),
      snowDepth: (map['snowdepth'] as num?)?.toDouble(),
      precipitationType: map['preciptype'] as List?,
      windgust: (map['windgust'] as num?)?.toDouble(),
      windSpeed: (map['windspeed'] as num).toInt(),
      winddir: (map['winddir'] as num?)?.toDouble(),
      pressure: (map['pressure'] as num?)?.toDouble(),
      visibility: (map['visibility'] as num?)?.toDouble(),
      cloudcover: (map['cloudcover'] as num?)?.toDouble(),
      solarradiation: (map['solarradiation'] as num?)?.toDouble(),
      solarenergy: (map['solarenergy'] as num?)?.toDouble(),
      uvindex: (map['uvindex'] as num?)?.toInt(),
      severerisk: (map['severerisk'] as num?)?.toInt(),
      condition: condition,
      iconPath: map['icon'] as String,
      source: map['source'] as String?,
    );
  }

  factory HourlyData.fromStorage({
    required String jsonString,
  }) {
    final map = json.decode(jsonString) as Map<String, dynamic>;
    final timeString = map['datetime'] as String;
    return HourlyData(
      startTime: DateTime.parse(timeString),
      temperature: (map['temp'] as num).toInt(),
      feelsLike: (map['feelslike'] as num).toInt(),
      humidity: (map['humidity'] as num?)?.toDouble(),
      dew: (map['dew'] as num?)?.toDouble(),
      precipitationIntensity: (map['precip'] as num?)?.toInt(),
      precipitationProbability: (map['precipprob'] as num?)?.toInt(),
      snow: (map['snow'] as num?)?.toInt(),
      snowDepth: (map['snowdepth'] as num?)?.toDouble(),
      precipitationType: map['preciptype'] as List?,
      windgust: (map['windgust'] as num?)?.toDouble(),
      windSpeed: (map['windspeed'] as num).toInt(),
      winddir: (map['winddir'] as num?)?.toDouble(),
      pressure: (map['pressure'] as num?)?.toDouble(),
      visibility: (map['visibility'] as num?)?.toDouble(),
      cloudcover: (map['cloudcover'] as num?)?.toDouble(),
      solarradiation: (map['solarradiation'] as num?)?.toDouble(),
      solarenergy: (map['solarenergy'] as num?)?.toDouble(),
      uvindex: (map['uvindex'] as num?)?.toInt(),
      severerisk: (map['severerisk'] as num?)?.toInt(),
      condition: map['conditions'] as String,
      iconPath: map['icon'] as String,
      source: map['source'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyData.fromJson(
    String source,
  ) {
    return HourlyData.fromMap(
      map: json.decode(source) as Map<String, dynamic>,
    );
  }
}
