import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/today/score_widget.dart';

class TodayScreen extends StatelessWidget {
  final Map<String, dynamic>? requestData;
  final Map<String, dynamic>? responseData;

  const TodayScreen({
    super.key,
    this.requestData,
    this.responseData,
  });

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일";
  }

  @override
  Widget build(BuildContext context) {
    final dailyMessage = responseData?['dailyMessage'] ?? '오늘 하루도 힘차게 시작해요!';
    final totalScore = responseData?['totalScore'] ?? 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
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
          // 1. 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/today_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. 메인 내용
          Positioned.fill(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: kToolbarHeight +
                      MediaQuery.of(context).padding.top +
                      16.h,
                  left: 16.w,
                  right: 16.w,
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
                        blurRadius: 18.r,
                        spreadRadius: 5,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 상단 날짜 + 메시지 + 점수
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 왼쪽: 날짜 + dailyMessage (반절만 차지)
                          SizedBox(
                            width: (MediaQuery.of(context).size.width -
                                    32.w -
                                    40.w) /
                                2,
                            // (전체 가로 - 좌우 패딩 - 컨테이너 패딩) / 2
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getTodayDate(),
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14.sp,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  dailyMessage,
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    height: 1.4,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w), // 왼쪽/오른쪽 사이 여백
                          // 오른쪽: 스코어 (오른쪽 정렬)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ScoreWidget(totalScore: totalScore),
                              ],
                            ),
                          ),
                        ],
                      ),
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
