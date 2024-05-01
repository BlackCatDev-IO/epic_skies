import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneUtil {
  Duration timezoneOffset = Duration.zero;
  String timezone = '';

  DateTime nowUtc() {
    final now = DateTime.now();

    /// Not the same as `DateTime.now().toUtc()` which still factors in the
    /// local timezone, including the offset
    return DateTime.utc(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  }

  bool getCurrentIsDay({
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

    final currentTime = nowUtc();

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

  bool getCurrentIsDayFromWeatherKit({
    required bool searchIsLocal,
    required List<SunTimesModel> refSuntimes,
    required DateTime referenceTime,
  }) {
    final referenceSuntime = currentReferenceSunTimeFromWeatherKit(
      searchIsLocal: searchIsLocal,
      suntimeList: refSuntimes,
      refTime: referenceTime,
    );

    final currentTime =
        getCurrentLocalOrRemoteTime(searchIsLocal: searchIsLocal);

    return currentTime.isAfter(referenceSuntime.sunriseTime!) &&
        currentTime.isBefore(referenceSuntime.sunsetTime!);
  }

  bool getForecastDayOrNight({
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

  bool getForecastDayOrNightFromWeatherKit({
    required DateTime hourlyForecastStart,
    required SunTimesModel referenceTime,
    required bool searchIsLocal,
  }) {
    return hourlyForecastStart.isAfter(referenceTime.sunriseTime!) &&
        hourlyForecastStart.isBefore(referenceTime.sunsetTime!);
  }

  void setTimeZoneOffset({
    required Coordinates coordinates,
  }) {
    try {
      tz.initializeTimeZones();
      timezone = _updatedOutdatedTimezoneNames(
        tzmap.latLngToTimezoneString(coordinates.lat, coordinates.long),
      );

      final location = tz.getLocation(timezone);
      final nowUtc =
          location.timeZone(DateTime.now().toUtc().millisecondsSinceEpoch);

      timezoneOffset = Duration(milliseconds: nowUtc.offset);

      AppDebug.log('Timezone offset: $timezoneOffset', name: 'TimeZoneUtil');
    } on Exception catch (e) {
      AppDebug.log('Error setting timezone offset: $e', isError: true);
      rethrow;
    }
  }

  DateTime getCurrentLocalOrRemoteTime({required bool searchIsLocal}) {
    if (searchIsLocal) {
      return nowUtc();
    } else {
      return DateTime.now().add(timezoneOffset).toUtc();
    }
  }

  DateTime addedTimezoneOffsetUtc(DateTime time) {
    return time.add(timezoneOffset).toUtc();
  }

  DateTime secondsFromEpoch({
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

  DateTime localOrOffsetTime({
    required DateTime dateTime,
    required bool searchIsLocal,
  }) {
    return searchIsLocal
        ? dateTime.toLocal().toUtc()
        : dateTime.add(timezoneOffset).toUtc();
  }

  SunTimesModel currentReferenceSunTime({
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

  SunTimesModel currentReferenceSunTimeFromWeatherKit({
    required bool searchIsLocal,
    required List<SunTimesModel> suntimeList,
    required DateTime refTime,
  }) {
    final time = refTime.addTimezoneOffset();

    for (final suntime in suntimeList) {
      if (time.day == suntime.sunriseTime!.day) {
        return suntime;
      }
    }
    return suntimeList[0];
  }

  List<SunTimesModel> initSunTimeList({
    required WeatherResponseModel weatherModel,
    required bool searchIsLocal,
    required UnitSettings unitSettings,
  }) {
    final suntimeList = <SunTimesModel>[];

    const startIndex = 0;

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

    return suntimeList;
  }

  List<SunTimesModel> initSunTimeListFromWeatherKit({
    required Weather weather,
    required bool searchIsLocal,
    required UnitSettings unitSettings,
  }) {
    final suntimeList = <SunTimesModel>[];

    for (var i = 0; i <= weather.forecastDaily.days.length - 1; i++) {
      final day = weather.forecastDaily.days[i];

      final sunTime = SunTimesModel.fromWeatherKit(
        data: day,
        unitSettings: unitSettings,
      );
      suntimeList.add(sunTime);
    }

    return suntimeList;
  }

  /// Checks for timezone names that have been updated in the IANA timezone
  /// database but not accounted for in the timezone package
  String _updatedOutdatedTimezoneNames(String timezone) {
    return switch (timezone) {
      'Europe/Kiev' => 'Europe/Kyiv',
      _ => timezone,
    };
  }
}

extension DateTimeExtensions on DateTime {
  DateTime addTimezoneOffset() {
    return add(getIt<TimeZoneUtil>().timezoneOffset);
  }
}
