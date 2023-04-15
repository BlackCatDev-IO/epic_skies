// ignore_for_file: invalid_annotation_target

part of 'ad_bloc.dart';

enum AdFreeStatus {
  initial,
  initializing,
  showAds,
  adFreePurchased,
  trialPeriod,
  trialEnded,
  error
}

extension AdStateX on AdFreeStatus {
  bool get isInitial => this == AdFreeStatus.initial;
  bool get isInitializing => this == AdFreeStatus.initializing;
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
    @JsonKey(ignore: true) @Default('') String errorMessage,
    DateTime? appInstallDate,
  }) = _AdState;

  factory AdState.fromJson(Map<String, dynamic> json) =>
      _$AdStateFromJson(json);
}
