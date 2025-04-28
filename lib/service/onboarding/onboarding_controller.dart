import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/onboarding/input_screen.dart';
import 'package:haengunse/screens/home/home_screen.dart';

class OnboardingController {
  static Future<void> handleNavigation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();

    // 🔥 테스트용 초기화 (배포 전 삭제)
    await prefs.clear();

    final isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (!context.mounted) return;

    if (isFirstRun) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InputScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }
}
