import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const _clearDay1Image = _Image(clearDay1);
  static const earthFromSpaceImage = _Image(earthFromSpace);
  static const earthFromSpaceWithLogoImage = _Image(earthFromSpaceWithLogo);
  static const _clearNight1Image = _Image(clearNight1);
  static const _clearNight2Image = _Image(clearNight2);
  static const _cloudyDay1Image = _Image(cloudyDay1);
  static const _cloudyDaySunset2Image = _Image(cloudyDaySunset2);
  static const _cloudyNight1Image = _Image(cloudyNight1);
  static const _cloudyNight2Image = _Image(cloudyNight2);
  static const _cloudyNight3Image = _Image(cloudyNight3);
  static const _cloudyNight4Image = _Image(cloudyNight4);
  static const _rainSadFace1Image = _Image(rainSadFace1);
  static const _snowDay1Image = _Image(snowDay1);
  static const _snowNight1Image = _Image(snowNight1);
  static const _stormNight1Image = _Image(stormNight1);

  static final imageMap = <String, _Image>{
    earthFromSpace: earthFromSpaceImage,
    clearDay1: _clearDay1Image,
    clearNight1: _clearNight1Image,
    clearNight2: _clearNight2Image,
    cloudyDay1: _cloudyDay1Image,
    cloudyDaySunset2: _cloudyDaySunset2Image,
    cloudyNight1: _cloudyNight1Image,
    cloudyNight2: _cloudyNight2Image,
    cloudyNight3: _cloudyNight3Image,
    cloudyNight4: _cloudyNight4Image,
    rainSadFace1: _rainSadFace1Image,
    snowDay1: _snowDay1Image,
    snowNight1: _snowNight1Image,
    stormNight1: _stormNight1Image,
  };

  static const imageModelList = <WeatherImageModel>[
    WeatherImageModel(
      imageUrl: clearDay1,
      isDay: true,
      condition: WeatherImageType.clear,
    ),
    WeatherImageModel(
      imageUrl: clearNight1,
      isDay: false,
      condition: WeatherImageType.clear,
    ),
    WeatherImageModel(
      imageUrl: clearNight2,
      isDay: false,
      condition: WeatherImageType.clear,
    ),
    WeatherImageModel(
      imageUrl: cloudyDay1,
      isDay: true,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: cloudyDaySunset2,
      isDay: true,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: cloudyNight1,
      isDay: false,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: cloudyNight2,
      isDay: false,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: cloudyNight3,
      isDay: false,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: cloudyNight4,
      isDay: false,
      condition: WeatherImageType.cloudy,
    ),
    WeatherImageModel(
      imageUrl: rainSadFace1,
      isDay: true,
      condition: WeatherImageType.rain,
    ),
    WeatherImageModel(
      imageUrl: snowDay1,
      isDay: true,
      condition: WeatherImageType.snow,
    ),
    WeatherImageModel(
      imageUrl: snowNight1,
      isDay: false,
      condition: WeatherImageType.snow,
    ),
    WeatherImageModel(
      imageUrl: stormNight1,
      isDay: false,
      condition: WeatherImageType.storm,
    ),
  ];

  static Future<void> precacheAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(_clearDay1Image, context),
      precacheImage(earthFromSpaceImage, context),
      precacheImage(earthFromSpaceWithLogoImage, context),
      precacheImage(_clearNight1Image, context),
      precacheImage(_clearNight2Image, context),
      precacheImage(_cloudyDay1Image, context),
      precacheImage(_cloudyDaySunset2Image, context),
      precacheImage(_cloudyNight1Image, context),
      precacheImage(_cloudyNight2Image, context),
      precacheImage(_cloudyNight3Image, context),
      precacheImage(_cloudyNight4Image, context),
      precacheImage(_rainSadFace1Image, context),
      precacheImage(_snowDay1Image, context),
      precacheImage(_snowNight1Image, context),
      precacheImage(_stormNight1Image, context),
    ]);
  }

  static Future<void> precacheFirstImage(
    String key,
    BuildContext context,
  ) async {
    await precacheImage(imageMap[key]!, context);
  }
}
