import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/banner_ads/ad_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'ad_bloc.mapper.dart';
part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends HydratedBloc<AdEvent, AdState> {
  AdBloc({AdRepository? adRepository})
      : _adRepository = adRepository ?? AdRepository(),
        super(AdState()) {
    on<AdInitPurchaseListener>(_onAdInitPurchaseListener);
    on<AdFreePurchaseRequest>(_onAdFreePurchaseRequest);
    on<AdFreeRestorePurchase>(_onAdFreeRestorePurchase);
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

    try {
      await MobileAds.instance.initialize();
    } catch (e) {
      _logAdBlocError('Error initializing Mobile Ads: $e');

      /// Any error at this point is outside of control of this app should not
      /// bother the user, so here it defaults to ad free status
      emit(state.copyWith(status: AdFreeStatus.adFreePurchased));
      rethrow;
    }

    if (!_isTrialPeriod() && state.status.isTrialPeriod) {
      /// Notifying the user that the ad free trial has ended before emitting a
      /// `showAds` state
      emit(state.copyWith(status: AdFreeStatus.trialEnded));
      emit(state.copyWith(status: AdFreeStatus.showAds));
    }

    try {
      await emit.forEach(
        _adRepository.purchaseStream,
        onData: (List<PurchaseDetails> purchaseDetailsList) {
          if (purchaseDetailsList.isEmpty) {
            return state.copyWith(
              status: AdFreeStatus.error,
              errorMessage: Errors.noPurchaseFouund,
            );
          }

          if (purchaseDetailsList.first.error?.message ==
              'BillingResponse.itemAlreadyOwned') {
            return state.copyWith(status: AdFreeStatus.adFreePurchased);
          }

          final stringStatus =
              EnumToString.convertToString(purchaseDetailsList[0].status);

          _logAdBloc('Purchase Stream Update: $stringStatus');

          final removeAdPurchaseDetail = purchaseDetailsList.firstWhereOrNull(
            (purchase) => purchase.productID == Env.adFreeProductID,
          );

          if (removeAdPurchaseDetail == null) {
            return state.copyWith(
              status: AdFreeStatus.error,
              errorMessage: Errors.noPurchaseFouund,
            );
          }

          _logAdBloc(
            '''Pending Complete Purchase: ${removeAdPurchaseDetail.pendingCompletePurchase} Purchase status: $stringStatus''',
          );

          if (removeAdPurchaseDetail.pendingCompletePurchase &&
              removeAdPurchaseDetail.status != PurchaseStatus.canceled) {
            if (kReleaseMode) {
              _adRepository.completePurchase(removeAdPurchaseDetail);
            }
            return state.copyWith(status: AdFreeStatus.adFreePurchased);
          }

          switch (removeAdPurchaseDetail.status) {
            case PurchaseStatus.canceled:
              final status = _isTrialPeriod()
                  ? AdFreeStatus.trialPeriod
                  : AdFreeStatus.showAds;

              return state.copyWith(status: status);

            // no change in state if purchase is pending
            case PurchaseStatus.pending:
              return state;
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              return state.copyWith(status: AdFreeStatus.adFreePurchased);
            case PurchaseStatus.error:
              return state.copyWith(status: AdFreeStatus.error);
          }
        },
        onError: (error, stackTrace) {
          emit(
            state.copyWith(
              status: AdFreeStatus.error,
              errorMessage: '$error',
            ),
          );

          throw Exception(error);
        },
      );
    } catch (e) {
      _logAdBlocError('Error initializing purchase stream: $e');
      emit(state.copyWith(status: AdFreeStatus.error));
      rethrow;
    }
  }

  Future<void> _onAdFreePurchaseRequest(
    AdFreePurchaseRequest event,
    Emitter<AdState> emit,
  ) async {
    try {
      if (!await _adRepository.isAvailable()) {
        return emit(
          state.copyWith(
            status: AdFreeStatus.error,
            errorMessage: 'In app purchase not available. Please try again',
          ),
        );
      }

      emit(
        state.copyWith(
          status: AdFreeStatus.loading,
          errorMessage: '',
        ),
      );

      final productId = <String>{Env.adFreeProductID};

      final productDetailResponse =
          await _adRepository.queryProductDetails(productId);

      if (productDetailResponse.productDetails.isEmpty) {
        return emit(
          state.copyWith(
            status: AdFreeStatus.error,
            errorMessage: 'Product not found',
          ),
        );
      }

      _logAdBloc(
        '''
ProductDetailsResponse: ${productDetailResponse.productDetails[0].description}''',
      );

      /// `buyNonConsumable` doesn't return the results of the purchase, only
      /// if the request itself was successful. It triggers updates to
      /// `_adRepository.purchaseStream`

      final successfulPurchaseRequest = await _adRepository.buyNonConsumable();

      if (!successfulPurchaseRequest) {
        return emit(state.copyWith(status: AdFreeStatus.error));
      }
    } on Exception catch (e) {
      _logAdBlocError('Error purchasing ad free: $e');
      emit(state.copyWith(status: AdFreeStatus.error));

      rethrow;
    }
  }

  Future<void> _onAdFreeRestorePurchase(
    AdFreeRestorePurchase event,
    Emitter<AdState> emit,
  ) async {
    try {
      if (state.status.isAdFreePurchased || state.status.isAdFreeRestored) {
        emit(
          state.copyWith(
            status: AdFreeStatus.loading,
          ),
        );

        emit(state.copyWith(status: AdFreeStatus.adFreeRestored));

        return;
      }

      emit(state.copyWith(status: AdFreeStatus.loading));
      await _adRepository.restorePurchases();
    } catch (e) {
      _logAdBlocError('Error restoring purchases: $e');
      emit(
        state.copyWith(
          status: AdFreeStatus.error,
          errorMessage:
              '''Error restoring purchases. Please restart your device and try again. If the issue persists, please contact the developer.''',
        ),
      );
      rethrow;
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
  }

  @override
  AdState? fromJson(Map<String, dynamic> json) {
    return AdState.fromMap(json).copyWith(errorMessage: '');
  }

  @override
  Map<String, dynamic>? toJson(AdState state) {
    return state.toMap();
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
