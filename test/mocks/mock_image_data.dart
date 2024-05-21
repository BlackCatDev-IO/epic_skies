import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/global/local_constants.dart';

class MockImageData {
  MockImageData._();

  static const testImagePath = '/test_image_path';
  static const imageModelList = <WeatherImageModel>[
    WeatherImageModel(
      isDay: true,
      condition: WeatherImageType.clear,
      imageUrl: clearDay1,
    ),
    WeatherImageModel(
      isDay: true,
      condition: WeatherImageType.cloudy,
      imageUrl: cloudyDay1,
    ),
  ];
}
