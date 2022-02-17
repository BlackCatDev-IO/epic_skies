import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/location/user_location/controllers/location_controller.dart';

class TimeZoneController extends GetxController {
  TimeZoneController({required this.storage});

  static TimeZoneController get to => Get.find();
  final StorageController storage;

  String timezoneString = '';

  late SunTimesModel sunTimeModel;

  bool getCurrentIsDay() {
    final bool searchIsLocal = storage.restoreSavedSearchIsLocal();
    _initSuntimeModel();

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

  void initLocalTimezoneString() {
    final lat = LocationController.to.position.latitude;
    final long = LocationController.to.position.longitude;
    timezoneString = tzmap.latLngToTimezoneString(lat!, long!);
  }

  void initRemoteTimezoneString() {
    final lat = RemoteLocationController.to.data.remoteLat;
    final long = RemoteLocationController.to.data.remoteLong;
    timezoneString = tzmap.latLngToTimezoneString(lat, long);
  }

  void getTimeZoneOffset() {
    _initSuntimeModel();

    tz.initializeTimeZones();

    final location = tz.getLocation(timezoneString);

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

  bool isBetweenMidnightAnd6Am() {
    final searchIsLocal = storage.restoreSavedSearchIsLocal();

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

  Future<void> _initSuntimeModel() async {
    final todayData = WeatherRepository
        .to.weatherModel!.timelines[Timelines.daily].intervals[0].data;

    sunTimeModel = SunTimesModel.fromWeatherData(
      data: todayData,
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

  void initSunTimesFromStorage() {
    if (!storage.firstTimeUse()) {
      sunTimeModel = storage.restoreMostRecentSunTimeModel();
    }
  }
}
