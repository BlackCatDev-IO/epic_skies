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
  static const clearNight1Image = _Image(clearNight1);
  static const clearNight2Image = _Image(clearNight2);
  static const cloudyDay1Image = _Image(cloudyDay1);
  static const cloudyDaySunset2Image = _Image(cloudyDaySunset2);
  static const cloudyNight1Image = _Image(cloudyNight1);
  static const cloudyNight2Image = _Image(cloudyNight2);
  static const cloudyNight3Image = _Image(cloudyNight3);
  static const cloudyNight4Image = _Image(cloudyNight4);
  static const rainSadFace1Image = _Image(rainSadFace1);
  static const snowDay1Image = _Image(snowDay1);
  static const snowNight1Image = _Image(snowNight1);
  static const stormNight1Image = _Image(stormNight1);

  static final imageMap = <String, _Image>{
    earthFromSpace: earthFromSpaceImage,
    clearDay1: _clearDay1Image,
    clearNight1: clearNight1Image,
    clearNight2: clearNight2Image,
    cloudyDay1: cloudyDay1Image,
    cloudyDaySunset2: cloudyDaySunset2Image,
    cloudyNight1: cloudyNight1Image,
    cloudyNight2: cloudyNight2Image,
    cloudyNight3: cloudyNight3Image,
    cloudyNight4: cloudyNight4Image,
    rainSadFace1: rainSadFace1Image,
    snowDay1: snowDay1Image,
    snowNight1: snowNight1Image,
    stormNight1: stormNight1Image,
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
      precacheImage(clearNight1Image, context),
      precacheImage(clearNight2Image, context),
      precacheImage(cloudyDay1Image, context),
      precacheImage(cloudyDaySunset2Image, context),
      precacheImage(cloudyNight1Image, context),
      precacheImage(cloudyNight2Image, context),
      precacheImage(cloudyNight3Image, context),
      precacheImage(cloudyNight4Image, context),
      precacheImage(rainSadFace1Image, context),
      precacheImage(snowDay1Image, context),
      precacheImage(snowNight1Image, context),
      precacheImage(stormNight1Image, context),
    ]);
  }

  static Future<void> precacheFirstImage(
    String key,
    BuildContext context,
  ) async {
    await precacheImage(imageMap[key]!, context);
  }
}
