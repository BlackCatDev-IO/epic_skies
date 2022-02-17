import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';

import '../../../models/weather_response_models/weather_data_model.dart';
import '../../../repositories/weather_repository.dart';

class SunTimeController extends GetxController {
  SunTimeController({required this.storage});

  static SunTimeController get to => Get.find();

  final StorageController storage;

  List<SunTimesModel> sunTimeList = [];

  bool sunTimesAheadOfCurrentTime = false;
  bool sunTimesBehindCurrentTime = false;

  @override
  void onInit() {
    super.onInit();
    if (!storage.firstTimeUse()) {
      sunTimeList.addAll(storage.restoreSunTimeList());
    }
  }

  Future<void> initSunTimeList({
    required WeatherResponseModel weatherModel,
  }) async {
    sunTimeList.clear();

    final todayData = weatherModel.timelines[Timelines.daily].intervals[0].data;

    _checkForMismatchedSuntimes(
      today: todayData.startTime.day,
      sunriseDay: todayData.sunriseTime!.day,
    );

    int startIndex = 0;

    final searchIsLocal = storage.restoreSavedSearchIsLocal();

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that

    if (TimeZoneController.to
        .isBetweenMidnightAnd6Am(searchIsLocal: searchIsLocal)) {
      startIndex++;
    }

    for (int i = startIndex; i <= 14; i++) {
      late SunTimesModel sunTime;

      final weatherData =
          weatherModel.timelines[Timelines.daily].intervals[i].data;

      sunTime = SunTimesModel.fromWeatherData(data: weatherData);

      /// Tomorrow.io has a glitch that sometimes returns sun times that
      /// are a day behind or ahead the current times. TimezoneController checks for this
      /// and sets mismatchedDaysOnSunTimeResponse to true if that is the case
      if (sunTimesBehindCurrentTime) {
        sunTime = _correctedSunTimeResponse(
          isAhead: false,
          model: sunTime,
          timeIn24hrs: weatherData.unitSettings.timeIn24Hrs,
        );
      }
      if (sunTimesAheadOfCurrentTime) {
        sunTime = _correctedSunTimeResponse(
          isAhead: true,
          model: sunTime,
          timeIn24hrs: weatherData.unitSettings.timeIn24Hrs,
        );
      }

      sunTimeList.add(sunTime);
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
    ///
    if (sunTimeList.length == 14) {
      sunTimeList.add(sunTimeList[13].clone());
    }

    /// resetting these before the next search
    sunTimesAheadOfCurrentTime = false;
    sunTimesBehindCurrentTime = false;
    storage.storeSunTimeList(sunTimes: sunTimeList);
  }

  SunTimesModel _correctedSunTimeResponse({
    required bool isAhead,
    required SunTimesModel model,
    required bool timeIn24hrs,
  }) {
    late DateTime correctedSunrise;
    late DateTime correctedSunset;

    if (isAhead) {
      correctedSunrise = model.sunriseTime!.subtract(const Duration(days: 1));
      correctedSunset = model.sunsetTime!.subtract(const Duration(days: 1));
    } else {
      correctedSunrise = model.sunriseTime!.add(const Duration(days: 1));
      correctedSunset = model.sunsetTime!.add(const Duration(days: 1));
    }

    return SunTimesModel(
      id: model.id,
      sunriseTime: correctedSunrise,
      sunsetTime: correctedSunset,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: correctedSunrise,
        timeIn24Hrs: timeIn24hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: correctedSunset,
        timeIn24Hrs: timeIn24hrs,
      ),
    );
  }

  void _checkForMismatchedSuntimes({
    required int today,
    required int sunriseDay,
  }) {
    /// Tomorrow.io has a glitch that sometimes returns sun times that
    /// are a day behind or ahead of the current times. This checks for that
    /// and loops through and bump all the days up or down in the list
    ///

    if (sunriseDay == (today - 1)) {
      sunTimesBehindCurrentTime = true;
    }

    if (sunriseDay == (today + 1)) {
      sunTimesAheadOfCurrentTime = true;
    }
  }

  SunTimesModel referenceSuntime() {
    final todayData = WeatherRepository
        .to.weatherModel!.timelines[Timelines.daily].intervals[0].data;

    return SunTimesModel.fromWeatherData(
      data: todayData,
    );
  }
}
