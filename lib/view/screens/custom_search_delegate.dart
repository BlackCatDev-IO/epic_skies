import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/location/location_controller.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/widgets/general/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/rounded_label.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
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
              const SearchField(),
              Column(
                children: [
                  const SearchLocalWeatherButton(),
                  Obx(
                    () => controller.query.value == ''
                        ? const SearchHistory()
                        : const SuggestionList(),
                  )
                ],
              ).paddingSymmetric(horizontal: 10).expanded(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchHistory extends GetView<LocationController> {
  const SearchHistory();
  @override
  Widget build(BuildContext context) {
    final isEmpty = controller.searchHistory.isEmpty;

    return ListView(
      children: [
        if (isEmpty)
          const SizedBox()
        else
          GetBuilder<ViewController>(
              builder: (viewController) => RoundedLabel(
                      label: 'Recent Searches',
                      labelColor: viewController.theme.roundedLabelColor)
                  .center()),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.searchHistory.length,
            itemBuilder: (context, index) {
              return SearchListTile(
                  suggestion:
                      controller.searchHistory[index] as SearchSuggestion,
                  searching: false);
            },
          ),
        ).paddingSymmetric(vertical: 2.5),
      ],
    ).expanded();
  }
}

class SuggestionList extends GetView<LocationController> {
  const SuggestionList();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.currentSearchList.isEmpty
          ? const MyTextWidget(text: 'Loading...').center()
          : ListView.builder(
              itemCount: controller.currentSearchList.length,
              itemBuilder: (context, index) =>
                  controller.currentSearchList[index] as Widget).expanded(),
    );
  }
}

class SearchField extends GetView<SearchController> {
  const SearchField();
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
