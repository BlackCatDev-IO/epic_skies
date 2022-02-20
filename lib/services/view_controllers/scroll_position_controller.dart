import 'dart:developer';

import 'package:epic_skies/features/daily_forecast/controllers/daily_forecast_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollPositionController extends GetxController {
  static ScrollPositionController get to => Get.find();

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int selectedDayIndex = 0;
  int currentIndex = 0;

  /// prevents scrollAfterFirstBuild from running if user didn't navigate
  /// to Daily tab from Home tab
  bool navigateToDailyTabFromHome = false;

  @override
  void onInit() {
    super.onInit();
    itemPositionsListener.itemPositions.addListener(() {
      final itemLeadingEdge =
          itemPositionsListener.itemPositions.value.first.itemLeadingEdge;

      final listenerIndex =
          itemPositionsListener.itemPositions.value.first.index;

      /// Prevents this from getting called hundreds of times
      /// as user scrolls
      if (itemLeadingEdge != 0.0 && listenerIndex != selectedDayIndex) {
        _updateSelectedDailyNavButtonOnScroll(itemLeadingEdge);
      }
    });
  }

  /// Call only once after Daily tab is built the first time. And only called
  /// if user has navigated to Daily tab from the home tab right after app start
  /// Without this, if the user navigates to the Daily tab right after
  /// restarting before the Daily tab has been built, scrollToIndex
  /// won't work because it will have had nothing to attach to
  /// This will not run if user jumps to Daily tab from TabBar the first time
  void scrollAfterFirstBuild() {
    log('scroll after first build selectedIndex: $selectedDayIndex');
    scrollToIndex(index: selectedDayIndex);
  }

  Future<void> scrollToIndex({required int index}) async {
    selectedDayIndex = index;

    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(
        index: selectedDayIndex,
      );
    }

    currentIndex = selectedDayIndex;
  }

  Future<void> jumpToDayFromHomeScreen({required int index}) async {
    navigateToDailyTabFromHome = true;
    selectedDayIndex = index;
    scrollToIndex(index: selectedDayIndex);
    DailyForecastController.to
        .updateSelectedDayStatus(newIndex: selectedDayIndex);

    TabNavigationController.to.jumpToTab(index: 2);
  }

  void _updateSelectedDailyNavButtonOnScroll(double itemLeadingEdge) {
    final listenerIndex = itemPositionsListener.itemPositions.value.first.index;

    if (listenerIndex != selectedDayIndex && itemLeadingEdge != 0.0) {
      DailyForecastController.to.updateSelectedDayStatus(
        newIndex: listenerIndex,
      );
    }
  }
}
