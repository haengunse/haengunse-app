import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/onboarding/input_screen.dart';
import 'package:haengunse/screens/home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();

    // 🔥 테스트용 강제 초기화 (배포 시 삭제) 🔥
    await prefs.clear();

    final isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (!mounted) return;

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "✨ 행운세 ✨",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
