import 'package:black_cat_lib/widgets/buttons.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DeleteSavedLocationsButton extends GetView<RemoteLocationController> {
  const DeleteSavedLocationsButton();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) => Obx(
        () => controller.searchHistory.isEmpty
            ? const SizedBox()
            : DefaultButton(
                buttonColor: colorController.theme.soloCardColor,
                label: 'Delete Search History',
                onPressed: SearchDialogs.confirmClearSearchHistory,
                fontSize: 14.sp,
                fontColor: Colors.white70,
              ),
      ),
    );
  }
}
