import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'unit_settings_model.dart';

class UnitSettingsController extends GetxController {
  UnitSettingsController({
    required this.storage,
    required this.weatherRepo,
  });

  static UnitSettingsController get to => Get.find();

  final StorageController storage;

  final WeatherRepository weatherRepo;

  Color selectedBorderColor = Colors.yellow;
  Color unSelectedBorderColor = Colors.white12;

  late UnitSettings settings;

  @override
  Future<void> onInit() async {
    super.onInit();
    settings = storage.savedUnitSettings();
  }

  Future<void> updateTempUnits() async {
    settings.tempUnitsMetric = !settings.tempUnitsMetric;

    storage.storeUnitSettings(settings: settings);

    _updateUI();

    update();
    Snackbars.tempUnitsUpdateSnackbar(
      tempUnitsMetric: settings.tempUnitsMetric,
    );
  }

  void updateTimeFormat() {
    settings.timeIn24Hrs = !settings.timeIn24Hrs;
    storage.storeUnitSettings(settings: settings);

    _rebuildForecastWidgets();
    update();
    Snackbars.timeUnitsUpdateSnackbar(timeIn24hrs: settings.timeIn24Hrs);
  }

  Future<void> updatePrecipUnits() async {
    settings.precipInMm = !settings.precipInMm;

    storage.storeUnitSettings(settings: settings);

    _rebuildForecastWidgets();
    update();
    Snackbars.precipitationUnitsUpdateSnackbar(precipInMm: settings.precipInMm);
  }

  Future<void> updateSpeedUnits() async {
    settings.speedInKph = !settings.speedInKph;
    storage.storeUnitSettings(settings: settings);

    _rebuildForecastWidgets();

    update();
    Snackbars.windSpeedUnitsUpdateSnackbar(speedInKph: settings.speedInKph);
  }

  Future<void> _rebuildForecastWidgets() async {
    weatherRepo.updateModelUnitSettings(settings: settings);

    SunTimeController.to
        .initSunTimeList(weatherModel: weatherRepo.weatherModel!);

    if (!weatherRepo.isLoading.value) {
      await weatherRepo.updateUIValues();
    }
  }

  Future<void> _updateUI() async {
    weatherRepo.updateModelUnitSettings(settings: settings);
    if (!weatherRepo.isLoading.value) {
      await weatherRepo.updateUIValues();
    }
  }
}
