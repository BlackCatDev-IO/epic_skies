import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/banner_ads/ad_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'ad_event.dart';
part 'ad_state.dart';
part 'ad_bloc.freezed.dart';
part 'ad_bloc.g.dart';

class AdBloc extends HydratedBloc<AdEvent, AdState> {
  AdBloc({required this.isNewInstall, AdRepository? adRepo})
      : _adRepository = adRepo ?? AdRepository(),
        super(AdState()) {
    on<AdInitPurchaseListener>(_onAdInitPurchaseListener);
    on<AdFreePurchaseRequest>(_onAdFreePurchaseRequest);
  }

  static const _trialPeriodDays = 7;

  final bool isNewInstall;

  final AdRepository _adRepository;

  Future<void> _onAdInitPurchaseListener(
    AdInitPurchaseListener event,
    Emitter<AdState> emit,
  ) async {
    if (isNewInstall) {
      return emit(
        state.copyWith(
          status: AdFreeStatus.trialPeriod,
          appInstallDate: DateTime.now().toUtc(),
          isFirstInstall: true,
        ),
      );
    }

    if (_isTrialPeriod()) {
      emit(state.copyWith(isFirstInstall: false));

      return; // maintaining `trialPeriod` state
    }

    /// Notifying the user that the ad free trial has ended before emitting a
    /// `showAds` state
    if (state.status.isTrialPeriod) {
      emit(state.copyWith(status: AdFreeStatus.trialEnded));
      emit(state.copyWith(status: AdFreeStatus.showAds));
    }

    /// Updates the `_inAppPurchase.purchaseStream` to `PurchaseStatus.restored`
    /// if user has previously purchased ad free
    await _adRepository.restorePurchases();

    await emit.forEach(
      _adRepository.purchaseStream,
      onData: (List<PurchaseDetails> purchaseDetailsList) {
        final stringStatus =
            EnumToString.convertToString(purchaseDetailsList[0].status);

        _logAdBloc('Purchase Stream Update: $stringStatus');

        final removeAdPurchaseDetail = purchaseDetailsList.firstWhereOrNull(
          (purchase) => purchase.productID == Env.REMOVE_ADS_PRODUCT_KEY,
        );

        if (removeAdPurchaseDetail == null) {
          return state.copyWith(status: AdFreeStatus.error);
        }

        _logAdBloc(
          '''Pending Complete Purchase: ${removeAdPurchaseDetail.pendingCompletePurchase} Purchase status: $stringStatus''',
        );

        if (removeAdPurchaseDetail.pendingCompletePurchase) {
          _adRepository.completePurchase(removeAdPurchaseDetail);
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
