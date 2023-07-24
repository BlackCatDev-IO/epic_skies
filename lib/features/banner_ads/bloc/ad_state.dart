// ignore_for_file: invalid_annotation_target

part of 'ad_bloc.dart';

enum AdFreeStatus {
  initial,
  loading,
  showAds,
  adFreePurchased,
  trialPeriod,
  trialEnded,
  error
}

extension AdStateX on AdFreeStatus {
  bool get isInitial => this == AdFreeStatus.initial;
  bool get isLoading => this == AdFreeStatus.loading;
  bool get isShowAds => this == AdFreeStatus.showAds;
  bool get isAdFreePurchased => this == AdFreeStatus.adFreePurchased;
  bool get isTrialPeriod => this == AdFreeStatus.trialPeriod;
  bool get isTrialEnded => this == AdFreeStatus.trialEnded;
  bool get isError => this == AdFreeStatus.error;
}

@freezed
class AdState with _$AdState {
  factory AdState({
    @Default(AdFreeStatus.initial) AdFreeStatus status,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String errorMessage,
    DateTime? appInstallDate,
  }) = _AdState;

  factory AdState.fromJson(Map<String, dynamic> json) =>
      _$AdStateFromJson(json);
}
