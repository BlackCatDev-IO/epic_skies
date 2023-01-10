import 'dart:async';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc({required StorageController storage})
      : _storage = storage,
        super(AdInitial()) {
    on<AdStartupCheck>(_onAdStartupCheck);
    on<AdEndTrialPeriod>(_onAdEndTrialPeriod);
    on<AdPurchaseNoAds>(_onAdPurchaseNoAds);
  }

  final StorageController _storage;

  static const _trialPeriodDays = 7;

  Future<void> _onAdStartupCheck(
    AdStartupCheck event,
    Emitter<AdState> emit,
  ) async {
    final installDate = _storage.appInstallDate();

    if (installDate != null) {
      final daysSinceInstall = DateTime.now().toUtc().difference(installDate);

      final trialPeriodExpired = daysSinceInstall.inDays > _trialPeriodDays;

      if (trialPeriodExpired) {
        emit(ShowAds());
      }
    }
  }

  Future<void> _onAdEndTrialPeriod(
    AdEndTrialPeriod event,
    Emitter<AdState> emit,
  ) async {}

  Future<void> _onAdPurchaseNoAds(
    AdPurchaseNoAds event,
    Emitter<AdState> emit,
  ) async {}
}
