import 'dart:io';

import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdListTile extends StatefulWidget {
  const NativeAdListTile({super.key});

  @override
  NativeAdListTileState createState() => NativeAdListTileState();
}

class NativeAdListTileState extends State<NativeAdListTile> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  String _getUnitId() {
    if (kReleaseMode) {
      return Platform.isAndroid ? Env.ANDROID_PROD_AD_ID : Env.IOS_PROD_AD_ID;
    }

    return Platform.isAndroid ? Env.ANDROID_TEST_AD_ID : Env.IOS_TEST_AD_ID;
  }

  @override
  void initState() {
    super.initState();

    _loadAd();
  }

  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });

    _nativeAd = NativeAd(
      adUnitId: _getUnitId(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          AppDebug.log('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          AppDebug.log('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: const Color(0xfffffbed),
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.monospace,
          size: 16,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.bold,
          size: 16,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.italic,
          size: 16,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.normal,
          size: 16,
        ),
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adContainer = _AdContainerSmall(ad: _nativeAd!);

    return _nativeAdIsLoaded && _nativeAd != null
        ? adContainer
        : const SizedBox.shrink();
  }
}

class _AdContainerSmall extends StatelessWidget {
  const _AdContainerSmall({required this.ad});

  final AdWithView ad;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AdWidget(ad: ad),
    );
  }
}
