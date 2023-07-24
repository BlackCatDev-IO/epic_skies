import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AdRepository {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Stream<List<PurchaseDetails>> get purchaseStream =>
      _inAppPurchase.purchaseStream;

  Future<void> restorePurchases() async => _inAppPurchase.restorePurchases();

  Future<bool> isAvailable() async => _inAppPurchase.isAvailable();

  Future<void> completePurchase(PurchaseDetails removeAdPurchaseDetail) async {
    await _inAppPurchase.completePurchase(removeAdPurchaseDetail);
  }

  Future<bool> buyNonConsumable() async {
    try {
      final productId = <String>{Env.REMOVE_ADS_PRODUCT_KEY};

      final productDetailResponse =
          await _inAppPurchase.queryProductDetails(productId);

      if (productDetailResponse.productDetails.isEmpty) {
        return false;
      }

      _logAdRepository(
        '''
ProductDetailsResponse: ${productDetailResponse.productDetails[0].description}''',
      );

      final adFreeProduct = productDetailResponse.productDetails[0];
      final purchaseParam = PurchaseParam(productDetails: adFreeProduct);

      /// `buyNonConsumable` doesn't return the results of the purchase, only
      /// if the request itself was successful. It triggers updates to
      /// `_inAppPurchase.purchaseStream`
      final purchaseRequestSentSuccessfully =
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

      if (!purchaseRequestSentSuccessfully) {
        await _inAppPurchase.restorePurchases();
        final retryPurchase =
            await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

        return retryPurchase;
      }

      return purchaseRequestSentSuccessfully;
    } on Exception catch (error) {
      if (error is PlatformException &&
          error.code == 'storekit_duplicate_product_object') {
        await _inAppPurchase.restorePurchases();
        rethrow;
      }
      rethrow;
    }
  }

  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> ids,
  ) async =>
      _inAppPurchase.queryProductDetails(ids);

  void _logAdRepository(String message) {
    AppDebug.log(message, name: 'AdRepository');
  }
}
