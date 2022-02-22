import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'unit_settings_model.dart';

class UnitSettingsController extends GetxController {
  UnitSettingsController({
    required this.weatherRepo,
  });

  static UnitSettingsController get to => Get.find();

  final WeatherRepository weatherRepo;

  final selectedBorderColor = Colors.yellow;
  final unSelectedBorderColor = Colors.white12;

  late UnitSettings settings;

  @override
  void onInit() {
    super.onInit();
    settings = weatherRepo.storage.savedUnitSettings();
  }

  void updateTempUnits() {
    settings.tempUnitsMetric = !settings.tempUnitsMetric;

    weatherRepo.storage.updateUnitSettings(settings: settings);

    _updateUI();

    update();
    Snackbars.tempUnitsUpdateSnackbar(
      tempUnitsMetric: settings.tempUnitsMetric,
    );
  }

  void updateTimeFormat() {
    settings.timeIn24Hrs = !settings.timeIn24Hrs;
    weatherRepo.storage.updateUnitSettings(settings: settings);

    _rebuildForecastWidgets();
    update();
    Snackbars.timeUnitsUpdateSnackbar(timeIn24hrs: settings.timeIn24Hrs);
  }

  void updatePrecipUnits() {
    settings.precipInMm = !settings.precipInMm;

    weatherRepo.storage.updateUnitSettings(settings: settings);

    _rebuildForecastWidgets();
    update();
    Snackbars.precipitationUnitsUpdateSnackbar(precipInMm: settings.precipInMm);
  }

  void updateSpeedUnits() {
    settings.speedInKph = !settings.speedInKph;
    weatherRepo.storage.updateUnitSettings(settings: settings);

    _rebuildForecastWidgets();

    update();
    Snackbars.windSpeedUnitsUpdateSnackbar(speedInKph: settings.speedInKph);
  }

  void _rebuildForecastWidgets() {
    weatherRepo.updateModelUnitSettings(settings: settings);

    SunTimeController.to
        .initSunTimeList(weatherModel: weatherRepo.weatherModel!);

    if (!weatherRepo.isLoading.value) {
      weatherRepo.updateUIValues(isRefresh: false);
    }
  }

  void _updateUI() {
    weatherRepo.updateModelUnitSettings(settings: settings);
    if (!weatherRepo.isLoading.value) {
      weatherRepo.updateUIValues(isRefresh: false);
    }
  }
}
