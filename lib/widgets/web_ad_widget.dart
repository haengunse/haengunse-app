import 'package:flutter/material.dart';

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
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // 간단한 로딩 시뮬레이션
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      // 로딩 중일 때 배경색만 표시
      double width = widget.isLarge ? 300 : 320;
      double height = widget.isLarge ? 250 : (widget.isLargeBanner ? 100 : 50);
      
      return Container(
        width: width,
        height: height,
        color: widget.backgroundColor ?? Colors.grey[200],
        child: const Center(
          child: Text(
            'AdSense',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    // 실제 AdSense 광고 표시 (현재는 플레이스홀더)
    double width = widget.isLarge ? 300 : 320;
    double height = widget.isLarge ? 250 : (widget.isLargeBanner ? 100 : 50);
    
    return Container(
      width: width,
      height: height,
      color: widget.backgroundColor ?? Colors.grey[100],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ads_click, color: Colors.grey, size: 24),
            SizedBox(height: 4),
            Text(
              'Google AdSense',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Text(
              '(웹 광고)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}