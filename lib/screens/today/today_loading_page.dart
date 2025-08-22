import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/service/today/today_interactor.dart';
import 'package:haengunse/widgets/banner_ad_widget.dart';

class TodayProgressLoadingPage extends StatefulWidget {
  const TodayProgressLoadingPage({super.key});

  @override
  State<TodayProgressLoadingPage> createState() =>
      _TodayProgressLoadingPageState();
}

class _TodayProgressLoadingPageState extends State<TodayProgressLoadingPage> {
  @override
  void initState() {
    super.initState();
    _prepareRequest();
  }

  Future<void> _prepareRequest() async {
    final prefs = await SharedPreferences.getInstance();

    final manseInfo = prefs.getString('manseInfo');
    final gender = prefs.getString('gender');

    final jsonData = {
      'manseInfo': manseInfo,
      'gender': gender,
    };

    TodayInteractor(
      context: context,
      userData: jsonData,
    ).handleTodayRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 기존 중앙 콘텐츠 유지
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: const CircularProgressIndicator(
                        color: Color(0xFF82c784),
                        strokeWidth: 6.5,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      '곧 당신만의 운세가 도착합니다.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '잠시만 기다려 주세요.\n오늘의 운세를 예측하고 있어요.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13.sp,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // 하단 배너 광고
            Positioned(
              bottom: 5.h,
              left: 0,
              right: 0,
              child: const BannerAdWidget(isLarge: true),
            ),
          ],
        ),
      ),
    );
  }
}
