import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ImageController extends GetxController {
  RxString backgroundImageString = ''.obs;

  final RxMap dataMap = Get.find<WeatherController>().dataMap;
  bool isDay;
  final box = GetStorage();
  String _currentCondition;

/* -------------------------------------------------------------------------- */
/*                              BACKGROUND IMAGE                              */
/* -------------------------------------------------------------------------- */

  Future<void> updateBackgroundImage(String main, String condition) async {
    isDay = Get.find<WeatherController>().isDay.value;
    _currentCondition = condition.toLowerCase();
    String m = main.toLowerCase();

    debugPrint(
        'Update BG Image main: $m : condition: $condition : isDay: $isDay');
    switch (m) {
      case 'thunderstorm':
        _getThunderstormBgImage();

        break;
      case 'drizzle':
      case 'rain':
        _getRainBgImagePath();
        break;
      case 'snow':
        _getSnowBgImagePath();
        break;
      case 'atmosphere':
        _getAtmosphereBgImagePath(main);
        break;
      case 'clear':
        _getClearBgImage();

        break;
      case 'clouds':
        _getCloudyBgImage();

        break;

      default:
        backgroundImageString.value = snowyCityStreetPortrait;

      throw 'getImagePath function failing on main: $main condition: $condition ';
    }
    _storeBgImagePath();
  }

  void _storeBgImagePath() {
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);
  }

  void _getClearBgImage() {
    switch (_currentCondition) {
      case 'few clouds':
        break;
      case 'scattered clouds':
      case 'broken clouds':
        break;
      case 'overcast clouds':
        break;
      default:
      // TODO: get clear night picture
        isDay
            ? backgroundImageString.value = clearDay1
            : backgroundImageString.value = snowyCityStreetPortrait;

      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

  void _getThunderstormBgImage() {
    switch (_currentCondition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':

      default:
        backgroundImageString.value = lightingCropped;
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

  void _getCloudyBgImage() {
    switch (_currentCondition) {
      case 'few clouds':
      // break;
      case 'scattered clouds':
      case 'broken clouds':
      // break;
      case 'overcast clouds':
      // break;
      default:
        backgroundImageString.value =
            isDay ? cloudyPortrait : earthFromSpacePortrait;
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

  void _getRainBgImagePath() {
    switch (_currentCondition) {
      case 'heavy intensity rain':
      case 'very heavy rain':
      case 'extreme rain':
      case 'freezing rain':
      case 'shower rain':
        break;

      case 'light rain':
      case 'moderate rain':
      case 'light intensity shower rain':
      case 'light intensity drizzle':
      case 'drizzle':
      case 'shower drizzle':
      case 'heavy intensity drizzle':
      case 'light intensity drizzle rain':
      case 'drizzle rain':
      case 'shower rain and drizzle':
        break;

      case 'heavy intensity shower rain':
      case 'heavy shower rain and drizzle':
      case 'ragged shower rain	':
        _storeBgImagePath();

        break;
      default:
        backgroundImageString.value = earthFromSpacePortrait;

        throw '_getRainImagePath function failing on condition: $_currentCondition ';
    }
  }

  void _getSnowBgImagePath() {
    switch (_currentCondition) {
      case 'light snow':
      case 'snow':
        break;
      case 'heavy snow':
      case 'heavy shower snow':
      case 'shower snow':
        break;
      case 'sleet':
      case 'light shower sleet':
      case 'shower sleet':
      case 'light rain and snow':
      case 'rain and snow':
      case 'light shower snow':
        break;

      default:
        backgroundImageString.value = snowyCityStreetPortrait;
        throw '_getSnowImagePath function failing on condition: $_currentCondition ';
    }
  }

  void _getAtmosphereBgImagePath(String main) {
    final m = main.toLowerCase();

    switch (m) {
      case 'Mist':
      case 'Haze':
      case 'Fog':
      case 'Smoke':
      case 'Ash':
        break;
      case 'Dust':
      case 'Sand':
        break;
      case 'Squall':
        break;
      case 'Tornado':
        break;
      default:
        backgroundImageString.value = lightingCropped;
        _storeBgImagePath();
        throw '_getAtmosphereImagePath function failing on main: $main ';
    }
  }

/* -------------------------------------------------------------------------- */
/*                                    ICONS                                   */
/* -------------------------------------------------------------------------- */

  String getIconImagePath(
      {@required String condition, @required String main, String origin}) {
    final m = main.toLowerCase();
    final iconCondition = condition.toLowerCase();
    // debugPrint('Main: $main Condition: $condition : Origin: $origin');

    switch (m) {
      case 'thunderstorm':
        return _getThunderstormIconPath(iconCondition);
        break;
      case 'drizzle':
      case 'rain':
        return _getRainIconPath(iconCondition);
        break;
      case 'snow':
        return _getSnowIconPath(iconCondition);
        break;
      case 'atmosphere':
        return _getAtmosphereIconPath(m);
        break;
      case 'clear':
        return _getClearIconPath(iconCondition);
        break;
      case 'clouds':
        return _getCloudIconPath(iconCondition);
        break;

      default:
        throw 'getImagePath function failing on main: $main condition: $condition ';

        return isDay ? clearDayIcon : clearNightIcon;
    }
  }

  String _getClearIconPath(String condition) =>
      isDay ? clearDayIcon : clearNightIcon;

  String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'few clouds':
        return isDay ? fewCloudsDay : fewCloudsNight;
        break;
      case 'scattered clouds':
      case 'broken clouds':
        return isDay ? scatteredCloudsDay : nightCloudy;
        break;
      case 'overcast clouds':
        return overcastClouds;
        break;
      default:
        throw '_getCloudImagePath function failing on main: $condition ';

        return isDay ? fewCloudsDay : nightCloudy;
    }
  }

  String _getRainIconPath(String condition) {
    switch (condition) {
      case 'heavy intensity rain':
      case 'very heavy rain':
      case 'extreme rain':
      case 'freezing rain':
      case 'shower rain':
        return rainHeavyIcon;
        break;

      case 'light rain':
      case 'moderate rain':
      case 'light intensity shower rain':
      case 'light intensity drizzle':
      case 'drizzle':
      case 'shower drizzle':
      case 'heavy intensity drizzle':
      case 'light intensity drizzle rain':
      case 'drizzle rain':
      case 'shower rain and drizzle':
        return rainLightIcon;
        break;

      case 'heavy intensity shower rain':
      case 'heavy shower rain and drizzle':
      case 'ragged shower rain	':
        return rainShowerIcon;
        break;
      default:
        throw '_getRainImagePath function failing on condition: $condition ';

        return rainLightIcon;
    }
  }

  String _getSnowIconPath(String condition) {
    switch (condition) {
      case 'light snow':
      case 'snow':
        return isDay ? daySnowIcon : nightSnowIcon;
        break;
      case 'heavy snow':
      case 'heavy shower snow':
      case 'shower snow':
        return heavySnowIcon;
        break;
      case 'sleet':
      case 'light shower sleet':
      case 'shower sleet':
      case 'light rain and snow':
      case 'rain and snow':
      case 'light shower snow':
        return sleetIcon;
        break;

      default:
        throw '_getSnowImagePath function failing on condition: $condition ';

        return isDay ? daySnowIcon : nightSnowIcon;
    }
  }

  String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDay ? thunderstormDayIcon : thunderstormHeavyIcon;
        break;

      default:
        return thunderstormHeavyIcon;
    }
  }

  String _getAtmosphereIconPath(String main) {
    final m = main.toLowerCase();

    switch (m) {
      case 'mist':
      case 'haze':
      case 'fog':
        return mist;
      case 'smoke':
      case 'ash':
        return smoke;
        break;
      case 'dust':
      case 'sand':
        return sand;
        break;
      case 'squall':
        return squalls;
        break;
      case 'tornado':
        return tornadoIcon;
        break;
      default:
        throw '_getAtmosphereImagePath function failing on main: $main ';

        return squalls;
    }
  }
}
