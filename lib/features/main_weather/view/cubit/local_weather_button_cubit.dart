import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/search_local_weather_button_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocalWeatherButtonCubit
    extends HydratedCubit<SearchLocalWeatherButtonModel> {
  LocalWeatherButtonCubit() : super(const SearchLocalWeatherButtonModel());

  void updateSearchLocalWeatherButton({required WeatherState weatherState}) {
    if (weatherState.searchIsLocal) {
      final searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
        model: weatherState.weatherModel!,
        unitSettings: weatherState.unitSettings,
        isDay: TimeZoneUtil.getCurrentIsDay(
          searchIsLocal: weatherState.searchIsLocal,
          refSuntimes: weatherState.refererenceSuntimes,
          refTimeEpochInSeconds:
              weatherState.weatherModel!.currentCondition.datetimeEpoch,
        ),
      );

      emit(searchButtonModel);
    }
  }

  void updateSearchLocalWeatherButtonUnitSettings({
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
  SearchLocalWeatherButtonModel? fromJson(Map<String, dynamic> json) {
    return SearchLocalWeatherButtonModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SearchLocalWeatherButtonModel state) {
    return state.toJson();
  }

  @override
  Future<void> close() async {
    AppDebug.log('ButtonCubit closed - hash: $hashCode');
    return super.close();
  }
}
