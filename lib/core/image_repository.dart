import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ImageRepository {
  const ImageRepository();

  static const _dayEnpointConditionRecords = <(String, WeatherImageType)>[
    ('day/01_cloudy_day.jpg', WeatherImageType.cloudy),
    ('day/01_sunny_compressed.jpg', WeatherImageType.clear),
    ('day/01_snowflake.jpg', WeatherImageType.snow),
    ('day/01_light_rain_sadface_compressed.jpg', WeatherImageType.rain),
    ('day/02_cloudy_sunset_compressed.jpg', WeatherImageType.cloudy),
    ('storm/01_storm.jpg', WeatherImageType.storm),
  ];

  static const _nightEnpointConditionRecords = <(String, WeatherImageType)>[
    ('night/01_starry_mountain_night_compressed.jpg', WeatherImageType.clear),
    ('night/01_night_starry_clouds.jpg', WeatherImageType.clear),
    ('night/01_snowy_city_street_compressed.jpg', WeatherImageType.snow),
    ('night/02_night_moon_clouds.jpg', WeatherImageType.cloudy),
    ('night/04_night_eerie_clouds.jpg', WeatherImageType.cloudy),
    ('night/02_starry_city_night_compressed.jpg', WeatherImageType.clear),
    ('night/03_northern_lights_clouds.jpg', WeatherImageType.cloudy),
  ];

  Future<List<WeatherImageModel>> getImageModelList() async {
    try {
      final hasConnection = await InternetConnection().hasInternetAccess;

      if (!hasConnection) {
        throw NoConnectionException();
      }

      final dayList = _dayEnpointConditionRecords.map(
        (endpointConditionRecord) {
          final (endpoint, condition) = endpointConditionRecord;
          return WeatherImageModel(
            condition: condition,
            isDay: true,
            imageUrl: '${Env.IMAGE_CDN_URL}$endpoint',
          );
        },
      );

      final nightList = _nightEnpointConditionRecords.map(
        (endpointConditionRecord) {
          final (endpoint, condition) = endpointConditionRecord;
          return WeatherImageModel(
            condition: condition,
            isDay: false,
            imageUrl: '${Env.IMAGE_CDN_URL}$endpoint',
          );
        },
      );

      return [...dayList, ...nightList];
    } catch (e) {
      AppDebug.logSentryError(
        'Error fetching images: $e',
        name: 'Image Repository',
        stack: StackTrace.current,
      );

      rethrow;
    }
  }
}
