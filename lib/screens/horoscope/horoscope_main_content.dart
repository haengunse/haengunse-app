import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';
import 'package:haengunse/screens/horoscope/horoscope_match_card.dart';

class HoroscopeMainContent<T extends BaseFortune> extends StatelessWidget {
  final T fortune;
  final HoroscopeMode mode;

  const HoroscopeMainContent({
    required this.fortune,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(193, 255, 251, 231), // 연한 노란색 배경
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            // 캐릭터 이미지 (가로 전체, 반응형 높이)
            SizedBox(
              height: 0.35.sh,
              child: Padding(
                padding: EdgeInsets.only(top: 80.h), // 상단 여백만 추가
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/${mode == HoroscopeMode.star ? 'star' : 'zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 날짜 범위
            if (mode == HoroscopeMode.star && fortune is StarFortune)
              Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                ),
                child: Text(
                  (fortune as StarFortune).dateRange,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              )
            else
              SizedBox(height: 10.h), // 날짜 텍스트가 없을 경우도 간격 유지

            SizedBox(height: 10.h),

            // 흰색 박스 (중앙 정렬, 그림자 포함)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.r,
                    offset: Offset(0, 4.h),
                  )
                ],
              ),
              child: Text(
                fortune.mainMessage,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'HakgyoansimDunggeunmiso',
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // 띠 매칭 카드 2개
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HoroscopeMatchCard(
                    label: '잘 맞는 친구',
                    ageName: fortune.bestMatch,
                    mode: mode,
                  ),
                  HoroscopeMatchCard(
                    label: '주의할 친구',
                    ageName: fortune.worstMatch,
                    mode: mode,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
