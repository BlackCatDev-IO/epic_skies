import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/timezone/timezone_util.dart';
import '../../main_weather/models/weather_response_model/weather_data_model.dart';

part 'sun_time_model.freezed.dart';
part 'sun_time_model.g.dart';

@freezed
class SunTimesModel with _$SunTimesModel {
  factory SunTimesModel({
    required String sunsetString,
    required String sunriseString,
    DateTime? sunriseTime,
    DateTime? sunsetTime,
  }) = _SunTimesModel;

  factory SunTimesModel.fromJson(Map<String, dynamic> json) =>
      _$SunTimesModelFromJson(json);

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
