import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/home/weather_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 100.h, 5.w, 16.h), // 위/아래 여백 조절
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
                onTap: () => Navigator.pushNamed(context, '/todaysplash'),
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
                      "더 자세히 확인하기 ->",
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
