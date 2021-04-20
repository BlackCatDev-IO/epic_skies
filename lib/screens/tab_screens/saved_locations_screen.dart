import 'package:epic_skies/global/alert_dialogs/search_dialogs.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SavedLocationScreen extends GetView<SearchController> {
  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.21),
        RoundedContainer(
          width: 150,
          height: 30,
          radius: 25,
          color: Colors.white12,
          child: const MyTextWidget(
                  text: 'Saved Locations', fontSize: 18, color: Colors.black)
              .center()
              .paddingOnly(bottom: 2),
        ).paddingSymmetric(vertical: 5),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.searchHistory.length,
            itemBuilder: (context, index) {
              return SearchListTile(
                  suggestion:
                      controller.searchHistory[index] as SearchSuggestion);
            },
          ).paddingSymmetric(vertical: 2).expanded(),
        ),
        DefaultButton(
          buttonColor: kBlackCustom,
          label: 'Clear Search History',
          onPressed: () => confirmClearSearchHistory(context: context),
          fontSize: 20,
          fontColor: Colors.white60,
        ).paddingSymmetric(vertical: 10)
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}
