import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view/snackbars/snackbars.dart';
import '../unit_settings_model.dart';

part 'unit_settings_event.dart';
part 'unit_settings_state.dart';

class UnitSettingsBloc extends Bloc<UnitSettingsEvent, UnitSettingsState> {
  UnitSettingsBloc({required UnitSettings unitSettings})
      : super(UnitSettingsState(unitSettings: unitSettings)) {
    on<TempUnitUpdated>((event, emit) {
      final updatedSettings = state.unitSettings
          .copyWith(tempUnitsMetric: !state.unitSettings.tempUnitsMetric);

      emit(state.copyWith(unitSettings: updatedSettings));
      Snackbars.tempUnitsUpdateSnackbar(
        tempUnitsMetric: state.unitSettings.tempUnitsMetric,
      );
    });

    on<TimeIn24HoursUpdated>((event, emit) {
      final updatedSettings = state.unitSettings
          .copyWith(timeIn24Hrs: !state.unitSettings.timeIn24Hrs);

      emit(state.copyWith(unitSettings: updatedSettings));

      Snackbars.timeUnitsUpdateSnackbar(
        timeIn24hrs: state.unitSettings.timeIn24Hrs,
      );
    });

    on<PrecipInMmUpdated>((event, emit) {
      final updatedSettings = state.unitSettings
          .copyWith(precipInMm: !state.unitSettings.precipInMm);

      emit(state.copyWith(unitSettings: updatedSettings));

      Snackbars.precipitationUnitsUpdateSnackbar(
        precipInMm: state.unitSettings.precipInMm,
      );
    });

    on<SpeedInKphUpdated>((event, emit) {
      final updatedSettings = state.unitSettings
          .copyWith(speedInKph: !state.unitSettings.speedInKph);

      emit(state.copyWith(unitSettings: updatedSettings));
      
      Snackbars.windSpeedUnitsUpdateSnackbar(
        speedInKph: state.unitSettings.speedInKph,
      );
    });
  }
}
