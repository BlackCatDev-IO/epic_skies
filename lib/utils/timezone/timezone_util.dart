import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneUtil {
  ReferenceTimesModel getReferenceTimesModel({
    required WeatherState weatherState,
  }) {
    assert(
      weatherState.weather != null || weatherState.weatherModel != null,
      'Weather or WeatherModel must not be null',
    );

    final timezoneOffset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    late final DateTime nowFromResponse;

    if (!weatherState.useBackupApi) {
      nowFromResponse = weatherState.weather!.currentWeather.asOf;
    } else {
      nowFromResponse = DateTime.fromMillisecondsSinceEpoch(
        weatherState.weatherModel!.currentCondition.datetimeEpoch,
      );
    }

    final now = nowFromResponse.add(timezoneOffset);

    final (suntimes, isDay) = _getSuntimesAndIsDay(
      weatherState: weatherState,
      now: now,
    );

    return ReferenceTimesModel(
      now: now,
      timezone: weatherState.refTimes.timezone,
      timezoneOffsetInMs: timezoneOffset.inMilliseconds,
      refererenceSuntimes: suntimes,
      isDay: isDay,
    );
  }

  (Duration, String) offsetAndTimezone({
    required Coordinates coordinates,
  }) {
    try {
      tz.initializeTimeZones();
      final timezone = _updatedOutdatedTimezoneNames(
        tzmap.latLngToTimezoneString(coordinates.lat, coordinates.long),
      );

      final location = tz.getLocation(timezone);
      final nowUtc =
          location.timeZone(DateTime.now().toUtc().millisecondsSinceEpoch);

      final timezoneOffset = Duration(milliseconds: nowUtc.offset);

      AppDebug.log('Timezone offset: $timezoneOffset', name: 'TimeZoneUtil');
      return (timezoneOffset, timezone);
    } on Exception catch (e) {
      AppDebug.log('Error setting timezone offset: $e', isError: true);
      rethrow;
    }
  }

  List<SunTimesModel> _initSunTimeList({
    required WeatherState weatherState,
  }) {
    final suntimeList = <SunTimesModel>[];

    final timezoneOffset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    if (weatherState.weather != null) {
      for (var i = 0;
          i <= weatherState.weather!.forecastDaily.days.length - 1;
          i++) {
        final day = weatherState.weather!.forecastDaily.days[i];
        final sunriseTime = day.sunrise!.add(timezoneOffset);
        final sunsetTime = day.sunset!.add(timezoneOffset);

        final sunTime = SunTimesModel(
          sunriseTime: sunriseTime,
          sunsetTime: sunsetTime,
          sunriseString: DateTimeFormatter.formatFullTime(
            time: sunriseTime,
            timeIn24Hrs: weatherState.unitSettings.timeIn24Hrs,
          ),
          sunsetString: DateTimeFormatter.formatFullTime(
            time: sunsetTime,
            timeIn24Hrs: weatherState.unitSettings.timeIn24Hrs,
          ),
        );

        suntimeList.add(sunTime);
      }
    } else {}

    return suntimeList;
  }

  (List<SunTimesModel>, bool) _getSuntimesAndIsDay({
    required WeatherState weatherState,
    required DateTime now,
  }) {
    final suntimesList = _initSunTimeList(
      weatherState: weatherState,
    );

    final offset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    late DateTime referenceTime;

    if (!weatherState.useBackupApi) {
      referenceTime = weatherState.weather!.currentWeather.asOf.add(offset);
    } else {
      referenceTime = DateTime.fromMillisecondsSinceEpoch(
        weatherState.weatherModel!.currentCondition.datetimeEpoch * 1000,
      ).add(offset);
    }

    final sameDaySuntime = suntimesList.firstWhere(
      (suntime) => suntime.sunriseTime!.day == referenceTime.day,
      orElse: () => suntimesList.first,
    );

    final isDay = now.isAfter(sameDaySuntime.sunriseTime!) &&
        now.isBefore(sameDaySuntime.sunsetTime!);

    return (suntimesList, isDay);
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
