import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haengunse/utils/platform_helper.dart';
import 'package:haengunse/widgets/web_ad_widget.dart';
import 'dart:io';

class BannerAdWidget extends StatefulWidget {
  final bool isLarge;
  final bool isLargeBanner;
  final Color? backgroundColor;

  const BannerAdWidget({super.key, this.isLarge = false, this.isLargeBanner = false, this.backgroundColor});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  String get _bannerAdUnitId {
    if (kDebugMode) {
      // 개발/테스트 환경에서는 테스트 ID 사용
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      // 웹에서는 기본값 사용
      if (PlatformHelper.isWeb) {
        return 'ca-app-pub-3940256099942544/6300978111'; // 웹 기본값
      }
      // 실제 환경에서는 플랫폼별 실제 ID 사용
      if (Platform.isIOS) {
        return 'ca-app-pub-2831429243631696/3031806028'; // iOS 배너 ID
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-2831429243631696/8228292380'; // Android 배너 ID
      } else {
        return 'ca-app-pub-3940256099942544/6300978111'; // 기본값
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    AdSize adSize;
    if (widget.isLarge) {
      adSize = AdSize.mediumRectangle;
    } else if (widget.isLargeBanner) {
      adSize = AdSize.largeBanner;
    } else {
      adSize = AdSize.banner;
    }
    
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 웹에서는 WebAdWidget 사용
    if (PlatformHelper.isWeb) {
      return WebAdWidget(
        isLarge: widget.isLarge,
        isLargeBanner: widget.isLargeBanner,
        backgroundColor: widget.backgroundColor,
      );
    }

    // 모바일에서는 기존 AdMob 로직 사용
    if (!_isLoaded) {
      if (widget.backgroundColor != null) {
        AdSize adSize;
        if (widget.isLarge) {
          adSize = AdSize.mediumRectangle;
        } else if (widget.isLargeBanner) {
          adSize = AdSize.largeBanner;
        } else {
          adSize = AdSize.banner;
        }
        
        return Container(
          alignment: Alignment.center,
          width: adSize.width.toDouble(),
          height: adSize.height.toDouble(),
          color: widget.backgroundColor,
        );
      }
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
