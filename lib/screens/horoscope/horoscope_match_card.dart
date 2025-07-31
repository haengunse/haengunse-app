import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeMatchCard extends StatelessWidget {
  final String label;
  final String ageName;
  final HoroscopeMode mode;

  const HoroscopeMatchCard({
    required this.label,
    required this.ageName,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final characterImage =
        'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[ageName] : koreanToZodiacEnglish[ageName]}.png';

    final badgeImage = label.contains('주의')
        ? 'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/worst_match.png'
        : 'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/best_match.png';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 흰색 박스 (캐릭터와 수평 겹침)
        Padding(
          padding: EdgeInsets.only(left: 40.w), // 캐릭터 이미지 너비 + 여백만큼 밀기
          child: Container(
            width: 120.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            alignment: Alignment.center, // 텍스트 가운데 정렬
            child: Text(
              ageName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'HakgyoansimDunggeunmiso',
              ),
            ),
          ),
        ),

        // 캐릭터 이미지 (왼쪽, 세로 가운데에 맞춤)
        Positioned(
          top: 0,
          bottom: 0,
          left: -10.w,
          child: Center(
            child: Image.asset(
              characterImage,
              width: mode == HoroscopeMode.star &&
                      koreanToHoroscopeEnglish[ageName] == 'gemini'
                  ? 65.w
                  : 80.w,
              height: mode == HoroscopeMode.star &&
                      koreanToHoroscopeEnglish[ageName] == 'gemini'
                  ? 65.w
                  : 80.w,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // 배너 이미지 (카드 위에 겹쳐서 중앙 배치)
        Positioned(
          top: -8.h,
          left: 32.w,
          right: 0,
          child: Center(
            child: Image.asset(
              badgeImage,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
