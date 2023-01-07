import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/general/text_scale_factor_clamper.dart';
import 'tab_screens/saved_locations_screen.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen();

  static const id = '/search_screen';
  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: SafeArea(
        child: Scaffold(
          body: WeatherImageContainer(
            child: Stack(
              children: [
                Column(
                  children: [
                    const _SearchField(),
                    const SearchLocalWeatherButton(
                      isSearchPage: true,
                    ),
                    const RecentSearchesLabel(isSearchPage: true),
                    Column(
                      children: [
                        Obx(
                          () => controller.query.value == ''
                              ? const SearchHistoryListView()
                              : const _SuggestionList(),
                        ),
                        const DeleteSavedLocationsButton(),
                      ],
                    ).paddingSymmetric(horizontal: 5).expanded(),
                  ],
                ),
                const LoadingIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends GetView<RemoteLocationController> {
  const _SuggestionList();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.currentSearchList.isEmpty ||
              SearchController.to.noResults.value
          ? RoundedLabel(label: SearchController.to.status.value)
              .center()
              .paddingSymmetric(vertical: 3.sp)
          : ListView.builder(
              itemCount: controller.currentSearchList.length,
              itemBuilder: (context, index) => SearchListTile(
                searching: true,
                suggestion: controller.currentSearchList[index],
              ),
            ).expanded(),
    );
  }
}

class _SearchField extends GetView<SearchController> {
  const _SearchField();
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black87,
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            color: Colors.white70,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.delete<SearchController>();
              Get.back();
            },
          ),
          DefaultTextField(
            controller: controller.textController,
            hintText: 'Search',
            textColor: Colors.white60,
            borderRadius: 0,
            borderColor: Colors.transparent,
            hintSize: 14.sp,
            autoFocus: true,
            onFieldSubmitted: (_) => SearchDialogs.selectSearchFromListDialog(),
          ).expanded(),
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear, color: Colors.white70),
            onPressed: () {
              controller.textController.text = '';
            },
          ),
        ],
      ),
    );
  }
}
