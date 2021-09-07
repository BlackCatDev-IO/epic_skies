import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SunTimeController extends GetxController {
  static SunTimeController get to => Get.find();

  List<SunTimesModel> sunTimeList = [];

  @override
  void onInit() {
    super.onInit();
    final firstTimeUse = StorageController.to.firstTimeUse();
    if (!firstTimeUse) {
      _initListFromStorage();
    }
  }

  void initSunTimeList() {
    final data = StorageController.to.dataMap;
    final storageList = <Map<String, dynamic>>[];
    sunTimeList.clear();

    int startIndex = 0;
    int endIndex = 14;
    final currentTimeBetweenMidnightAnd6am =
        DateTime.now().hour.isInRange(0, 6);

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that
    if (currentTimeBetweenMidnightAnd6am) {
      startIndex++;
      endIndex++;
    }

    for (int i = startIndex; i < endIndex; i++) {
      final _valuesMap = data['timelines'][1]['intervals'][i]['values'] as Map;

      late SunTimesModel sunTime;

      final sunrise = _valuesMap['sunriseTime'] as String;
      final sunset = _valuesMap['sunsetTime'] as String;

      sunTime = TimeZoneController.to
          .parseSunriseAndSunsetTimes(sunrise: sunrise, sunset: sunset);

      sunTimeList.add(sunTime);
      storageList.add(sunTime.toMap());
    }
    StorageController.to.storeSunTimeList(sunTimes: storageList);
  }

  void _initListFromStorage() {
    final listFromStorage = StorageController.to.restoreSunTimeList();

    for (final map in listFromStorage) {
      final sunTime = SunTimesModel.fromMap(map as Map<String, dynamic>);
      sunTimeList.add(sunTime);
    }
  }
}
