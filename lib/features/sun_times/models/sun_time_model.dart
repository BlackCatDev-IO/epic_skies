import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

import '../../../models/weather_response_models/weather_data_model.dart';
import '../../../utils/timezone/timezone_util.dart';

class SunTimesModel extends Equatable {
  const SunTimesModel({
    required this.sunsetString,
    required this.sunriseString,
    this.sunriseTime,
    this.sunsetTime,
  });

  final String sunsetString;
  final String sunriseString;
  final DateTime? sunriseTime;
  final DateTime? sunsetTime;

  factory SunTimesModel.fromDailyData({
    required DailyData data,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final sunriseTime = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.sunriseEpoch!,
      searchIsLocal: searchIsLocal,
    );

    final sunsetTime = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.sunsetEpoch!,
      searchIsLocal: searchIsLocal,
    );
    return SunTimesModel(
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: sunriseTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: sunsetTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
    );
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
        sunriseString,
        sunsetString,
        sunriseTime,
        sunsetTime,
      ];

  Map<String, dynamic> toMap() {
    return {
      'sunsetString': sunsetString,
      'sunriseString': sunriseString,
      'sunriseTime': sunriseTime?.millisecondsSinceEpoch,
      'sunsetTime': sunsetTime?.millisecondsSinceEpoch,
    };
  }

  factory SunTimesModel.fromMap(Map<String, dynamic> map) {
    return SunTimesModel(
      sunsetString: (map['sunsetString'] as String?) ?? '',
      sunriseString: (map['sunriseString'] as String?) ?? '',
      sunriseTime: map['sunriseTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['sunriseTime'] as int,
            )
          : null,
      sunsetTime: map['sunsetTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['sunsetTime'] as int,
            )
          : null,
    );
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
