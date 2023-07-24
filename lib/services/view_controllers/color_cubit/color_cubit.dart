import 'package:epic_skies/global/constants/custom_colors.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/custom_color_theme.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_state.dart';

/// Handlles updating font colors to provide sufficient contrast against the
/// changing background images
class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorState()) {
    _theme = state.theme;
    _heavyFont = state.heavyFont;
  }

  late CustomColorTheme _theme;
  late bool _heavyFont;

  /// Gets called if on weather refresh ifImageSettings are
  /// ImageSettings.dynamic
  void updateTextAndContainerColors({required String path}) {
    if (path.contains(clearDay1)) {
      _setDefaultTheme();
    } else if (path.contains(clearNight1)) {
      _setClearNight1Theme();
    } else if (path.contains(clearNight2)) {
      _setClearNight2Theme();
    } else if (path.contains(cloudyDay1)) {
      _setcloudyDay1Theme();
    } else if (path.contains(cloudyDaySunset2)) {
      _setcloudyDaySunset2Theme();
    } else if (path.contains(cloudyNight1)) {
      _setcloudyNight1Theme();
    } else if (path.contains(cloudyNight2)) {
      _setcloudyNight2Theme();
    } else if (path.contains(cloudyNight3)) {
      _setcloudyNight3Theme();
    } else if (path.contains(cloudyNight4)) {
      _setcloudyNight4Theme();
    } else if (path.contains(rainSadFace1)) {
      _setRainSadFaceTheme();
    } else if (path.contains(snowDay1)) {
      _setSnowFlakeTheme();
    } else if (path.contains(snowNight1)) {
      _setSnowNight1Theme();
    } else if (path.contains(stormNight1)) {
      _setThunderStormNightTheme();
    } else if (path.contains(earthFromSpace)) {
      _setEarthFromSpaceTheme();
    } else {
      _setDefaultTheme();

      AppDebug.log(
        'invalid path sent to updateTextAndContainerColors path: $path',
        name: 'ColorCubit',
      );
    }
    emit(state.copyWith(colorTheme: _theme, heavyFont: _heavyFont));
  }

  void _setDefaultTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black26,
      homeContainerColor: Colors.black26,
      bgImageTextColor: Colors.white,
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal50,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: CustomColors.blueGrey200,
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setClearNight1Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setClearNight2Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: CustomColors.blueGrey200,
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyDay1Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black45,
      homeContainerColor: Colors.black26,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.teal100,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.55),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyDaySunset2Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: CustomColors.yellow100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: kBlackCustom,
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.7),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyNight1Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.75),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.75),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyNight2Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.transparent,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.75),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyNight3Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.7),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.75),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.75),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setcloudyNight4Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black12,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.8),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setSnowFlakeTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black26,
      homeContainerColor: Color.fromRGBO(0, 0, 0, 0.3),
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: CustomColors.yellow100,
      conditionColor: CustomColors.teal50,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.725),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setRainSadFaceTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Color.fromRGBO(0, 0, 0, 0.6),
      homeContainerColor: Color.fromRGBO(0, 0, 0, 0.45),
      bgImageTextColor: Colors.white,
      bgImageParamColor: CustomColors.yellow100,
      conditionColor: Colors.white,
      paramValueColor: Colors.white,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.725),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.black54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setSnowNight1Theme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black38,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Color.fromRGBO(255, 255, 255, 0.8),
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: Color.fromRGBO(255, 255, 255, 0.8),
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setThunderStormNightTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black54,
      homeContainerColor: Colors.black38,
      bgImageTextColor: CustomColors.blueGrey100,
      bgImageParamColor: CustomColors.blueAccent100,
      conditionColor: CustomColors.teal100,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: CustomColors.blueGrey100,
      tabTitleColor: Colors.white60,
    );
    _heavyFont = false;
    _theme = updatedTheme;
  }

  void _setEarthFromSpaceTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black54,
      homeContainerColor: Colors.black38,
      bgImageTextColor: Colors.white,
      bgImageParamColor: Colors.white,
      conditionColor: CustomColors.blue50,
      paramValueColor: CustomColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: CustomColors.blueGrey100,
      tabTitleColor: Colors.white60,
    );

    _heavyFont = true;
    _theme = updatedTheme;
  }
}
