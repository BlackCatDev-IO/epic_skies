import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/utils/storage_getters/layout.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

class SavedLocationScreen extends GetView<LocationController> {
  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Layout.savedLocationScreenPadding),
        const SearchLocalWeatherButton(isSearchPage: false),
        const RecentSearchesLabel(isSearchPage: false),
        const SearchHistoryListView(),
        const DeleteSavedLocationsButton(),
        if (IphoneHasNotch.hasNotch)
          const SizedBox(height: 30)
        else
          sizedBox10High,
      ],
    );
  }
}

class SearchHistoryListView extends GetView<RemoteLocationController> {
  const SearchHistoryListView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: controller.searchHistory.length,
        itemBuilder: (context, index) {
          return SearchListTile(
            suggestion: controller.searchHistory[index] as SearchSuggestion,
            searching: false,
          );
        },
      ).paddingSymmetric(vertical: 2, horizontal: 5).expanded(),
    );
  }
}
