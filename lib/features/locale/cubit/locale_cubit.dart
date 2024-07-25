import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends HydratedCubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  void setDeviceLocale(Locale locale) {
    final imperialCountries = ['us', 'lr', 'mm'];
    final countryOnImperial = imperialCountries.contains(
      locale.countryCode?.toLowerCase(),
    );

    emit(
      state.copyWith(
        deviceLocale: locale,
        userSetLocale: state.userSetLocale ?? locale,
        countryUnitSettings: countryOnImperial
            ? CountryUnitSettings.imperial
            : CountryUnitSettings.metric,
      ),
    );
  }

  void setPreferredLocale(Locale locale) {
    emit(state.copyWith(userSetLocale: locale));
  }

  @override
  LocaleState fromJson(Map<String, dynamic> json) {
    return LocaleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LocaleState state) {
    return state.toMap();
  }
}
