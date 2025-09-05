import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui_web' as ui_web;
import 'package:universal_html/html.dart' as html;
import 'dart:js' as js;

class WebAdWidget extends StatefulWidget {
  final bool isLarge;
  final bool isLargeBanner;
  final Color? backgroundColor;

  const WebAdWidget({
    super.key, 
    this.isLarge = false, 
    this.isLargeBanner = false, 
    this.backgroundColor
  });

  @override
  State<WebAdWidget> createState() => _WebAdWidgetState();
}

class _WebAdWidgetState extends State<WebAdWidget> {
  late String _adSlotId;
  late double _adWidth;
  late double _adHeight;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _setupAdDimensions();
    if (kIsWeb) {
      _loadAd();
    }
  }

  void _setupAdDimensions() {
    if (widget.isLarge) {
      _adSlotId = 'ad-container-large-${DateTime.now().millisecondsSinceEpoch}';
      _adWidth = 280;
      _adHeight = 200;
    } else if (widget.isLargeBanner) {
      _adSlotId = 'ad-container-large-banner-${DateTime.now().millisecondsSinceEpoch}';
      _adWidth = 728;
      _adHeight = 90;
    } else {
      _adSlotId = 'ad-container-banner-${DateTime.now().millisecondsSinceEpoch}';
      _adWidth = 320;
      _adHeight = 50;
    }
  }

  void _loadAd() {
    if (!kIsWeb) return;
    
    // AdSense 광고 컨테이너 생성
    final adContainer = html.DivElement()
      ..id = _adSlotId
      ..style.width = '${_adWidth}px'
      ..style.height = '${_adHeight}px';

    // AdSense 광고 요소 생성
    final adElement = html.Element.html('''
      <ins class="adsbygoogle"
           style="display:block;width:${_adWidth}px;height:${_adHeight}px"
           data-ad-client="ca-pub-2831429243631696"
           data-ad-slot="${_getAdSlot()}"
           data-ad-format="rectangle"
           data-full-width-responsive="false"></ins>
    ''');

    adContainer.append(adElement);

    // Flutter 웹에 HTML 요소 등록
    ui_web.platformViewRegistry.registerViewFactory(
      _adSlotId,
      (int viewId) => adContainer,
    );

    // AdSense 스크립트 실행
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _pushAd();
        setState(() {
          _isLoaded = true;
        });
      }
    });
  }

  void _pushAd() {
    if (!kIsWeb) return;
    
    try {
      // AdSense 광고 로드
      js.context.callMethod('eval', ['''
        try {
          (adsbygoogle = window.adsbygoogle || []).push({});
        } catch (e) {
          console.log('AdSense push error:', e);
        }
      ''']);
    } catch (e) {
      debugPrint('AdSense 광고 로드 실패: $e');
    }
  }

  String _getAdSlot() {
    // AdMob에서 생성한 웹 광고 단위 ID 사용
    if (widget.isLarge) {
      return '3031806028'; // 280x200 AdMob 웹 슬롯
    } else if (widget.isLargeBanner) {
      return '8036720698'; // 728x90 AdMob 웹 슬롯  
    } else {
      return '5602129044'; // 320x50 AdMob 웹 슬롯
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb || !_isLoaded) {
      return Container(
        width: _adWidth,
        height: _adHeight,
        color: widget.backgroundColor ?? Colors.grey[200],
        child: const Center(
          child: Text(
            'AdSense Loading...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: _adWidth,
      height: _adHeight,
      child: HtmlElementView(viewType: _adSlotId),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}