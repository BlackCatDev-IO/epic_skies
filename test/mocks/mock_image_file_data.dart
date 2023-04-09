import 'package:epic_skies/utils/map_keys/image_map_keys.dart';

class MockImageFileData {
  MockImageFileData._();

  static const testImagePath = '/test_image_path';

  static final mockFileMap = <String, List<String>>{
    'clear_day': [
      '$testImagePath/assets/images/01_sunny_compressed.jpg',
    ],
    'clear_night': [
      '$testImagePath/01_starry_mountain_night_compressed.jpg',
      '$testImagePath/02_starry_city_night_compressed.jpg',
    ],
    'cloudy_day': [
      '$testImagePath/01_cloudy_day.jpg',
      '$testImagePath/02_cloudy_sunset_compressed.jpg',
    ],
    'cloudy_night': [
      '$testImagePath/01_night_starry_clouds.jpg',
      '$testImagePath/02_night_moon_clouds.jpg',
      '$testImagePath/03_northern_lights_clouds.jpg',
      '$testImagePath/04_night_eerie_clouds.jpg',
    ],
    'rain_day': [
      '$testImagePath/01_light_rain_sadface_compressed.jpg',
    ],
    'rain_night': [],
    'snow_day': [
      '$testImagePath/01_snowflake.jpg',
    ],
    'snow_night': [
      '$testImagePath/01_snowy_city_street_compressed.jpg',
    ],
    'storm_day': [],
    'storm_night': [
      '$testImagePath/01_storm.jpg',
    ],
    'earth_from_space': [
      '$testImagePath/assets/images/01_earth_from_space.png',
    ]
  };

  /// This is exactly equivalent to the data that is pulled and stored from 
  /// firestore
  static const mockImageFilePathMap = {
    ImageFileKeys.clearDay: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/assets/images/01_sunny_compressed.jpg'
    ],
    ImageFileKeys.clearNight: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_starry_mountain_night_compressed.jpg',
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/02_starry_city_night_compressed.jpg'
    ],
    ImageFileKeys.cloudyDay: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_cloudy_day.jpg',
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/02_cloudy_sunset_compressed.jpg'
    ],
    ImageFileKeys.cloudyNight: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_night_starry_clouds.jpg',
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/02_night_moon_clouds.jpg',
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/03_northern_lights_clouds.jpg',
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/04_night_eerie_clouds.jpg'
    ],
    ImageFileKeys.rainyDay: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_light_rain_sadface_compressed.jpg'
    ],
    ImageFileKeys.rainyNight: [],
    ImageFileKeys.snowyDay: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_snowflake.jpg'
    ],
    ImageFileKeys.snowyNight: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_snowy_city_street_compressed.jpg'
    ],
    ImageFileKeys.stormyDay: [],
    ImageFileKeys.stormyNight: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/01_storm.jpg'
    ],
    ImageFileKeys.earthFromSpace: [
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/assets/images/01_earth_from_space.png'
    ],
  };
}
