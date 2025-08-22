import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/home/weather_box.dart';
import 'package:haengunse/utils/interstitial_ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/service/today/today_interactor.dart';

class SectionLucky extends StatelessWidget {
  final String userName;

  const SectionLucky({
    super.key,
    required this.userName,
  });

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일";
  }

  Future<void> _handleTodayTap(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final manseInfo = prefs.getString('manseInfo');
    final gender = prefs.getString('gender');

    final jsonData = {
      'manseInfo': manseInfo,
      'gender': gender,
    };

    bool isDataReady = false;
    Map<String, dynamic>? responseData;
    
    // API 요청 시작
    final interactor = TodayInteractor(
      context: context,
      userData: jsonData,
    );
    
    // handleTodayRequest를 수정해야 하므로 여기서 직접 처리
    Navigator.pushNamed(context, '/todaysplash');
    
    // 바로 광고 표시
    Future.delayed(const Duration(milliseconds: 300), () {
      InterstitialAdHelper.showInterstitialAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 0.h, 5.w, 16.h), // 위/아래 여백 조절
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 244, 231),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30.h,
            right: -30.w,
            child: Image.asset(
              "assets/images/home_main.png",
              width: 220.w,
              height: 220.h,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("반가워요 ${userName}님",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontFamily: 'Pretendard',
                  )),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: () => _handleTodayTap(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "오늘은\n어떤 하루일까요?",
                      style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      " 더 자세히 확인하기 ->",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey[700],
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 13.h),
              const WeatherBox(),
            ],
          ),
        ],
      ),
    );
  }
}
