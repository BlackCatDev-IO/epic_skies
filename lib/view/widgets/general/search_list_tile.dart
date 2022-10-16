import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/features/location/remote_location/models/search_text.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:sizer/sizer.dart';

import '../../../services/ticker_controllers/tab_navigation_controller.dart';

class SearchListTile extends GetView<TabNavigationController> {
  final SearchSuggestion suggestion;
  final bool searching;

  const SearchListTile({
    required this.suggestion,
    required this.searching,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) => RoundedContainer(
        color: colorController.theme.soloCardColor,
        radius: 7,
        child: ListTile(
          title: !searching
              ? MyTextWidget(text: suggestion.description, fontSize: 11.sp)
              : _SearchTextWidget(searchTextList: suggestion.searchTextList!),
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

class _SearchTextWidget extends StatelessWidget {
  final List<SearchText> searchTextList;
  const _SearchTextWidget({required this.searchTextList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final searchText in searchTextList)
          MyTextWidget(
            text: searchText.text,
            fontWeight: searchText.isBold ? FontWeight.bold : null,
          )
      ],
    );
  }
}
