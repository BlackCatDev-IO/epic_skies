import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:sizer/sizer.dart';

class SearchListTile extends GetView<DrawerAnimationController> {
  final SearchSuggestion suggestion;
  final bool searching;

  const SearchListTile({required this.suggestion, required this.searching});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) => RoundedContainer(
        color: colorController.theme.soloCardColor,
        radius: 7,
        child: ListTile(
          title: MyTextWidget(text: suggestion.description, fontSize: 11.sp),
          onTap: () {
            controller.navigateToHome();
            WeatherRepository.to.fetchRemoteWeatherData(suggestion: suggestion);
          },
          trailing: searching
              ? nil
              : IconButton(
                  onPressed: () =>
                      SearchDialogs.confirmDeleteSearch(suggestion: suggestion),
                  icon: const Icon(Icons.delete, color: Colors.white38),
                ),
        ),
      ).paddingSymmetric(vertical: 2.5),
    );
  }
}
