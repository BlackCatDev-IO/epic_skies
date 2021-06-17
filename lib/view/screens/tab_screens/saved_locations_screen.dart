import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/general/rounded_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SavedLocationScreen extends GetView<LocationController> {
  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ViewController.to.appBarPadding),
        const RoundedLabel(
          label: 'Saved Locations',
        ),
        const SearchHistoryListView(),
        const DeleteSavedLocationsButton(),
        if (ViewController.to.iPhoneHasNotch)
          const SizedBox(height: 30)
        else
          sizedBox10High,
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}

class SearchHistoryListView extends GetView<LocationController> {
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
              searching: false);
        },
      ).paddingSymmetric(vertical: 2).expanded(),
    );
  }
}

class DeleteSavedLocationsButton extends GetView<LocationController> {
  const DeleteSavedLocationsButton();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (viewController) => Obx(
        () => controller.searchHistory.isEmpty
            ? const SizedBox()
            : DefaultButton(
                buttonColor: viewController.soloCardColor,
                label: 'Delete Saved Locations',
                // onPressed: confirmClearSearchHistory,
                onPressed: BgImageController.to.changeBGPic,
                fontSize: 20,
                fontColor: Colors.white70,
              ),
      ),
    );
  }
}
