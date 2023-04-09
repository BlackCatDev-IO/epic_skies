part of 'ad_bloc.dart';

enum AdFreeStatus { showAds, adFreePurchased, trialPeriod, trialEnded, error }

extension AdStateX on AdFreeStatus {
  bool get isShowAds => this == AdFreeStatus.showAds;
  bool get isAdFreePurchased => this == AdFreeStatus.adFreePurchased;
  bool get isTrialPeriod => this == AdFreeStatus.trialPeriod;
  bool get isTrialEnded => this == AdFreeStatus.trialEnded;
  bool get isError => this == AdFreeStatus.error;
}

@freezed
class AdState with _$AdState {
  factory AdState({
    @Default(AdFreeStatus.showAds) AdFreeStatus status,
    @Default('') String errorMessage,
    @Default(true) bool isFirstInstall,
    DateTime? appInstallDate,
  }) = _AdState;

  factory AdState.fromJson(Map<String, dynamic> json) =>
      _$AdStateFromJson(json);
}
