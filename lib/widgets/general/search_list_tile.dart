import 'package:epic_skies/global/alert_dialogs/search_dialogs.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SearchListTile extends StatelessWidget {
  final SearchSuggestion suggestion;

  const SearchListTile({required this.suggestion});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) => RoundedContainer(
        color: controller.soloCardColor,
        radius: 7,
        child: ListTile(
          title: MyTextWidget(text: suggestion.description!, fontSize: 18),
          onTap: () async {
            Get.delete<SearchController>();
            WeatherRepository.to.fetchRemoteWeatherData(suggestion: suggestion);
          },
          trailing: IconButton(
            onPressed: () =>
                confirmDeleteSearch(context: context, suggestion: suggestion),
            icon: const Icon(Icons.delete, color: Colors.white38),
          ),
        ),
      ).paddingSymmetric(vertical: 5),
    );
  }
}
