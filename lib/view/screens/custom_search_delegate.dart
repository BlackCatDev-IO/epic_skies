import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomSearchDelegate extends GetView<SearchController> {
  static const id = '/custom_search_delegate';
  const CustomSearchDelegate();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WeatherImageContainer(
          child: Column(
            children: [
              const _SearchField(),
              const SearchLocalWeatherButton(isSearchPage: true),
              const RecentSearchesLabel(isSearchPage: true),
              Column(
                children: [
                  Obx(
                    () => controller.query.value == ''
                        ? const _SearchHistory()
                        : const _SuggestionList(),
                  ),
                  const DeleteSavedLocationsButton()
                ],
              ).paddingSymmetric(horizontal: 5).expanded(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchHistory extends GetView<RemoteLocationController> {
  const _SearchHistory();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.searchHistory.length,
        itemBuilder: (context, index) {
          return SearchListTile(
            suggestion: controller.searchHistory[index] as SearchSuggestion,
            searching: false,
          );
        },
      ),
    ).paddingOnly(top: 2.5).expanded();
  }
}

class _SuggestionList extends GetView<RemoteLocationController> {
  const _SuggestionList();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.currentSearchList.isEmpty
          ? const MyTextWidget(text: 'Loading...').center()
          : ListView.builder(
              itemCount: controller.currentSearchList.length,
              itemBuilder: (context, index) =>
                  controller.currentSearchList[index] as Widget,
            ).expanded(),
    );
  }
}

class _SearchField extends GetView<SearchController> {
  const _SearchField();
  @override
  Widget build(BuildContext context) {
    return Container(
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
            autofocus: true,
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
