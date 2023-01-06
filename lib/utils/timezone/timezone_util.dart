import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/sun_times/models/sun_time_model.dart';

class TimeZoneUtil {
  TimeZoneUtil._();

  static Duration timezoneOffset = Duration.zero;

  static bool getCurrentIsDay({
    required bool searchIsLocal,
    required DateTime currentTime,
    required SunTimesModel referenceTime,
  }) {
    late bool isDay;

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
    required DateTime forecastTime,
    required SunTimesModel referenceTime,
  }) {
    return forecastTime.isAfter(referenceTime.sunriseTime!) &&
        forecastTime.isBefore(referenceTime.sunsetTime!);
  }

  static void setTimeZoneOffset({required double lat, required double long}) {
    tz.initializeTimeZones();
    final timezone = timezoneString(lat: lat, long: long);
    final location = tz.getLocation(timezone);
    final tz.TimeZone nowUtc =
        location.timeZone(DateTime.now().utc.millisecondsSinceEpoch);

    timezoneOffset = Duration(milliseconds: nowUtc.offset);
  }

  static String timezoneString({required double lat, required double long}) {
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
            .add(timezoneOffset);
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
}
