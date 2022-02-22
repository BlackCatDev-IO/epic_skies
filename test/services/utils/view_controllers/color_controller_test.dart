import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/custom_color_theme.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/map_keys/image_map_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../mocks/mock_image_file_data.dart';

void main() {
  setUpAll(() async {
    Get.put(ColorController());
  });

  group('color controller test', () {
    test('clearDay1 image sets default theme', () {
      final clearDayList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.clearDay];
      final clearDay1 = clearDayList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: clearDay1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('clearNight1 image sets clearNight1 theme', () {
      final clearNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.clearNight];
      final clearNight1 = clearNightList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: clearNight1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('clearNight2 image sets clearNight2 theme', () {
      final clearNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.clearNight];
      final clearNight2 = clearNightList![1] as String;
      ColorController.to.updateTextAndContainerColors(path: clearNight2);

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
      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('cloudyDay1 image sets cloudyDay1 theme', () {
      final cloudyDayList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyDay];
      final cloudyDay1 = cloudyDayList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyDay1);

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
      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('cloudyDay2 image sets cloudyDay2 theme', () {
      final cloudyDayList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyDay];
      final cloudyDay2 = cloudyDayList![1] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyDay2);

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
      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('cloudyNight1 image sets cloudyNight1 theme', () {
      final cloudyNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyNight];
      final cloudyNight1 = cloudyNightList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyNight1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('cloudyNight2 image sets cloudyNight2 theme', () {
      final cloudyNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyNight];
      final cloudyNight2 = cloudyNightList![1] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyNight2);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('cloudyNight3 image sets cloudyNight3 theme', () {
      final cloudyNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyNight];
      final cloudyNight3 = cloudyNightList![2] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyNight3);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });
    test('cloudyNight4 image sets cloudyNight4 theme', () {
      final cloudyNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.cloudyNight];
      final cloudyNight4 = cloudyNightList![3] as String;
      ColorController.to.updateTextAndContainerColors(path: cloudyNight4);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('rainDay1 image sets rainSadFace theme', () {
      final rainyDayList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.rainyDay];
      final rainyDay1 = rainyDayList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: rainyDay1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('snowDay1 image sets snowFlake theme', () {
      final snowDayList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.snowyDay];
      final snowDay1 = snowDayList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: snowDay1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('snowNight1 image sets snowFlake theme', () {
      final snowNightList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.snowyNight];
      final snowNight1 = snowNightList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: snowNight1);

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

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, false);
    });

    test('earthFromSpace sets earthFromSpace theme', () {
      final earthFromSpaceList =
          MockImageFileData.mockImageFilePathMap[ImageFileKeys.earthFromSpace];
      final earthFromSpace = earthFromSpaceList![0] as String;
      ColorController.to.updateTextAndContainerColors(path: earthFromSpace);

      final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black54,
        homeContainerColor: Colors.black38,
        bgImageTextColor: Colors.white,
        bgImageParamColor: Colors.white,
        conditionColor: Colors.blue[50]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: Colors.blueGrey[100]!,
        tabTitleColor: Colors.white60,
      );

      expect(ColorController.to.theme, updatedTheme);
      expect(ColorController.to.heavyFont, true);
    });

    test('invalid path sets default theme and throws exception', () {
      expect(
        () => ColorController.to.updateTextAndContainerColors(path: ''),
        throwsA(
          isA<Exception>(),
        ),
      );

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

      expect(ColorController.to.theme, updatedTheme);
    });
  });
}
