import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../features/banner_ads/ad_controller.dart';
import '../../../utils/logging/app_debug_log.dart';

class NativeAdListTile extends StatefulWidget {
  @override
  State<NativeAdListTile> createState() => _NativeAdListTileState();
}

class _NativeAdListTileState extends State<NativeAdListTile> {
  late NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: AdController.testNativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          _logNativeAd('AD LOADED');
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _logNativeAd(
            'Ad load failed (code=${error.code} message=${error.message})',
          );
        },
      ),
    );

    _ad.load();
  }

  void _logNativeAd(String message) {
    AppDebug.log(message, name: 'NativeAdListTile');
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? SizedBox(
            height: 80,
            child: AdWidget(ad: _ad).paddingSymmetric(horizontal: 20),
          )
        : const Text('ad loading...');
  }
}
