import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

/// Manages all logic to determine which icon to display
class IconController {
  static bool _iconIsDay = true;

  /// Used by forecast models to obtain relevant icon based on weather condition
  static String getIconImagePath({
    required String condition,
    required int temp,
    required bool tempUnitsMetric,
    required bool isDay,
  }) {
    _iconIsDay = isDay;
    var iconCondition =
        WeatherCodeConverter.convertWeatherKitCodes(condition).toLowerCase();

    /// condition string from API can have more than one word
    if (iconCondition.contains(',')) {
      final commaIndex = iconCondition.indexOf(',');
      iconCondition = iconCondition.substring(0, commaIndex);
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
      case 'partially cloudy':
      case 'overcast':
        return _getCloudIconPath(iconCondition);
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return _getWindIconPath(iconCondition);

      default:
        _logIconController(
          'getIconPath function failing on condition: $condition ',
          isError: true,
        );

        return isDay ? clearDayIcon : clearNightIcon;
    }
  }

  /// Used by forecast models to determine which precipitation icon (if any)
  /// to display
  static String getPrecipIconPath({required String precipType}) {
    return switch (precipType.toLowerCase()) {
      'rain' => rainDrop,
      'snow' || 'flurries' => snowflake,
      'freezing rain' || 'ice pellets' => hail,
      _ => rainDrop
    };
  }

  static String _getClearIconPath(String condition) =>
      _iconIsDay ? clearDayIcon : clearNightIcon;

  static String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
      case 'partially cloudy':
      case 'overcast':
        return _iconIsDay ? fewCloudsDay : fewCloudsNight;
      default:
        _logIconController(
          '_getCloudImagePath function failing on main: $condition ',
        );

        return _iconIsDay ? fewCloudsDay : nightCloudy;
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
        _logIconController(
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
          return _iconIsDay ? daySnowIcon : nightSnowIcon;
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
          _logIconController(
            '_getSnowImagePath function failing on condition: $condition ',
          );

          return _iconIsDay ? daySnowIcon : nightSnowIcon;
      }
    } else {
      return _getCloudIconPath(condition);
    }
  }

  static String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return _iconIsDay ? thunderstormDayIcon : thunderstormHeavyIcon;

      default:
        return thunderstormHeavyIcon;
    }
  }

  static void _logIconController(String message, {bool isError = false}) {
    AppDebug.log(message, name: 'IconController', isError: isError);
  }
}
