import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/today/score_widget.dart';
import 'package:haengunse/screens/today/report_widget.dart';
import 'package:haengunse/screens/today/text_box.dart';

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
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "오늘의 운세",
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 23,
            color: Colors.black,
          ),
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
                  left: 25.w,
                  right: 25.w,
                  bottom: 30.h,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
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
                      SizedBox(height: 32.h),
                      Text(
                        "리포트",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // 리포트 위젯 추가
                      Center(
                        child: ReportWidget(responseData: responseData),
                      ),

                      SizedBox(height: 20.h),

                      // 운세 설명
                      TextBox(
                        description: responseData?['generalFortune'] ?? '-',
                      ),
                      SizedBox(height: 8.h),
                      TextBox(
                        title: '재물운',
                        description: responseData?['wealthFortune']
                                ?['description'] ??
                            '-',
                      ),
                      SizedBox(height: 8.h),
                      TextBox(
                        title: '애정운',
                        description:
                            responseData?['loveFortune']?['description'] ?? '-',
                      ),
                      SizedBox(height: 8.h),
                      TextBox(
                        title: '건강운',
                        description: responseData?['healthFortune']
                                ?['description'] ??
                            '-',
                      ),
                      SizedBox(height: 8.h),
                      TextBox(
                        title: '학업운',
                        description: responseData?['studyFortune']
                                ?['description'] ??
                            '-',
                      ),
                      SizedBox(height: 8.h),
                      TextBox(
                        title: '업무운',
                        description: responseData?['careerFortune']
                                ?['description'] ??
                            '-',
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
