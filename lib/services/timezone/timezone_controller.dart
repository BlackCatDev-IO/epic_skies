import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';

import 'package:get/get.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/sun_times/controllers/sun_time_controller.dart';

class TimeZoneController extends GetxController {
  TimeZoneController({required this.storage});

  static TimeZoneController get to => Get.find();
  final StorageController storage;

  bool getCurrentIsDay() {
    final bool searchIsLocal = storage.restoreSavedSearchIsLocal();
    final sunTimeModel = SunTimeController.to.referenceSuntime();

    late bool isDay;

    if (searchIsLocal) {
      final now = DateTime.now();
      isDay = now.isAfter(sunTimeModel.sunriseTime!) &&
          now.isBefore(sunTimeModel.sunsetTime!);
    } else {
      final currentRemoteTime = CurrentWeatherController.to.currentTime;
      isDay = currentRemoteTime.isAfter(sunTimeModel.sunriseTime!) &&
          currentRemoteTime.isBefore(sunTimeModel.sunsetTime!);
    }

    storage.storeDayOrNight(isDay: isDay);
    if (storage.restoreSavedSearchIsLocal()) {
      storage.storeLocalIsDay(isDay: isDay);
    }
    return isDay;
  }

  bool getForecastDayOrNight({
    required DateTime forecastTime,
    required int index,
  }) {
    final sunTimeModel = SunTimeController.to.referenceSuntime();

    if (sunTimeModel.sunriseTime != null) {
      if (forecastTime.hour.isInRange(
        sunTimeModel.sunriseTime!.hour,
        sunTimeModel.sunsetTime!.hour,
      )) {
        storage.storeForecastIsDay(isDay: true, index: index);
        return true;
      } else {
        storage.storeForecastIsDay(isDay: false, index: index);

        return false;
      }
    } else {
      return storage.restoreForecastIsDay(index: index);
    }
  }

  void getTimeZoneOffset({required double lat, required double long}) {
    final sunTimeModel = SunTimeController.to.referenceSuntime();

    tz.initializeTimeZones();
    final timezone = timezoneString(lat: lat, long: long);

    final location = tz.getLocation(timezone);

    final sunsetUtc = DateTime.utc(
      sunTimeModel.sunsetTime!.year,
      sunTimeModel.sunsetTime!.month,
      sunTimeModel.sunsetTime!.day,
      sunTimeModel.sunsetTime!.hour,
      sunTimeModel.sunsetTime!.minute,
      sunTimeModel.sunsetTime!.millisecond,
      sunTimeModel.sunsetTime!.microsecond,
    );

    final tz.TimeZone sunsetTz =
        location.timeZone(sunsetUtc.millisecondsSinceEpoch);

    final timezoneOffset = Duration(milliseconds: sunsetTz.offset);

    storage.storeTimezoneOffset(timezoneOffset.inHours);
  }

  String timezoneString({required double lat, required double long}) {
    return tzmap.latLngToTimezoneString(lat, long);
  }

  bool isBetweenMidnightAnd6Am({required bool searchIsLocal}) {
    final now = searchIsLocal
        ? DateTime.now()
        : CurrentWeatherController.to.currentTime;

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

  DateTime parseTimeBasedOnLocalOrRemoteSearch({required String time}) {
    final searchIsLocal = storage.restoreSavedSearchIsLocal();
    final timezoneOffset = Duration(
      hours: storage.restoreTimezoneOffset(),
    );

    return searchIsLocal
        ? DateTime.parse(time).toLocal()
        : DateTime.parse(time).add(timezoneOffset);
  }

  bool isSameTimeOrBetween({
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
