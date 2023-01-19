import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_data_model.freezed.dart';
part 'hourly_data_model.g.dart';

@freezed
class HourlyData with _$HourlyData {
  factory HourlyData({
    required int datetimeEpoch,
    required num temp,
    required num feelslike,
    required String conditions,
    num? windspeed,
    double? humidity,
    double? dew,
    num? precip,
    num? precipprob,
    num? snow,
    double? snowdepth,
    List? preciptype,
    double? windgust,
    double? winddir,
    double? pressure,
    double? visibility,
    double? cloudcover,
    double? solarradiation,
    double? solarenergy,
    num? uvindex,
    num? severerisk,
    String? icon,
    String? source,
  }) = _HourlyData;

  factory HourlyData.fromJson(Map<String, dynamic> json) =>
      _$HourlyDataFromJson(json);
}

// class HourlyData {
//   HourlyData({
//     required this.startTimeEpochInSeconds,
//     required this.temperature,
//     required this.iconPath,
//     required this.condition,
//     required this.feelsLike,
//     required this.windSpeed,
//     this.humidity,
//     this.dew,
//     this.precipitationIntensity,
//     this.precipitationProbability,
//     this.snow,
//     this.snowDepth,
//     this.precipitationType,
//     this.windgust,
//     this.winddir,
//     this.pressure,
//     this.visibility,
//     this.cloudcover,
//     this.solarradiation,
//     this.solarenergy,
//     this.uvindex,
//     this.severerisk,
//     this.source,
//   });

//   final int startTimeEpochInSeconds;
//   final int temperature;
//   final int feelsLike;
//   final double? humidity;
//   final double? dew;
//   final int? precipitationIntensity;
//   final int? precipitationProbability;
//   final int? snow;
//   final double? snowDepth;
//   final List? precipitationType;
//   final double? windgust;
//   final int windSpeed;
//   final double? winddir;
//   final double? pressure;
//   final double? visibility;
//   final double? cloudcover;
//   final double? solarradiation;
//   final double? solarenergy;
//   final int? uvindex;
//   final int? severerisk;
//   final String condition;
//   final String iconPath;
//   final String? source;

//   Map<String, dynamic> toMap() {
//     return {
//       'datetimeEpoch': startTimeEpochInSeconds,
//       'temp': temperature,
//       'feelslike': feelsLike,
//       'humidity': humidity,
//       'dew': dew,
//       'precip': precipitationIntensity,
//       'precipprob': precipitationProbability,
//       'snow': snow,
//       'snowdepth': snowDepth,
//       'preciptype': precipitationType,
//       'windgust': windgust,
//       'windspeed': windSpeed,
//       'winddir': winddir,
//       'pressure': pressure,
//       'visibility': visibility,
//       'cloudcover': cloudcover,
//       'solarradiation': solarradiation,
//       'solarenergy': solarenergy,
//       'uvindex': uvindex,
//       'severerisk': severerisk,
//       'conditions': condition,
//       'icon': iconPath,
//       'source': source,
//     };
//   }

//   factory HourlyData.fromMap({
//     required Map<String, dynamic> map,
//   }) {
//     String condition = map['conditions'] as String;

//     /// condition string from API can have more than one word
//     if (condition.contains(',')) {
//       final commaIndex = condition.indexOf(',');
//       condition = condition.substring(0, commaIndex);
//     }

//     return HourlyData(
//       startTimeEpochInSeconds: map['datetimeEpoch'] as int,
//       temperature: (map['temp'] as num).toInt(),
//       feelsLike: (map['feelslike'] as num).toInt(),
//       humidity: (map['humidity'] as num?)?.toDouble(),
//       dew: (map['dew'] as num?)?.toDouble(),
//       precipitationIntensity: (map['precip'] as num?)?.toInt(),
//       precipitationProbability: (map['precipprob'] as num?)?.toInt(),
//       snow: (map['snow'] as num?)?.toInt(),
//       snowDepth: (map['snowdepth'] as num?)?.toDouble(),
//       precipitationType: map['preciptype'] as List?,
//       windgust: (map['windgust'] as num?)?.toDouble(),
//       windSpeed: (map['windspeed'] as num).toInt(),
//       winddir: (map['winddir'] as num?)?.toDouble(),
//       pressure: (map['pressure'] as num?)?.toDouble(),
//       visibility: (map['visibility'] as num?)?.toDouble(),
//       cloudcover: (map['cloudcover'] as num?)?.toDouble(),
//       solarradiation: (map['solarradiation'] as num?)?.toDouble(),
//       solarenergy: (map['solarenergy'] as num?)?.toDouble(),
//       uvindex: (map['uvindex'] as num?)?.toInt(),
//       severerisk: (map['severerisk'] as num?)?.toInt(),
//       condition: condition,
//       iconPath: map['icon'] as String,
//       source: map['source'] as String?,
//     );
//   }

//   factory HourlyData.fromStorage({
//     required String jsonString,
//   }) {
//     final map = json.decode(jsonString) as Map<String, dynamic>;
//     return HourlyData(
//       startTimeEpochInSeconds: map['datetimeEpoch'] as int,
//       temperature: (map['temp'] as num).toInt(),
//       feelsLike: (map['feelslike'] as num).toInt(),
//       humidity: (map['humidity'] as num?)?.toDouble(),
//       dew: (map['dew'] as num?)?.toDouble(),
//       precipitationIntensity: (map['precip'] as num?)?.toInt(),
//       precipitationProbability: (map['precipprob'] as num?)?.toInt(),
//       snow: (map['snow'] as num?)?.toInt(),
//       snowDepth: (map['snowdepth'] as num?)?.toDouble(),
//       precipitationType: map['preciptype'] as List?,
//       windgust: (map['windgust'] as num?)?.toDouble(),
//       windSpeed: (map['windspeed'] as num).toInt(),
//       winddir: (map['winddir'] as num?)?.toDouble(),
//       pressure: (map['pressure'] as num?)?.toDouble(),
//       visibility: (map['visibility'] as num?)?.toDouble(),
//       cloudcover: (map['cloudcover'] as num?)?.toDouble(),
//       solarradiation: (map['solarradiation'] as num?)?.toDouble(),
//       solarenergy: (map['solarenergy'] as num?)?.toDouble(),
//       uvindex: (map['uvindex'] as num?)?.toInt(),
//       severerisk: (map['severerisk'] as num?)?.toInt(),
//       condition: map['conditions'] as String,
//       iconPath: map['icon'] as String,
//       source: map['source'] as String?,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory HourlyData.fromJson(
//     String source,
//   ) {
//     return HourlyData.fromMap(
//       map: json.decode(source) as Map<String, dynamic>,
//     );
//   }
// }
