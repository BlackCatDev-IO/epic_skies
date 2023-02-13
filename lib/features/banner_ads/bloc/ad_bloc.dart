import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc({required StorageController storage})
      : _storage = storage,
        super(ShowAds()) {
    on<AdInitPurchaseListener>(_onAdInitPurchaseListener);
    on<AdEndTrialPeriod>(_onAdEndTrialPeriod);
    on<AdFreePurchaseRequest>(_onAdFreePurchaseRequest);
  }

  final StorageController _storage;

  static const _trialPeriodDays = 7;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> _onAdInitPurchaseListener(
    AdInitPurchaseListener event,
    Emitter<AdState> emit,
  ) async {
    if (state is AdFreePurchased || _isTrialPeriod()) {
      emit(AdFreePurchased());
      return;
    }

    /// Updates the `_inAppPurchase.purchaseStream` to `PurchaseStatus.restored`
    /// if user has previously purchased ad free
    await _inAppPurchase.restorePurchases();

    await emit.forEach(
      _inAppPurchase.purchaseStream,
      onData: (List<PurchaseDetails> purchaseDetailsList) {
        final stringStatus =
            EnumToString.convertToString(purchaseDetailsList[0].status);

        _logAdBloc('Purchase Stream Update: $stringStatus');

        final removeAdPurchaseDetail = purchaseDetailsList.firstWhereOrNull(
          (purchase) => purchase.productID == Env.REMOVE_ADS_PRODUCT_KEY,
        );

        if (removeAdPurchaseDetail != null) {
          _logAdBloc(
            '''Pending Complete Purchase: ${removeAdPurchaseDetail.pendingCompletePurchase} Purchase status: $stringStatus''',
          );
          if (removeAdPurchaseDetail.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(removeAdPurchaseDetail);
            return AdFreePurchased();
          }

          switch (removeAdPurchaseDetail.status) {
            case PurchaseStatus.pending:
              {
                return AdPurchasePending();
              }
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              {
                return AdFreePurchased();
              }
            case PurchaseStatus.error:
              {
                return const AdPurchaseError(message: Errors.adPurchaseError);
              }
            case PurchaseStatus.canceled:
              {
                return const AdPurchaseError(
                  message: Errors.adPurchaseCanceled,
                );
              }
          }
        }
        return const AdPurchaseError(message: Errors.adPurchaseError);
      },
      onError: (error, stackTrace) =>
          const AdPurchaseError(message: Errors.adPurchaseError),
    );
  }

  Future<void> _onAdFreePurchaseRequest(
    AdFreePurchaseRequest event,
    Emitter<AdState> emit,
  ) async {
    emit(AdPurchasePending());
    if (await _inAppPurchase.isAvailable()) {
      final productId = <String>{Env.REMOVE_ADS_PRODUCT_KEY};

      final productDetailResponse =
          await _inAppPurchase.queryProductDetails(productId);

      _logAdBloc(
        'ProductDetailsResponse: ${productDetailResponse.productDetails[0].description}',
      );

      if (productDetailResponse.notFoundIDs.isNotEmpty) {
        _logAdBloc('NOT FOUND IDS: ${productDetailResponse.notFoundIDs}');

        // TODO: Handle the error.
      }

      if (productDetailResponse.productDetails.isNotEmpty) {
        final adFreeProduct = productDetailResponse.productDetails[0];
        final purchaseParam = PurchaseParam(productDetails: adFreeProduct);

        /// `buyNonConsumable` doesn't return the results of the purchase, only if
        /// the request itself was successful. It triggers updates to
        /// `_inAppPurchase.purchaseStream`
        final purchaseRequestSentSuccessfully =
            await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

        if (!purchaseRequestSentSuccessfully) {
          emit(const AdPurchaseError(message: Errors.adPurchaseError));
        }
      } else {
        emit(const AdPurchaseError(message: Errors.adPurchaseError));
      }
    } else {
      emit(const AdPurchaseError(message: Errors.adPurchaseError));

      // TODO: HANDLE STORE NOT AVAILABLE
      _logAdBloc('NOT AVAILABLE');
    }
  }

  Future<void> _onAdEndTrialPeriod(
    AdEndTrialPeriod event,
    Emitter<AdState> emit,
  ) async {}

  bool _isTrialPeriod() {
    final installDate = _storage.appInstallDate();

    if (installDate != null) {
      final daysSinceInstall = DateTime.now().toUtc().difference(installDate);

      final trialPeriod = daysSinceInstall.inDays < _trialPeriodDays;

      return trialPeriod;
    }
    return true;
  }

  void _logAdBloc(String message) {
    AppDebug.log(message, name: 'AdBloc');
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
