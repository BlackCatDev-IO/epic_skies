part of 'ad_bloc.dart';

abstract class AdEvent {}

class AdInitPurchaseListener extends AdEvent {}

class AdFreePurchaseRequest extends AdEvent {}
