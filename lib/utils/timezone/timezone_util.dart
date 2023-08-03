import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneUtil {
  TimeZoneUtil._();

  static Duration timezoneOffset = Duration.zero;
  static String timezone = '';

  static bool getCurrentIsDay({
    required bool searchIsLocal,
    required List<SunTimesModel> refSuntimes,
    required int refTimeEpochInSeconds,
  }) {
    late bool isDay;

    final referenceTime = currentReferenceSunTime(
      searchIsLocal: searchIsLocal,
      suntimeList: refSuntimes,
      refTimeEpochInSeconds: refTimeEpochInSeconds,
    );

    final currentTime =
        getCurrentLocalOrRemoteTime(searchIsLocal: searchIsLocal);

    if (searchIsLocal) {
      final now = DateTime.now();
      isDay = now.isAfter(referenceTime.sunriseTime!) &&
          now.isBefore(referenceTime.sunsetTime!);
    } else {
      isDay = currentTime.isAfter(referenceTime.sunriseTime!) &&
          currentTime.isBefore(referenceTime.sunsetTime!);
    }
    return isDay;
  }

  static bool getForecastDayOrNight({
    required int forecastTimeEpochInSeconds,
    required SunTimesModel referenceTime,
    required bool searchIsLocal,
  }) {
    final time = secondsFromEpoch(
      secondsSinceEpoch: forecastTimeEpochInSeconds,
      searchIsLocal: searchIsLocal,
    );
    return time.isAfter(referenceTime.sunriseTime!) &&
        time.isBefore(referenceTime.sunsetTime!);
  }

  static void setTimeZoneOffset({required double lat, required double long}) {
    try {
      tz.initializeTimeZones();
      timezone = tzmap.latLngToTimezoneString(lat, long);
      final location = tz.getLocation(timezone);
      final nowUtc =
          location.timeZone(DateTime.now().utc.millisecondsSinceEpoch);

      timezoneOffset = Duration(milliseconds: nowUtc.offset);

      AppDebug.log('Timezone offset: $timezoneOffset', name: 'TimeZoneUtil');
    } on Exception catch (e) {
      AppDebug.log('Error setting timezone offset: $e');
      rethrow;
    }
  }

  static String timezoneString({
    required double lat,
    required double long,
  }) {
    return tzmap.latLngToTimezoneString(lat, long);
  }

  static bool isBetweenMidnightAnd6Am({required bool searchIsLocal}) {
    final now = getCurrentLocalOrRemoteTime(searchIsLocal: searchIsLocal);

    final lastMidnight = now.subtract(
      Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond,
      ),
    );

    final sixAm = lastMidnight.add(const Duration(hours: 6));

    return now.isBetween(
      startTime: lastMidnight,
      endTime: sixAm,
      method: 'isBetweenMidnightand6am',
    );
  }

  static DateTime getCurrentLocalOrRemoteTime({required bool searchIsLocal}) {
    if (searchIsLocal) {
      return DateTime.now();
    } else {
      return DateTime.now().add(timezoneOffset).toUtc();
    }
  }

  static DateTime secondsFromEpoch({
    required int secondsSinceEpoch,
    required bool searchIsLocal,
  }) {
    return searchIsLocal
        ? DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000)
            .add(timezoneOffset)
            .toUtc();
  }

  static bool isSameTimeOrBetween({
    required DateTime referenceTime,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    final isBetween =
        referenceTime.isAfter(startTime) && referenceTime.isBefore(endTime);
    final isSameTimeAsEndTime = referenceTime.isEqual(endTime);

    return isBetween || isSameTimeAsEndTime;
  }

  static SunTimesModel currentReferenceSunTime({
    required bool searchIsLocal,
    required List<SunTimesModel> suntimeList,
    required int refTimeEpochInSeconds,
  }) {
    final time = secondsFromEpoch(
      secondsSinceEpoch: refTimeEpochInSeconds,
      searchIsLocal: searchIsLocal,
    );

    for (final suntime in suntimeList) {
      if (time.day == suntime.sunriseTime!.day) {
        return suntime;
      }
    }
    return suntimeList[0];
  }

  static List<SunTimesModel> initSunTimeList({
    required WeatherResponseModel weatherModel,
    required bool searchIsLocal,
    required UnitSettings unitSettings,
  }) {
    final suntimeList = <SunTimesModel>[];

    var startIndex = 0;

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that

    if (TimeZoneUtil.isBetweenMidnightAnd6Am(
      searchIsLocal: searchIsLocal,
    )) {
      startIndex++;
    }

    for (var i = startIndex; i <= 14; i++) {
      late SunTimesModel sunTime;

      final weatherData = weatherModel.days[i];

      sunTime = SunTimesModel.fromDailyData(
        data: weatherData,
        unitSettings: unitSettings,
        searchIsLocal: searchIsLocal,
      );

      suntimeList.add(sunTime);
    }

    /// This is a bit of a hack solution that accounts for when the app has to
    /// bump up the start index for when the remote time is between midnight and
    /// 6am. Sometimes the Tomorrow.io response will have 16 total days,
    /// sometimes it will only have 15. To prevent a range error when populating
    /// the next 14 days of daily forecast widgets, this just copies the sun
    /// times of the 13th day to the 14th day. The sunTimeList always needs to
    /// have at least 15 items. The only scenario where this would actually
    /// happen is if a user was searching the weather of somewhere else in the
    /// world where the local time happens to be between midnight and 6am. Even
    /// then the only not fully accurate data would be the sun times for the
    /// 14th day may be a couple minutes off

    if (suntimeList.length == 14) {
      suntimeList.add(suntimeList[13].clone());
    }

    return suntimeList;
  }
}
