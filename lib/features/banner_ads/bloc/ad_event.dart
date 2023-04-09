part of 'ad_bloc.dart';

abstract class AdEvent {}

/// Runs on every app start to listen to any purchase activity
class AdInitPurchaseListener extends AdEvent {}

/// Runs when user taps on the `Remove Ads` button from the `Settings Main Page`
class AdFreePurchaseRequest extends AdEvent {}
