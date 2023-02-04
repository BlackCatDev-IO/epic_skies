part of 'color_cubit.dart';

class ColorState {
  ColorState({
    this.theme = const CustomColorTheme(
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
    ),
    this.heavyFont = false,
  });

  final CustomColorTheme theme;
  final bool heavyFont;

  ColorState copyWith({
    CustomColorTheme? colorTheme,
    bool? heavyFont,
  }) {
    return ColorState(
      theme: colorTheme ?? theme,
      heavyFont: heavyFont ?? this.heavyFont,
    );
  }
}
