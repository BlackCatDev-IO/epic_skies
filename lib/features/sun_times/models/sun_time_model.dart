import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:objectbox/objectbox.dart';

import '../../../models/weather_response_models/weather_data_model.dart';

@Entity()
class SunTimesModel {
  SunTimesModel({
    this.id = 0,
    required this.sunsetString,
    required this.sunriseString,
    this.sunriseTime,
    this.sunsetTime,
  });

  int id;
  final String sunsetString;
  final String sunriseString;
  final DateTime? sunriseTime;
  final DateTime? sunsetTime;

  factory SunTimesModel.fromWeatherData({
    required WeatherData data,
    int? id,
  }) {
    return SunTimesModel(
      id: id ?? 0,
      sunriseTime: data.sunriseTime,
      sunsetTime: data.sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: data.sunriseTime!,
        timeIn24Hrs: data.unitSettings.timeIn24Hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: data.sunsetTime!,
        timeIn24Hrs: data.unitSettings.timeIn24Hrs,
      ),
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
}

extension Clone on SunTimesModel {
  SunTimesModel clone() {
    return SunTimesModel(
      sunsetString: sunsetString,
      sunriseString: sunriseString,
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
    );
  }
}
