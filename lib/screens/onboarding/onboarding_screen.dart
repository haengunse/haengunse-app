import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    OnboardingController.handleNavigation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ⭐ 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_background.png',
              fit: BoxFit.cover,
            ),
          ),
          // ⭐ 메인 콘텐츠
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/onboarding_fortune.png',
                  width: 180.w,
                  height: 180.w,
                ),
                SizedBox(height: 5.h),
                Text(
                  "행운세",
                  style: TextStyle(
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "오늘은 어떤 하루일까요?",
                  style: TextStyle(
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w100,
                    color: const Color.fromARGB(255, 102, 152, 104),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
