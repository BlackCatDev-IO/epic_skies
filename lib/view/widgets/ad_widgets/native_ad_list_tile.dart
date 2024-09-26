import 'dart:io';

import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdListTile extends StatefulWidget {
  const NativeAdListTile({super.key});

  @override
  NativeAdListTileState createState() => NativeAdListTileState();
}

class NativeAdListTileState extends State<NativeAdListTile>
    with AutomaticKeepAliveClientMixin {
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

    final colorState = context.read<ColorCubit>().state;

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
          _nativeAd?.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: colorState.theme.soloCardColor,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.monospace,
          size: 16,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.bold,
          size: 16,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.italic,
          size: 16,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
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
    super.build(context);
    final colorState = context.read<ColorCubit>().state;

    final shouldLoadAd = _nativeAdIsLoaded && _nativeAd != null;

    if (shouldLoadAd) {
      return SizedBox(
        height: 100,
        child: AdWidget(ad: _nativeAd!),
      );
    }

    return Container(
      color: colorState.theme.soloCardColor,
      height: 100,
      child: const Text('Loading...').center(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
