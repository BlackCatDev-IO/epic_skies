part of 'ad_bloc.dart';

abstract class AdState extends Equatable {
  const AdState();

  @override
  List<Object> get props => [];
}

class AdInitial extends AdState {}

class ShowAds extends AdState {}

class AdFreePurchased extends AdState {}

class AdTrialPeriod extends AdState {}

class AdPurchasePending extends AdState {}

class AdPurchaseCanceled extends AdState {}

class AdPurchaseError extends AdState {
  const AdPurchaseError({required this.message});

  final String message;
}
