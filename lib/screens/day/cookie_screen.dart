import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/widgets/banner_ad_widget.dart';

class CookieScreen extends StatelessWidget {
  final String message;

  const CookieScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEED),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          // 메인 콘텐츠
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Stack(
                children: [
                  // 닫기 버튼
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 24, color: Colors.black),
                    ),
                  ),
                  // 메인 콘텐츠
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.h),
                      Image.asset(
                        'assets/images/cookie_card.png', // 🥠 포춘쿠키용 이미지 경로
                        width: 150.w,
                        height: 150.w,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "행운세가 전하는",
                        style: TextStyle(
                          fontFamily: 'HakgyoansimDunggeunmiso',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w200,
                          color: const Color.fromARGB(255, 96, 95, 95),
                        ),
                      ),
                      Text(
                        "오늘의 한마디",
                        style: TextStyle(
                          fontFamily: 'HakgyoansimDunggeunmiso',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 96, 95, 95),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        '"$message"',
                        style: TextStyle(
                          fontFamily: 'HakgyoansimDunggeunmiso',
                          fontSize: 24.sp,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 배너 광고
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: const BannerAdWidget(backgroundColor: Color(0xFFFFFEED)),
          ),
        ],
      ),
    );
  }
}
