import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchListTile extends GetView<ViewController> {
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
            controller.goToHomeTab();
            WeatherRepository.to.fetchRemoteWeatherData(suggestion: suggestion);
          },
          trailing: searching
              ? const SizedBox()
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
