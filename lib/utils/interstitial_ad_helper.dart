import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class InterstitialAdHelper {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;
  static int _numInterstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;
  
  // 테스트용 전면 광고 ID
  static const String _testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  
  static void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _testInterstitialAdUnitId,
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