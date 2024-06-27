import 'dart:ui';

import 'package:epic_skies/features/locale/cubit/locale_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocaleCubit extends HydratedCubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  void setDeviceLocale(Locale locale) {
    emit(
      state.copyWith(
        deviceLocale: locale,
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
