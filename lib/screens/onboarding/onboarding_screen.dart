import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Fade In 애니메이션 세팅
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // 0.8초
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward(); // 시작하자마자 재생

    // 네비게이션도 같이 실행
    OnboardingController.handleNavigation(context);
  }

  @override
  void dispose() {
    _animationController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_background.png',
              fit: BoxFit.cover,
            ),
          ),
          // 메인 콘텐츠
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
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
                      color: const Color.fromARGB(255, 96, 95, 95),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "오늘은 어떤 하루일까요?",
                    style: TextStyle(
                      fontFamily: 'HakgyoansimDunggeunmiso',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w100,
                      color: const Color.fromARGB(255, 114, 172, 116),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
