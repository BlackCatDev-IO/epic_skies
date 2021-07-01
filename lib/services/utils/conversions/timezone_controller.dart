import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
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

  late DateTime sunsetTime, sunriseTime;

  @override
  void onInit() {
    super.onInit();
    timezoneOffset =
        Duration(hours: StorageController.to.restoreTimezoneOffset() ?? 0);
    isDayCurrent = StorageController.to.restoreDayOrNight() ?? true;
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
    if (now.isAfter(sunriseTime) && now.isBefore(sunsetTime)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
  }

  void _setRemoteIsDay() {
    final location = tz.getLocation(timezoneString);
    final currentRemoteTime = tz.TZDateTime.now(location).add(timezoneOffset);
    if (currentRemoteTime.isAfter(sunriseTime) &&
        currentRemoteTime.isBefore(sunsetTime)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }
  }

  bool getForecastDayOrNight({required DateTime forecastTime}) {
    if (forecastTime.hour.isInRange(sunriseTime.hour, sunsetTime.hour)) {
      return true;
    } else {
      return false;
    }
  }

  void initLocalTimezoneString() {
    final lat = LocationController.to.position.latitude;
    final long = LocationController.to.position.longitude;
    timezoneString = tzmap.latLngToTimezoneString(lat, long);
  }

  void initRemoteTimezoneString() {
    final lat = LocationController.to.lat;
    final long = LocationController.to.long;
    timezoneString = tzmap.latLngToTimezoneString(lat, long);
  }

  void getTimeZoneOffset() {
    _parseSunsetSunriseTimes();

    tz.initializeTimeZones();

    final location = tz.getLocation(timezoneString);

    final sunsetUtc = DateTime.utc(
        sunsetTime.year,
        sunsetTime.month,
        sunsetTime.day,
        sunsetTime.hour,
        sunsetTime.minute,
        sunsetTime.millisecond,
        sunsetTime.microsecond);

    final sunsetTz = location.timeZone(sunsetUtc.millisecondsSinceEpoch);
    timezoneOffset = Duration(milliseconds: sunsetTz.offset);
    // running again to update times with current timezone offset
    _parseSunsetSunriseTimes();
    StorageController.to.storeTimezoneOffset(timezoneOffset.inHours);
    _setCurrentDayOrNight();
  }

  Future<void> _parseSunsetSunriseTimes() async {
    final todayMap = StorageController.to.dataMap['timelines'][1]['intervals']
        [0]['values'] as Map;
    sunriseTime = parseTimeBasedOnLocalOrRemoteSearch(
        time: todayMap['sunriseTime'] as String);

    sunsetTime = parseTimeBasedOnLocalOrRemoteSearch(
        time: todayMap['sunsetTime'] as String);
  }

  DateTime parseTimeBasedOnLocalOrRemoteSearch({required String time}) {
    final searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();

    if (searchIsLocal) {
      return DateTime.parse(time).toLocal();
    } else {
      return DateTime.parse(time).add(timezoneOffset);
    }
  }
}
