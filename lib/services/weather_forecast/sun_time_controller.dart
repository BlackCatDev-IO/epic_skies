import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:get/get.dart';

class SunTimeController extends GetxController {
  static SunTimeController get to => Get.find();

  List<SunTimesModel> sunTimeList = [];

  bool sunTimesAheadOfCurrentTime = false;
  bool sunTimesBehindCurrentTime = false;

  @override
  void onInit() {
    super.onInit();
    final firstTimeUse = StorageController.to.firstTimeUse();
    if (!firstTimeUse) {
      _initListFromStorage();
    }
  }

  Future<void> initSunTimeList() async {
    final data = StorageController.to.dataMap;
    final storageList = <Map<String, dynamic>>[];
    sunTimeList.clear();

    _checkForMismatchedSuntimes();

    int startIndex = 0;

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that

    if (TimeZoneController.to.isBetweenMidnightAnd6Am()) {
      startIndex++;
    }

    for (int i = startIndex; i <= 14; i++) {
      final _valuesMap = data['timelines'][1]['intervals'][i]['values'] as Map;

      late SunTimesModel sunTime;

      final sunrise = _valuesMap['sunriseTime'] as String;
      final sunset = _valuesMap['sunsetTime'] as String;

      sunTime = _initSunTimesModel(sunrise: sunrise, sunset: sunset);

      /// Tomorrow.io has a glitch that sometimes returns sun times that
      /// are a day behind or ahead the current times. TimezoneController checks for this
      /// and sets mismatchedDaysOnSunTimeResponse to true if that is the case
      if (sunTimesBehindCurrentTime) {
        sunTime = _correctedSunTimeResponse(isAhead: false, model: sunTime);
      }
      if (sunTimesAheadOfCurrentTime) {
        sunTime = _correctedSunTimeResponse(isAhead: true, model: sunTime);
      }

      sunTimeList.add(sunTime);
      storageList.add(sunTime.toMap());
    }

    /// This is a bit of a hack solution that accounts for when the app has to
    /// bump up the start index for when the remote time is between midnight and
    /// 6am. Sometimes the Tomorrow.io response will have 16 total days,
    /// sometimes it will only have 15. To prevent a range error when populating
    /// the next 14 days of daily forecast widgets, this just copies the sun
    /// times of the 13th day to the 14th day. The sunTimeList always needs to
    /// have at least 15 items. The only scenario where this would actually
    /// happen is if a user was searching the weather of somewhere else in the
    /// world where the local time happens to be between midnight and 6am. Even
    /// then the only not fully accurate data would be the sun times for the
    /// 14th day may be a couple minutes off

    if (sunTimeList.length == 14) {
      sunTimeList.add(sunTimeList[13]);
      storageList.add(sunTimeList[13].toMap());
    }

    /// resetting these before the next search
    sunTimesAheadOfCurrentTime = false;
    sunTimesBehindCurrentTime = false;
    StorageController.to.storeSunTimeList(sunTimes: storageList);
  }

  SunTimesModel _correctedSunTimeResponse({
    required bool isAhead,
    required SunTimesModel model,
  }) {
    final correctedSunTime = model;

    if (isAhead) {
      correctedSunTime.sunriseTime =
          correctedSunTime.sunriseTime!.subtract(const Duration(days: 1));
      correctedSunTime.sunsetTime =
          correctedSunTime.sunsetTime!.subtract(const Duration(days: 1));
    } else {
      correctedSunTime.sunriseTime =
          correctedSunTime.sunriseTime!.add(const Duration(days: 1));
      correctedSunTime.sunsetTime =
          correctedSunTime.sunsetTime!.add(const Duration(days: 1));
    }

    correctedSunTime.sunriseString =
        DateTimeFormatter.formatFullTime(time: correctedSunTime.sunriseTime!);
    correctedSunTime.sunriseString =
        DateTimeFormatter.formatFullTime(time: correctedSunTime.sunriseTime!);

    return correctedSunTime;
  }

  SunTimesModel _initSunTimesModel({
    required String sunrise,
    required String sunset,
  }) {
    final sunriseTime = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: sunrise);
    final sunsetTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(time: sunset);

    final sunriseString = DateTimeFormatter.formatFullTime(time: sunriseTime);
    final sunsetString = DateTimeFormatter.formatFullTime(time: sunsetTime);

    return SunTimesModel(
      sunriseString: sunriseString,
      sunsetString: sunsetString,
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
    );
  }

  void _checkForMismatchedSuntimes() {
    final data = StorageController.to.dataMap;

    final startTimeString =
        data['timelines'][1]['intervals'][0]['startTime'] as String;

    final startTime = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: startTimeString);

    final sunriseString =
        data['timelines'][1]['intervals'][0]['values']['sunriseTime'] as String;

    final sunriseTime = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: sunriseString);

    /// Tomorrow.io has a glitch that sometimes returns sun times that
    /// are a day behind or ahead of the current times. This checks for that
    /// and loops through and bump all the days up or down in the list
    if (sunriseTime.day == (startTime.day - 1)) {
      sunTimesBehindCurrentTime = true;
    }

    if (sunriseTime.day == (startTime.day + 1)) {
      sunTimesAheadOfCurrentTime = true;
    }
  }

  void _initListFromStorage() {
    final listFromStorage = StorageController.to.restoreSunTimeList();

    for (final map in listFromStorage) {
      final sunTime = SunTimesModel.fromMap(map as Map<String, dynamic>);
      sunTimeList.add(sunTime);
    }
  }
}
