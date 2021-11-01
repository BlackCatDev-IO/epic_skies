import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/custom_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorController extends GetxController {
  static ColorController get to => Get.find();

  CustomColorTheme theme = CustomColorTheme(
    bgImageTextColor: Colors.white70,
    bgImageParamColor: Colors.white70,
    paramValueColor: Colors.white70,
    conditionColor: Colors.white70,
    soloCardColor: Colors.black54,
    layeredCardColor: Colors.black38,
    homeContainerColor: Colors.transparent,
    epicSkiesHeaderFontColor: Colors.blueGrey,
    roundedLabelColor: Colors.white54,
    tabTitleColor: Colors.white60,
    appBarColor: Colors.black45,
  );

  FontWeight cityFontWeight = FontWeight.w500;
  FontWeight streetFontWeight = FontWeight.w500;
  FontWeight countryFontWeight = FontWeight.w500;

  void updateTextAndContainerColors({required String path}) {
    if (path.endsWith(clearDay1)) {
      _setDefaultTheme();
    } else if (path.endsWith(clearNight1)) {
      _setClearNight1Theme();
    } else if (path.endsWith(clearNight2)) {
      _setClearNight2Theme();
    } else if (path.endsWith(cloudyDay1)) {
      _setcloudyDay1Theme();
    } else if (path.endsWith(cloudyDaySunset2)) {
      _setcloudyDaySunset2Theme();
    } else if (path.endsWith(cloudyNight1)) {
      _setcloudyNight1Theme();
    } else if (path.endsWith(cloudyNight2)) {
      _setcloudyNight2Theme();
    } else if (path.endsWith(cloudyNight3)) {
      _setcloudyNight3Theme();
    } else if (path.endsWith(cloudyNight4)) {
      _setcloudyNight4Theme();
    } else if (path.endsWith(rainSadFace1)) {
      _setRainSadFaceTheme();
    } else if (path.endsWith(snowDay1)) {
      _setSnowFlakeTheme();
    } else if (path.endsWith(snowNight1)) {
      _setSnowNight1Theme();
    } else if (path.endsWith(stormNight1)) {
      _setThunderStormNightTheme();
    } else if (path.endsWith(earthFromSpace)) {
      _setDefaultTheme();
    } else {
      _setDefaultTheme();
    }
    update();
    update(['app_bar']);
  }

  void _setDefaultTheme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black26,
      homeContainerColor: Colors.black26,
      bgImageTextColor: Colors.white,
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[50]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Colors.blueGrey[200]!,
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setClearNight1Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setClearNight2Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Colors.blueGrey[200]!,
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyDay1Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black45,
      homeContainerColor: Colors.black26,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.teal[100]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.55),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyDaySunset2Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: Colors.yellow[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: kBlackCustom,
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyNight1Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.75),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.75),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyNight2Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.transparent,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.75),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyNight3Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.75),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.75),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setcloudyNight4Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.8),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setSnowFlakeTheme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black26,
      homeContainerColor: const Color.fromRGBO(0, 0, 0, 0.3),
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: Colors.yellow[100]!,
      conditionColor: Colors.teal[50]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.725),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setRainSadFaceTheme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: const Color.fromRGBO(0, 0, 0, 0.6),
      homeContainerColor: const Color.fromRGBO(0, 0, 0, 0.45),
      bgImageTextColor: Colors.white,
      bgImageParamColor: Colors.yellow[100]!,
      conditionColor: Colors.white,
      paramValueColor: Colors.white,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.725),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.black54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setSnowNight1Theme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }

  void _setThunderStormNightTheme() {
    final updatedTheme = CustomColorTheme(
      appBarColor: Colors.black54,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Colors.blueGrey[100]!,
      bgImageParamColor: Colors.blueAccent[100]!,
      conditionColor: Colors.teal[100]!,
      paramValueColor: Colors.yellow[50]!,
      soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Colors.blueGrey[100]!,
      tabTitleColor: Colors.white60,
    );

    theme = updatedTheme;
  }
}
