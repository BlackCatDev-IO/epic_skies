import 'package:epic_skies/services/weather_forecast/daily_forecast_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'view_controller.dart';

class ScrollPositionController extends GetxController {
  static ScrollPositionController get to => Get.find();

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  int selectedDayIndex = 0;
  int updatedDayIndex = 0;

  /// prevents scrollAfterFirstBuild from running if user didn't navigate
  /// to Daily tab from Home tab
  bool navigateToDailyTabFromHome = false;

  @override
  void onInit() {
    super.onInit();
    itemPositionsListener.itemPositions.addListener(() {
      _updateSelectedDailyNavButtonOnScroll();
    });
  }

  /// Call only once after Daily tab is built the first time. And only called
  /// if user has navigated to Daily tab from the home tab right after app start
  /// Without this, if the user navigates to the Daily tab right after
  /// restarting before the Daily tab has been built, scrollToIndex
  /// won't work because it will have had nothing to attach to
  /// This will not run if user jumps to Daily tab from TabBar the first time
  void scrollAfterFirstBuild() {
    scrollToIndex(index: selectedDayIndex);
  }

  void scrollToIndex({required int index}) {
    selectedDayIndex = index;

    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(
        index: selectedDayIndex,
      );
    }
  }

  Future<void> jumpToDayFromHomeScreen({required int index}) async {
    navigateToDailyTabFromHome = true;
    selectedDayIndex = index;
    await NavigationController.to.jumpToTab(index: 2);
    scrollToIndex(index: selectedDayIndex);
    DailyForecastController.to.updateSelectedDayStatus(index: selectedDayIndex);
  }

  void _updateSelectedDailyNavButtonOnScroll() {
    final currentIndex = itemPositionsListener.itemPositions.value.first.index;
    if (currentIndex != selectedDayIndex) {
      DailyForecastController.to.updateSelectedDayStatus(index: currentIndex);
    }
    selectedDayIndex = currentIndex;
  }
}
