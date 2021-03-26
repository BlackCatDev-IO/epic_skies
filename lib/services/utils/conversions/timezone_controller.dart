import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../location_controller.dart';
import '../search_controller.dart';
import 'lat_long_tiimezone_converter.dart' as tzmap;

class TimeZoneController extends GetxController {
  static TimeZoneController get to => Get.find();

  String sunsetTime = '';
  String sunriseTime = '';
  String timezoneString = '';

  bool isDayCurrent = true;

  int today, tomorrow, newTimeDay;

  Duration timezoneOffset;

  DateTime sunset, sunrise, now, newTime, tomorrowSunset, tomorrowSunrise;

  //TODO Make sure isDay doesn't get used before this function runs

  @override
  void onInit() {
    super.onInit();
    timezoneOffset =
        Duration(hours: StorageController.to.restoreTimezoneOffset() ?? 0);
  }

  void getCurrentDayOrNight() {
    _parseAndInitTimes();

    isDayCurrent = now.isBefore(sunset) && sunrise.isBefore(now);
    // debugPrint('XX Sunrise $sunrise sunset: $sunset  $isDayCurrent');

    StorageController.to.storeDayOrNight(isDay: isDayCurrent);
    // debugPrint('getDayOrNight isDay value at end of function: $isDayCurrent');
  }

  bool getForecastDayOrNight(String time) {
    _parseAndInitTimes();
    _addTimezoneOffset();

    newTime =
        DateTime.parse(time).add(timezoneOffset).add(const Duration(hours: 1));
    newTimeDay = newTime.day;

    bool isDay = true;

    if (newTimeDay == today) {
      isDay = newTime.isBefore(sunset) && sunrise.isBefore(newTime);
    } else if (newTimeDay == tomorrow) {
      isDay =
          newTime.isBefore(tomorrowSunset) && tomorrowSunrise.isBefore(newTime);
    }
    // debugPrint(
    //     'XX newTime: $newTime Sunrise $tomorrowSunrise sunset: $tomorrowSunset  $isDay');

    // debugPrint('YY today sunrise: $sunrise today sunset: $sunset');
    return isDay;
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
    _parseAndInitTimes();

    tz.initializeTimeZones();

    final location = tz.getLocation(timezoneString);

    final sunsetUtc = DateTime.utc(sunset.year, sunset.month, sunset.day,
        sunset.hour, sunset.minute, sunset.millisecond, sunset.microsecond);
    final sunsetTz = location.timeZone(sunsetUtc.millisecondsSinceEpoch);
    timezoneOffset = Duration(milliseconds: sunsetTz.offset);
    StorageController.to.storeTimezoneOffset(timezoneOffset.inHours);
  }

  Future<void> _parseAndInitTimes() async {
    final todayMap = StorageController.to.dataMap['timelines'][1]['intervals']
        [0]['values'] as Map;

    sunsetTime = todayMap['sunsetTime'] as String;
    sunriseTime = todayMap['sunriseTime'] as String;

    now = DateTime.now();
    today = now.day;
    tomorrow = today + 1;
    sunrise = DateTime.parse(sunriseTime);

    sunset = DateTime.parse(sunsetTime);
  }

  void _addTimezoneOffset() {
    sunrise = sunrise.add(timezoneOffset);
    sunset = sunset.add(timezoneOffset);
    tomorrowSunset = sunset.add(const Duration(hours: 24));
    tomorrowSunrise = sunrise.add(const Duration(hours: 24));
  }
}
