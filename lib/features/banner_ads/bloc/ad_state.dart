part of 'ad_bloc.dart';

@MappableEnum()
enum AdFreeStatus {
  initial,
  loading,
  showAds,
  adFreePurchased,
  adFreeRestored,
  trialPeriod,
  trialEnded,
  error
}

extension AdStateX on AdFreeStatus {
  bool get isInitial => this == AdFreeStatus.initial;
  bool get isLoading => this == AdFreeStatus.loading;
  bool get isShowAds => this == AdFreeStatus.showAds;
  bool get isAdFreePurchased => this == AdFreeStatus.adFreePurchased;
  bool get isAdFreeRestored => this == AdFreeStatus.adFreeRestored;
  bool get isTrialPeriod => this == AdFreeStatus.trialPeriod;
  bool get isTrialEnded => this == AdFreeStatus.trialEnded;
  bool get isError => this == AdFreeStatus.error;
}

@MappableClass()
class AdState with AdStateMappable {
  AdState({
    this.status = AdFreeStatus.initial,
    this.errorMessage = '',
    this.appInstallDate,
  });

  final AdFreeStatus status;
  final String errorMessage;
  final DateTime? appInstallDate;

  static const fromMap = AdStateMapper.fromMap;
}
