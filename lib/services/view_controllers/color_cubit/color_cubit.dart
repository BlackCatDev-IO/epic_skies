import 'package:epic_skies/models/custom_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/constants/my_colors.dart';
import '../../../global/local_constants.dart';
part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorState()) {
    _theme = state.theme;
    _heavyFont = state.heavyFont;
  }

  late CustomColorTheme _theme;
  late bool _heavyFont;

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
      _setEarthFromSpaceTheme();
    } else {
      _setDefaultTheme();
      const error = 'invalid path sent to updateTextAndContainerColors';

      throw Exception(error);
    }
    emit(state.copyWith(colorTheme: _theme, heavyFont: _heavyFont));
    // update();
    // update(['app_bar']);
  }

  void _setDefaultTheme() {
    const updatedTheme = CustomColorTheme(
      appBarColor: Colors.black26,
      homeContainerColor: Colors.black26,
      bgImageTextColor: Colors.white,
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal50,
      paramValueColor: MyColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: MyColors.blueGrey200,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.65),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: MyColors.blueGrey200,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.teal100,
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
      bgImageParamColor: MyColors.yellow100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.yellow100,
      conditionColor: MyColors.teal50,
      paramValueColor: MyColors.yellow50,
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
      bgImageParamColor: MyColors.yellow100,
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
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
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
      bgImageTextColor: MyColors.blueGrey100,
      bgImageParamColor: MyColors.blueAccent100,
      conditionColor: MyColors.teal100,
      paramValueColor: MyColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: MyColors.blueGrey100,
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
      conditionColor: MyColors.blue50,
      paramValueColor: MyColors.yellow50,
      soloCardColor: Color.fromRGBO(0, 0, 0, 0.7),
      layeredCardColor: Colors.black12,
      roundedLabelColor: Colors.white54,
      epicSkiesHeaderFontColor: MyColors.blueGrey100,
      tabTitleColor: Colors.white60,
    );

    _heavyFont = true;
    _theme = updatedTheme;
  }
}
