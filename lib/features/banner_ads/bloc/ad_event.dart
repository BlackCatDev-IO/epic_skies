part of 'ad_bloc.dart';

abstract class AdEvent {}

class AdStartupCheck extends AdEvent {}

class AdEndTrialPeriod extends AdEvent {}

class AdPurchaseNoAds extends AdEvent {}
