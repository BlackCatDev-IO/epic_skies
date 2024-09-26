import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model/local_weather_button_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocalWeatherButtonCubit extends HydratedCubit<LocalWeatherButtonModel> {
  LocalWeatherButtonCubit() : super(const LocalWeatherButtonModel());

  void updateSearchLocalWeatherButton({
    required CurrentWeatherModel weatherState,
    required bool isDay,
  }) {
    final searchButtonModel = LocalWeatherButtonModel.fromCurrentWeather(
      currentWeatherModel: weatherState,
      isDay: isDay,
    );

    emit(searchButtonModel);
  }

  void updateLocalWeatherButtonUnitSettings({
    required bool tempUnitsMetric,
  }) {
    var updatedTemp = 0;

    if (tempUnitsMetric) {
      updatedTemp = UnitConverter.toCelcius(state.temp);
    } else {
      updatedTemp = UnitConverter.toFahrenheight(state.temp);
    }

    emit(state.copyWith(temp: updatedTemp));
  }

  @override
  void onChange(Change<LocalWeatherButtonModel> change) {
    super.onChange(change);
    AppDebug.log(
      '${change.nextState}',
      name: 'LocalWeatherButtonCubit',
    );
  }

  @override
  LocalWeatherButtonModel? fromJson(Map<String, dynamic> json) {
    return LocalWeatherButtonModel.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LocalWeatherButtonModel state) {
    return state.toMap();
  }
}
