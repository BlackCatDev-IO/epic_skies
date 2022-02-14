import 'dart:developer';

import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';

class IconController {
  static bool isDay = true;

  static String getIconImagePath({
    required String condition,
    required int temp,
    required bool tempUnitsMetric,
    int? index,
    DateTime? time,
    bool? isDayForCurrentLocationButton,
  }) {
    final iconCondition = condition.toLowerCase();

    final hourly = index != null && time != null;

    if (index != null && time != null) {
      isDay = TimeZoneController.to
          .getForecastDayOrNight(forecastTime: time, index: index);
    } else {
      isDay = isDayForCurrentLocationButton ??
          true; // large daily detail widget icon defaults to day version
    }

    switch (iconCondition) {
      case 'thunderstorm':
        return _getThunderstormIconPath(iconCondition);
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        return _getRainIconPath(iconCondition);
      case 'snow':
      case 'flurries':
      case 'light snow':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
        return _getSnowIconPath(
          condition: iconCondition,
          temp: temp,
          tempUnitsMetric: tempUnitsMetric,
        );
      case 'clear':
      case 'mostly clear':
        return _getClearIconPath(iconCondition);
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return _getCloudIconPath(iconCondition);
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return _getWindIconPath(iconCondition);

      default:
        log('getIconPath function failing on condition: $condition ');

        return isDay ? clearDayIcon : clearNightIcon;
    }
  }

  static String _getClearIconPath(String condition) =>
      isDay ? clearDayIcon : clearNightIcon;

  static String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return isDay ? fewCloudsDay : fewCloudsNight;
      default:
        log('_getCloudImagePath function failing on main: $condition ');

        return isDay ? fewCloudsDay : nightCloudy;
    }
  }

  static String _getRainIconPath(String condition) {
    switch (condition) {
      case 'heavy rain':
        return rainHeavyIcon;
      case 'light rain':
      case 'rain':
      case 'drizzle':
        return rainLightIcon;
      default:
        log(
          '_getRainImagePath function failing on condition: $condition ',
        );
        return rainLightIcon;
    }
  }

  static String _getWindIconPath(String condition) {
    switch (condition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return rainLightIcon;
      default:
        return rainLightIcon;
    }
  }

  static String _getSnowIconPath({
    required String condition,
    required int temp,
    required bool tempUnitsMetric,
  }) {
    final falseSnow = WeatherCodeConverter.falseSnow(
      temp: temp,
      condition: condition,
      tempUnitsMetric: tempUnitsMetric,
    );

    if (!falseSnow) {
      switch (condition) {
        case 'light snow':
        case 'snow':
          return isDay ? daySnowIcon : nightSnowIcon;
        case 'heavy snow':
        case 'heavy shower snow':
        case 'shower snow':
          return heavySnowIcon;
        case 'flurries':
        case 'light freezing rain':
        case 'heavy freezing rain':
        case 'ice pellets':
        case 'heavy ice pellets':
        case 'light ice pellets':
        case 'freezing drizzle':
        case 'freezing rain':
          return sleetIcon;
        default:
          log(
            '_getSnowImagePath function failing on condition: $condition ',
          );

          return isDay ? daySnowIcon : nightSnowIcon;
      }
    } else {
      return _getCloudIconPath(condition);
    }
  }

  static String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDay ? thunderstormDayIcon : thunderstormHeavyIcon;

      default:
        return thunderstormHeavyIcon;
    }
  }

  static String getPrecipIconPath({required String precipType}) {
    switch (precipType.toLowerCase()) {
      case 'rain':
        return rainDrop;
      case 'snow':
        return snowflake;
      case 'freezing rain':
      case 'ice pellets':
        return hail;
      default:
        return rainDrop;
    }
  }
}
