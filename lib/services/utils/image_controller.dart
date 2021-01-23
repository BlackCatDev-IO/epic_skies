import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ImageController extends GetxController {
  RxString backgroundImageString = ' '.obs;
  RxBool isDay = true.obs;

  final RxMap dataMap = Get.find<WeatherController>().dataMap;
  final box = GetStorage();

  String getImagePath(
      {@required String condition, @required String main, String origin}) {
    debugPrint('Main: $main Condition: $condition : Origin: $origin');
    switch (main) {
      case 'Thunderstorm':
        return _getThunderstormImagePath(condition);
        break;
      case 'Drizzle':
      case 'Rain':
        return _getRainImagePath(condition);
        break;
      case 'Snow':
        return _getSnowImagePath(condition);
        break;
      case 'Atmosphere':
        return _getAtmosphereImagePath(condition);
        break;
      case 'Clear':
        return _getClearImagePath(condition);
        break;
      case 'Clouds':
        return _getCloudImagePath(condition);
        break;

      default:
        backgroundImageString.value = snowPortrait;
        throw 'getImagePath function failing on main: $main condition: $condition ';

        return clearDayIcon;
    }
  }

  String _getThunderstormImagePath(String condition) {
    backgroundImageString.value = lightingCropped;
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);

    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return thunderstormDayIcon;
        break;

      default:
        return thunderstormHeavyIcon;
    }
  }

  String _getRainImagePath(String condition) {
    backgroundImageString.value = snowPortrait;
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);


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

  String _getSnowImagePath(String condition) {
    backgroundImageString.value = snowPortrait;
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);

    switch (condition) {
      case 'light snow':
      case 'snow':
        return isDay() ? daySnowIcon : nightSnowIcon;
        break;
      case 'Heavy snow':
      case 'Heavy shower snow':
      case 'Shower snow':
        return heavySnowIcon;
        break;
      case 'Sleet':
      case 'Light shower sleet':
      case 'Shower sleet':
      case 'Light rain and snow':
      case 'Rain and snow':
      case 'Light shower snow':
        return sleetIcon;
        break;

      default:
        throw '_getSnowImagePath function failing on condition: $condition ';

        return daySnowIcon;
    }
  }

  String _getAtmosphereImagePath(String main) {
    backgroundImageString.value = cloudyPortrait;
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);

    switch (main) {
      case 'Mist':
      case 'Haze':
      case 'Fog':
        return mist;
      case 'Smoke':
      case 'Ash':
        return smoke;
        break;
      case 'Dust':
      case 'Sand':
        return sand;
        break;
      case 'Squall':
        return squalls;
        break;
      case 'Tornado':
        return tornadoIcon;
        break;
      default:
        throw '_getAtmosphereImagePath function failing on main: $main ';

        return clearDayIcon;
    }
  }

  String _getClearImagePath(String condition) {
    backgroundImageString.value = 'assets/images/sunny_portrait.jpg';
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);

    switch (isDay.value) {
      case false:
        return 'assets/icons/vclouds_icons/clear_night.png';
        break;
      default:
        // throw '_getClearImagePath function failing on condition: $condition ';

        return clearDayIcon;
    }
  }

  String _getCloudImagePath(String condition) {
    backgroundImageString.value = 'assets/images/cloudy_portrait2.jpg';
    dataMap[backgroundImageKey] = backgroundImageString.value;
    box.write(dataMapKey, dataMap);

    switch (condition) {
      case 'few clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/few_clouds_day.png'
            : 'assets/icons/vclouds_icons/few_clouds_night.png';
        break;
      case 'scattered clouds':
      case 'broken clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/scattered_clouds_day.png'
            : nightCloudy;
        break;
      case 'overcast clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/overcast_clouds_day.png'
            : nightCloudy;
        break;
      default:
        throw '_getCloudImagePath function failing on main: $condition ';

        return 'assets/icons/vclouds_icons/few_clouds_day.png';
    }
  }
}
