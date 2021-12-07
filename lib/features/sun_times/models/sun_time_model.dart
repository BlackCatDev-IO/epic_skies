import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

import '../../../models/weather_response_models/weather_data_model.dart';

class SunTimesModel extends Equatable {
  final String sunsetString;
  final String sunriseString;
  final DateTime? sunriseTime;
  final DateTime? sunsetTime;

  const SunTimesModel({
    required this.sunsetString,
    required this.sunriseString,
    this.sunriseTime,
    this.sunsetTime,
  });

  factory SunTimesModel.fromWeatherData({required WeatherData data}) {
    return SunTimesModel(
      sunriseTime: data.sunriseTime,
      sunsetTime: data.sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(time: data.sunriseTime!),
      sunsetString: DateTimeFormatter.formatFullTime(time: data.sunsetTime!),
    );
  }

  factory SunTimesModel.fromMap(Map<String, dynamic> map) {
    final parsedSunrise = DateTime.parse(map['sunriseTime'] as String);
    final parsedSunset = DateTime.parse(map['sunsetTime'] as String);

    return SunTimesModel(
      sunriseString: DateTimeFormatter.formatFullTime(time: parsedSunrise),
      sunsetString: DateTimeFormatter.formatFullTime(time: parsedSunset),
      sunriseTime: parsedSunrise,
      sunsetTime: parsedSunset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sunriseString': sunriseString,
      'sunsetString': sunsetString,
      'sunriseTime': sunriseTime.toString(),
      'sunsetTime': sunsetTime.toString(),
    };
  }

  @override
  String toString() {
    final sunTimeString =
        'sunriseString: $sunriseString sunsetString:$sunsetString';

    if (sunriseTime != null && sunsetTime != null) {
      return '$sunTimeString sunrise: $sunriseTime sunset: $sunsetTime';
    } else {
      return sunTimeString;
    }
  }

  @override
  List<Object?> get props => [
        sunriseTime,
        sunsetTime,
        sunriseString,
        sunsetString,
      ];
}
