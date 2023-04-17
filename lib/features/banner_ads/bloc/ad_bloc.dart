import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/banner_ads/ad_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'ad_bloc.freezed.dart';
part 'ad_bloc.g.dart';
part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends HydratedBloc<AdEvent, AdState> {
  AdBloc({AdRepository? adRepository})
      : _adRepository = adRepository ?? AdRepository(),
        super(AdState()) {
    on<AdInitPurchaseListener>(_onAdInitPurchaseListener);
    on<AdFreePurchaseRequest>(_onAdFreePurchaseRequest);
  }

  static const _trialPeriodDays = 7;

  final AdRepository _adRepository;

  Future<void> _onAdInitPurchaseListener(
    AdInitPurchaseListener event,
    Emitter<AdState> emit,
  ) async {
    if (state.status.isAdFreePurchased) {
      return; // not initializing listener if user has purchased ad free
    }

    if (state.status.isInitial) {
      emit(
        state.copyWith(
          status: AdFreeStatus.trialPeriod,
          appInstallDate: DateTime.now().toUtc(),
        ),
      );
    }

    emit(state.copyWith(status: AdFreeStatus.initializing));

    try {
      await MobileAds.instance.initialize();
    } catch (e) {
      _logAdBlocError('Error initializing Mobile Ads: $e');

      /// Any error at this point is outside of control of this app should not
      /// bother the user, so here it defaults to ad free status
      return emit(state.copyWith(status: AdFreeStatus.adFreePurchased));
    }

    if (!_isTrialPeriod() && state.status.isTrialPeriod) {
      /// Notifying the user that the ad free trial has ended before emitting a
      /// `showAds` state
      emit(state.copyWith(status: AdFreeStatus.trialEnded));
      emit(state.copyWith(status: AdFreeStatus.showAds));
    }

    /// Updates the `_inAppPurchase.purchaseStream` to `PurchaseStatus.restored`
    /// if user has previously purchased ad free
    if (kReleaseMode) {
      await _adRepository.restorePurchases();
    }

    await emit.forEach(
      _adRepository.purchaseStream,
      onData: (List<PurchaseDetails> purchaseDetailsList) {
        if (purchaseDetailsList.isEmpty) {
          return state;
        }
        final stringStatus =
            EnumToString.convertToString(purchaseDetailsList[0].status);

        _logAdBloc('Purchase Stream Update: $stringStatus');

        final removeAdPurchaseDetail = purchaseDetailsList.firstWhereOrNull(
          (purchase) => purchase.productID == Env.REMOVE_ADS_PRODUCT_KEY,
        );

        if (removeAdPurchaseDetail == null) {
          return state.copyWith(
            status: AdFreeStatus.error,
            errorMessage:
                'Purchase detail not found, waiting on approval from Apple',
          );
        }

        _logAdBloc(
          '''Pending Complete Purchase: ${removeAdPurchaseDetail.pendingCompletePurchase} Purchase status: $stringStatus''',
        );

        if (removeAdPurchaseDetail.pendingCompletePurchase) {
          if (kReleaseMode) {
            _adRepository.completePurchase(removeAdPurchaseDetail);
          }
          return state.copyWith(status: AdFreeStatus.adFreePurchased);
        }

        switch (removeAdPurchaseDetail.status) {
          // no change in state if purchase is pending or canceled
          case PurchaseStatus.pending:
          case PurchaseStatus.canceled:
            return state;
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            return state.copyWith(status: AdFreeStatus.adFreePurchased);
          case PurchaseStatus.error:
            return state.copyWith(status: AdFreeStatus.error);
        }
      },
      onError: (error, stackTrace) =>
          state.copyWith(status: AdFreeStatus.error),
    );
  }

  Future<void> _onAdFreePurchaseRequest(
    AdFreePurchaseRequest event,
    Emitter<AdState> emit,
  ) async {
    if (!await _adRepository.isAvailable()) {
      return emit(state.copyWith(status: AdFreeStatus.error));
    }

    final productId = <String>{Env.REMOVE_ADS_PRODUCT_KEY};

    final productDetailResponse =
        await _adRepository.queryProductDetails(productId);

    _logAdBloc(
      '''
ProductDetailsResponse: ${productDetailResponse.productDetails[0].description}''',
    );

    if (productDetailResponse.productDetails.isEmpty) {
      return emit(state.copyWith(status: AdFreeStatus.error));
    }

    /// `buyNonConsumable` doesn't return the results of the purchase, only
    /// if the request itself was successful. It triggers updates to
    /// `_adRepository.purchaseStream`
    final successfulPurchaseRequest = await _adRepository.buyNonConsumable();

    if (!successfulPurchaseRequest) {
      return emit(state.copyWith(status: AdFreeStatus.error));
    }
  }

  bool _isTrialPeriod() {
    final installDate = state.appInstallDate;

    final daysSinceInstall = DateTime.now().toUtc().difference(installDate!);

    final trialPeriod = daysSinceInstall.inDays < _trialPeriodDays;

    return trialPeriod;
  }

  void _logAdBloc(String message) {
    AppDebug.log(message, name: 'AdBloc');
  }

  void _logAdBlocError(String message) {
    AppDebug.log(message, name: 'AdBloc');
    Sentry.captureException('AdBloc error: $message');
  }

  @override
  AdState? fromJson(Map<String, dynamic> json) {
    return AdState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AdState state) {
    return state.toJson();
  }
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
