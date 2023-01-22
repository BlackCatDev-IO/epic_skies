import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../utils/env/env.dart';
import '../../../utils/logging/app_debug_log.dart';

class NativeAdListTile extends StatefulWidget {
  @override
  State<NativeAdListTile> createState() => _NativeAdListTileState();
}

class _NativeAdListTileState extends State<NativeAdListTile> {
  late NativeAd _ad;
  bool _isAdLoaded = false;

  void _logNativeAd(String message) =>
      AppDebug.log(message, name: 'NativeAdListTile');

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: Env.testNativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
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

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            color: Colors.white70,
            height: 80,
            child: AdWidget(ad: _ad),
          ).paddingSymmetric(horizontal: 20, vertical: 10)
        : const Text('ad loading...').center();
  }
}
