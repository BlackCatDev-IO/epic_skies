import 'package:epic_skies/services/location/remote_location_controller.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'rounded_label.dart';

class RecentSearchesLabel extends GetView<RemoteLocationController> {
  final bool isSearchPage;
  const RecentSearchesLabel({required this.isSearchPage});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      late bool showLabel;
      if (isSearchPage) {
        showLabel = controller.searchHistory.isEmpty &&
            SearchController.to.query.value == '';
      } else {
        showLabel = controller.searchHistory.isEmpty;
      }
      return showLabel
          ? RoundedLabel(
              label: 'No recent searches',
              fontWeight: FontWeight.w400,
              width: 160,
              fontSize: 10.sp,
            ).paddingOnly(top: 10)
          : const SizedBox();
    });
  }
}
