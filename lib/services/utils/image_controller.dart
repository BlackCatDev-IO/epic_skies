import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  RxString backgroundImageString = ''.obs;

  bool isDayCurrent;
  bool forecastIsDay;
  String _currentCondition;

/* -------------------------------------------------------------------------- */
/*                              BACKGROUND IMAGE                              */
/* -------------------------------------------------------------------------- */

  Future<void> updateBackgroundImage(String main, String condition) async {
    isDayCurrent = Get.find<WeatherController>().isDay;
    _currentCondition = condition.toLowerCase();
    String m = main.toLowerCase();

    debugPrint(
        'Update BG Image main: $m : condition: $condition : isDay: $isDayCurrent');
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
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
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

        throw 'getImagePath function failing on main: $main condition: $_currentCondition ';
    }
    Get.find<ColorController>().updateBgText();
    Get.find<StorageController>().storeBgImage(backgroundImageString.value);
  }

  void _getClearBgImage() => isDayCurrent
      ? backgroundImageString.value = clearDay1
      : backgroundImageString.value = starryMountainPortrait;

  void _getThunderstormBgImage() {
    switch (_currentCondition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':

      default:
        backgroundImageString.value = lightingCropped;
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

// TODO get better overcast picture for day time
  void _getCloudyBgImage() {
    switch (_currentCondition) {
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
      case 'overcast clouds':
      default:
        backgroundImageString.value =
            isDayCurrent ? cloudyPortrait : starryMountainPortrait;
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

      case 'heavy intensity shower rain':
      case 'heavy shower rain and drizzle':
      case 'ragged shower rain	':
        backgroundImageString.value = earthFromSpacePortrait;

        break;

      default:
        backgroundImageString.value = earthFromSpacePortrait;
        break;

        throw '_getRainImagePath function failing on condition: $_currentCondition ';
    }
  }

  void _getSnowBgImagePath() {
    switch (_currentCondition) {
      case 'light snow':
      case 'snow':
      case 'heavy snow':
      case 'heavy shower snow':
      case 'shower snow':
      case 'sleet':
      case 'light shower sleet':
      case 'shower sleet':
      case 'light rain and snow':
      case 'rain and snow':
      case 'light shower snow':

      default:
        backgroundImageString.value =
            isDayCurrent ? snowPortrait : snowyCityStreetPortrait;
      // throw '_getSnowImagePath function failing on condition: $_currentCondition ';
    }
  }

  void _getAtmosphereBgImagePath(String main) {
    final m = main.toLowerCase();

    switch (m) {
      case 'mist':
      case 'haze':
      case 'fog':
      case 'smoke':
      case 'ash':
      case 'dust':
      case 'sand/ dust whirls':
      case 'sand':
      case 'squalls':
      case 'volcanic ash':
      case 'tornado':
      default:
        backgroundImageString.value = lightingCropped;
      // throw '_getAtmosphereImagePath function failing on main: $m ';
    }
  }

/* -------------------------------------------------------------------------- */
/*                                    ICONS                                   */
/* -------------------------------------------------------------------------- */

  String getIconImagePath(
      {@required String condition, @required String main, String origin}) {
    final m = main.toLowerCase();
    final iconCondition = condition.toLowerCase();
    isDayCurrent = Get.find<WeatherController>().isDay;

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
        return isDayCurrent ? clearDayIcon : clearNightIcon;

        throw 'getIconPath function failing on main: $main condition: $condition ';
    }
  }

  String _getClearIconPath(String condition) =>
      isDayCurrent ? clearDayIcon : clearNightIcon;

  String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'few clouds':
        return isDayCurrent ? fewCloudsDay : fewCloudsNight;
        break;
      case 'scattered clouds':
      case 'broken clouds':
        return isDayCurrent ? scatteredCloudsDay : nightCloudy;
        break;
      case 'overcast clouds':
        return overcastClouds;
        break;
      default:
        throw '_getCloudImagePath function failing on main: $condition ';

        return isDayCurrent ? fewCloudsDay : nightCloudy;
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
        return isDayCurrent ? daySnowIcon : nightSnowIcon;
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

        return isDayCurrent ? daySnowIcon : nightSnowIcon;
    }
  }

  String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDayCurrent ? thunderstormDayIcon : thunderstormHeavyIcon;
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
