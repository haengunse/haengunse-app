import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:haengunse/utils/platform_helper.dart';
import 'dart:io';

class InterstitialAdHelper {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;
  static int _numInterstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;
  
  // 플랫폼별 전면 광고 ID
  static String get _interstitialAdUnitId {
    if (kDebugMode) {
      // 개발/테스트 환경에서는 테스트 ID 사용
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      // 웹에서는 기본값 사용
      if (PlatformHelper.isWeb) {
        return 'ca-app-pub-3940256099942544/1033173712'; // 웹 기본값
      }
      // 실제 환경에서는 플랫폼별 실제 ID 사용
      if (Platform.isIOS) {
        return 'ca-app-pub-2831429243631696/8036720698'; // iOS 전면 광고 ID
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-2831429243631696/5602129044'; // Android 전면 광고 ID
      } else {
        return 'ca-app-pub-3940256099942544/1033173712'; // 기본값
      }
    }
  }
  
  static void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded');
          _interstitialAd = ad;
          _isAdLoaded = true;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          _isAdLoaded = false;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }
  
  static void showInterstitialAd({VoidCallback? onAdDismissed}) {
    // 웹에서는 AdSense 비네트 광고가 자동으로 표시됨
    if (PlatformHelper.isWeb) {
      debugPrint('웹 환경: AdSense 자동광고(비네트) 활성화됨');
      // 웹에서는 자동광고가 적절한 타이밍에 표시되므로 바로 콜백 실행
      onAdDismissed?.call();
      return;
    }
    
    // 모바일에서는 기존 AdMob 전면광고 로직
    if (_interstitialAd == null || !_isAdLoaded) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      onAdDismissed?.call();
      return;
    }
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _isAdLoaded = false;
        createInterstitialAd();
        onAdDismissed?.call();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _isAdLoaded = false;
        createInterstitialAd();
        onAdDismissed?.call();
      },
    );
    
    _interstitialAd!.show();
    _interstitialAd = null;
  }
  
  static void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
  }
}