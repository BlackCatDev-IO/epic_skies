import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:epic_skies/widgets/general/search_local_weather_button.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import 'settings_screens/settings_drawer.dart';

class CustomSearchDelegate extends GetView<SearchController> {
  static const id = 'custom_search_delegate';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WeatherImageContainer(
          child: Column(
            children: [
              _searchField(),
              const SearchLocalWeatherWidget(),
              const Divider(
                thickness: 1.5,
                color: Colors.black87,
              ),
              Column(
                children: [
                  GetX<SearchController>(
                    builder: (controller) {
                      if (controller.query.value == '') {
                        return _searchHistory();
                      } else {
                        return _suggestionList();
                      }
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 10).expanded(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
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

              Get.off(() => const CustomAnimatedDrawer());
            },
          ),
          DefaultTextField(
            controller: controller.textController,
            hintText: 'Search',
            borderRadius: 0,
            borderColor: Colors.transparent,
            hintSize: 21,
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

  Widget _suggestionList() {
    return GetX<LocationController>(
      builder: (controller) {
        if (controller.currentSearchList.isEmpty) {
          return Container(
              child: const MyTextWidget(text: 'Loading...').center());
        } else {
          return ListView.builder(
              itemCount: controller.currentSearchList.length,
              itemBuilder: (context, index) =>
                  controller.currentSearchList[index] as Widget).expanded();
        }
      },
    );
  }

  Widget _searchHistory() {
    return ListView(
      children: [
        const MyTextWidget(text: 'Recent searches')
            .center()
            .paddingOnly(bottom: 10),
        GetX<LocationController>(
          builder: (controller) {
            controller.searchHistory.removeWhere((value) => value == null);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchHistory.length,
              itemBuilder: (context, index) {
                return SearchListTile(
                    suggestion:
                        controller.searchHistory[index] as SearchSuggestion);
              },
            );
          },
        ).paddingSymmetric(vertical: 2, horizontal: 5),
      ],
    ).expanded();
  }
}
