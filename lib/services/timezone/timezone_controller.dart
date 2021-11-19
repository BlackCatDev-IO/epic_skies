import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/location/remote_location_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:get/get.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../location/location_controller.dart';

class TimeZoneController extends GetxController {
  static TimeZoneController get to => Get.find();

  String timezoneString = '';

  bool isDayCurrent = true;

  late Duration timezoneOffset;

  late SunTimesModel sunTimeModel;

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
    if (now.isAfter(sunTimeModel.sunriseTime!) &&
        now.isBefore(sunTimeModel.sunsetTime!)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
  }

  void _setRemoteIsDay() {
    final currentRemoteTime = CurrentWeatherController.to.currentTime;
    if (currentRemoteTime.isAfter(sunTimeModel.sunriseTime!) &&
        currentRemoteTime.isBefore(sunTimeModel.sunsetTime!)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
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
    final lat = RemoteLocationController.to.locationData.remoteLat;
    final long = RemoteLocationController.to.locationData.remoteLong;
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

    timezoneOffset = Duration(milliseconds: sunsetTz.offset);

    /// running again to update times with current timezone offset
    _initSuntimeModel();

    StorageController.to.storeTimezoneOffset(timezoneOffset.inHours);
    _setCurrentDayOrNight();
  }

  bool isBetweenMidnightAnd6Am() {
    final searchIsLocal = WeatherRepository.to.searchIsLocal;

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

    sunTimeModel = SunTimesModel.fromWeatherData(data: todayData);

    StorageController.to.storeSunsetAndSunriseTimes(
      sunrise: sunTimeModel.sunriseTime!,
      sunset: sunTimeModel.sunsetTime!,
    );
  }

  DateTime parseTimeBasedOnLocalOrRemoteSearch({required String time}) {
    final searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();

    return searchIsLocal
        ? DateTime.parse(time).toLocal()
        : DateTime.parse(time).add(timezoneOffset);
  }

  bool isSameTimeOrBetween({
    required DateTime referenceTime,
    required DateTime startTime,
    required DateTime endTime,
    required String method,
    Duration? offset,
  }) {
    final isBetween =
        referenceTime.isAfter(startTime) && referenceTime.isBefore(endTime);
    final isSameTimeAsEndTime = referenceTime.isEqual(endTime);

    return isBetween || isSameTimeAsEndTime;
  }

  void _initSunTimesFromStorage() {
    final firstTimeUse = StorageController.to.firstTimeUse();

    if (!firstTimeUse) {
      final todayData = StorageController.to.restoreTodayData();
      sunTimeModel = SunTimesModel.fromMap(todayData);
    }
  }
}
