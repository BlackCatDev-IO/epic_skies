import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SavedLocationScreen extends StatelessWidget {
  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyTextWidget(text: 'Saved Locations')
            .center()
            .paddingOnly(bottom: 10),
        GetX<SearchController>(
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
        ).paddingSymmetric(vertical: 2, horizontal: 5).expanded(),
      ],
    );
  }
}
