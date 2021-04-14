import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../location_controller.dart';
import '../search_controller.dart';
import 'lat_long_tiimezone_converter.dart' as tzmap;

class TimeZoneController extends GetxController {
  static TimeZoneController get to => Get.find();

  String timezoneString = '';

  bool isDayCurrent = true;

  Duration timezoneOffset;

  DateTime sunsetTime, sunriseTime;

  @override
  void onInit() {
    super.onInit();
    timezoneOffset =
        Duration(hours: StorageController.to.restoreTimezoneOffset() ?? 0);
  }

  void getCurrentDayOrNight() {
    if (DateTime.now().hour.isInRange(sunriseTime.hour, sunsetTime.hour)) {
      isDayCurrent = true;
    } else {
      isDayCurrent = false;
    }

    StorageController.to.storeDayOrNight(isDay: isDayCurrent);
  }

  bool getForecastDayOrNight(DateTime time) {
    if (time.hour.isInRange(sunriseTime.hour, sunsetTime.hour)) {
      return true;
    } else {
      return false;
    }
  }

  void initLocalTimezoneString() {
    final lat = LocationController.to.position.latitude;
    final long = LocationController.to.position.longitude;
    timezoneString = tzmap.latLngToTimezoneString(lat: lat, lng: long);
  }

  void initRemoteTimezoneString() {
    final lat = SearchController.to.lat;
    final long = SearchController.to.long;
    timezoneString = tzmap.latLngToTimezoneString(lat: lat, lng: long);
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
    StorageController.to.storeTimezoneOffset(timezoneOffset.inHours);
  }

  Future<void> _parseSunsetSunriseTimes() async {
    final todayMap = StorageController.to.dataMap['timelines'][1]['intervals']
        [0]['values'] as Map;
    sunriseTime =
        DateTime.parse(todayMap['sunriseTime'] as String).add(timezoneOffset);
    sunsetTime =
        DateTime.parse(todayMap['sunsetTime'] as String).add(timezoneOffset);
  }
}
