import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomColorTheme extends Equatable {
  const CustomColorTheme({
    required this.bgImageParamColor,
    required this.paramValueColor,
    required this.conditionColor,
    required this.soloCardColor,
    required this.layeredCardColor,
    required this.homeContainerColor,
    required this.epicSkiesHeaderFontColor,
    required this.roundedLabelColor,
    required this.tabTitleColor,
    required this.appBarColor,
    required this.bgImageTextColor,
  });

  final Color bgImageTextColor;
  final Color bgImageParamColor;
  final Color paramValueColor;
  final Color conditionColor;
  final Color soloCardColor;
  final Color layeredCardColor;
  final Color homeContainerColor;
  final Color epicSkiesHeaderFontColor;
  final Color roundedLabelColor;
  final Color tabTitleColor;
  final Color appBarColor;

  @override
  List<Object?> get props => [
        bgImageTextColor,
        bgImageParamColor,
        paramValueColor,
        conditionColor,
        soloCardColor,
        layeredCardColor,
        homeContainerColor,
        epicSkiesHeaderFontColor,
        roundedLabelColor,
        tabTitleColor,
        appBarColor,
        bgImageTextColor,
      ];
}
