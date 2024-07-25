import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'unit_settings_event.dart';

class UnitSettingsBloc extends Bloc<UnitSettingsEvent, UnitSettings> {
  UnitSettingsBloc({
    required UnitSettings unitSettings,
  }) : super(unitSettings) {
    on<TempUnitUpdated>((event, emit) {
      final updatedSettings =
          state.copyWith(tempUnitsMetric: !state.tempUnitsMetric);

      emit(updatedSettings);
    });

    on<TimeIn24HoursUpdated>((event, emit) {
      final updatedSettings = state.copyWith(timeIn24Hrs: !state.timeIn24Hrs);

      emit(updatedSettings);
    });

    on<PrecipInMmUpdated>((event, emit) {
      final updatedSettings = state.copyWith(precipInMm: !state.precipInMm);

      emit(updatedSettings);
    });

    on<SpeedInKphUpdated>((event, emit) {
      final updatedSettings = state.copyWith(speedInKph: !state.speedInKph);

      emit(updatedSettings);
    });
  }
}
