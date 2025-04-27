import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayScreen extends StatelessWidget {
  final Map<String, dynamic>? requestData;
  final Map<String, dynamic>? responseData;

  const TodayScreen({
    super.key,
    this.requestData,
    this.responseData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 배경을 AppBar 뒤까지 확장
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false, // 왼쪽 정렬
        title: const Text(
          "오늘의 운세",
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // 1. 배경
          Positioned.fill(
            child: Image.asset(
              'assets/images/today_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. 내용 (스크롤)
          Positioned.fill(
            child: SafeArea(
              top: false, // AppBar 영역은 우리가 직접 조정
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: kToolbarHeight +
                      MediaQuery.of(context).padding.top +
                      16.h, // 앱바+상단 SafeArea 높이
                  left: 20.w,
                  right: 20.w,
                  bottom: 30.h,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20.r,
                        spreadRadius: 8,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "여기에 오늘의 운세 상세 위젯 삽입",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // 여기 이후로 ScoreWidget, ReportWidget, TextBox 추가
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
