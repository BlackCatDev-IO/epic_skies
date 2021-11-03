import 'package:epic_skies/services/weather_forecast/daily_forecast_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

void main() {
  final controller = Get.put(DailyForecastController());

  group('test selected day', () {
    test('0', () {
      controller.updateSelectedDayStatus(index: 0);
      expect(controller.selectedDayList[0], true);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[5], false);
      expect(controller.selectedDayList[6], false);
    });
    test('1', () {
      controller.updateSelectedDayStatus(index: 1);
      expect(controller.selectedDayList[1], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[5], false);
      expect(controller.selectedDayList[6], false);
    });
    test('2', () {
      controller.updateSelectedDayStatus(index: 2);
      expect(controller.selectedDayList[2], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[5], false);
      expect(controller.selectedDayList[6], false);
    });
    test('3', () {
      controller.updateSelectedDayStatus(index: 3);
      expect(controller.selectedDayList[3], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[5], false);
      expect(controller.selectedDayList[6], false);
    });
    test('4', () {
      controller.updateSelectedDayStatus(index: 4);
      expect(controller.selectedDayList[4], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[5], false);
      expect(controller.selectedDayList[6], false);
    });
    test('5', () {
      controller.updateSelectedDayStatus(index: 5);
      expect(controller.selectedDayList[5], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[6], false);
    });
    test('6', () {
      controller.updateSelectedDayStatus(index: 6);
      expect(controller.selectedDayList[6], true);
      expect(controller.selectedDayList[0], false);
      expect(controller.selectedDayList[1], false);
      expect(controller.selectedDayList[2], false);
      expect(controller.selectedDayList[3], false);
      expect(controller.selectedDayList[4], false);
      expect(controller.selectedDayList[5], false);
    });
  });
}
