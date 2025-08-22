import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

  final String _testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

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
      adUnitId: _testBannerAdUnitId,
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
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
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
