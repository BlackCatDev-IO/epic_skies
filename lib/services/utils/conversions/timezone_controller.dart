import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:get/get.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../location/location_controller.dart';

class TimeZoneController extends GetxController {
  static TimeZoneController get to => Get.find();

  String timezoneString = '';

  bool isDayCurrent = true;

  late Duration timezoneOffset;

  DateTime? sunsetTime, sunriseTime;

  @override
  void onInit() {
    super.onInit();
    timezoneOffset =
        Duration(hours: StorageController.to.restoreTimezoneOffset() ?? 0);
    isDayCurrent = StorageController.to.restoreDayOrNight() ?? true;
    _initSunTimesFromStorage();
  }

  void _setCurrentDayOrNight() {
    final bool searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      _setLocalIsDay();
    } else {
      _setRemoteIsDay();
    }
    StorageController.to.storeDayOrNight(isDay: isDayCurrent);
  }

  void _setLocalIsDay() {
    final now = DateTime.now();
    if (now.isAfter(sunriseTime!) && now.isBefore(sunsetTime!)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
  }

  void _setRemoteIsDay() {
    final location = tz.getLocation(timezoneString);
    final currentRemoteTime = tz.TZDateTime.now(location).add(timezoneOffset);
    if (currentRemoteTime.isAfter(sunriseTime!) &&
        currentRemoteTime.isBefore(sunsetTime!)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
  }

  bool getForecastDayOrNight(
      {required DateTime forecastTime, required int index}) {
    if (sunriseTime != null) {
      if (forecastTime.hour.isInRange(sunriseTime!.hour, sunsetTime!.hour)) {
        StorageController.to.storeForecastIsDay(isDay: true, index: index);
        return true;
      } else {
        StorageController.to.storeForecastIsDay(isDay: false, index: index);

        return false;
      }
    } else {
      return StorageController.to.restoreForecastIsDay(index: index);
    }
  }

  void initLocalTimezoneString() {
    final lat = LocationController.to.position.latitude;
    final long = LocationController.to.position.longitude;
    timezoneString = tzmap.latLngToTimezoneString(lat!, long!);
  }

  void initRemoteTimezoneString() {
    final lat = LocationController.to.remoteLat;
    final long = LocationController.to.remoteLong;
    timezoneString = tzmap.latLngToTimezoneString(lat, long);
  }

  void getTimeZoneOffset() {
    _parseSunsetSunriseTimes();

    tz.initializeTimeZones();

    final location = tz.getLocation(timezoneString);

    final sunsetUtc = DateTime.utc(
        sunsetTime!.year,
        sunsetTime!.month,
        sunsetTime!.day,
        sunsetTime!.hour,
        sunsetTime!.minute,
        sunsetTime!.millisecond,
        sunsetTime!.microsecond);

    final tz.TimeZone sunsetTz =
        location.timeZone(sunsetUtc.millisecondsSinceEpoch);
    timezoneOffset = Duration(milliseconds: sunsetTz.offset);
    // running again to update times with current timezone offset
    _parseSunsetSunriseTimes();
    StorageController.to.storeTimezoneOffset(timezoneOffset.inHours);
    _setCurrentDayOrNight();
  }

  bool isBetweenMidnightAnd6Am() {
    final now = DateTime.now();
    final lastMidnight = now.subtract(Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));

    final sixAm = lastMidnight.add(const Duration(hours: 6));

    return now.isBetween(startTime: lastMidnight, endTime: sixAm);
  }

  bool isMidnightOrAfter({required DateTime time}) {
    final endOfDay = DateTime.now().endOfDay;
    return time.isAfter(endOfDay);
  }

  Future<void> _parseSunsetSunriseTimes() async {
    final todayMap = StorageController.to.dataMap['timelines'][1]['intervals']
        [0]['values'] as Map;
    sunriseTime = parseTimeBasedOnLocalOrRemoteSearch(
        time: todayMap['sunriseTime'] as String);

    sunsetTime = parseTimeBasedOnLocalOrRemoteSearch(
        time: todayMap['sunsetTime'] as String);

    StorageController.to
        .storeSunsetAndSunriseTimes(sunrise: sunriseTime!, sunset: sunsetTime!);
  }

  DateTime parseTimeBasedOnLocalOrRemoteSearch({required String time}) {
    final searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();

    return searchIsLocal
        ? DateTime.parse(time).toLocal()
        : DateTime.parse(time).add(timezoneOffset);
  }

  SunTimesModel parseSunriseAndSunsetTimes(
      {required String sunrise, required String sunset}) {
    final sunriseTime = parseTimeBasedOnLocalOrRemoteSearch(time: sunrise);
    final sunsetTime = parseTimeBasedOnLocalOrRemoteSearch(time: sunset);

    final sunriseString = DateTimeFormatter.formatFullTime(time: sunriseTime);
    final sunsetString = DateTimeFormatter.formatFullTime(time: sunsetTime);

    return SunTimesModel(
        sunriseString: sunriseString,
        sunsetString: sunsetString,
        sunriseTime: sunriseTime,
        sunsetTime: sunsetTime);
  }

  bool sunTimeIsInBetween(
      {required DateTime sunTime,
      required DateTime start,
      required DateTime end}) {
    final searchIsLocal = WeatherRepository.to.searchIsLocal;

    if (searchIsLocal) {
      return sunTime.isBetween(startTime: start, endTime: end);
    } else {
      final offsetSuntime = sunTime.subtract(timezoneOffset);
      return offsetSuntime.isBetween(startTime: start, endTime: end);
    }
  }

  void _initSunTimesFromStorage() {
    final hasStoredSunset = StorageController.to.restoreSunset() != null;

    if (hasStoredSunset) {
      sunsetTime = StorageController.to.restoreSunset();
      sunriseTime = StorageController.to.restoreSunrise();
    }
  }
}
