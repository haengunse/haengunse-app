import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'today_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final birthDate = prefs.getString('birthDate');
    final birthTime = prefs.getString('birthTime');
    final name = prefs.getString('name');
    final gender = prefs.getString('gender');
    final solar = prefs.getString('solar');

    setState(() {
      userData = {
        "birthDate": birthDate,
        "birthTime": birthTime,
        "name": name,
        "gender": gender,
        "solar": solar,
      };
    });

    // 3초 후 홈으로 이동
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TodayScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: userData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "사용자 정보 로딩 중...",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Text("이름: ${userData!['name'] ?? '-'}"),
                  Text("성별: ${userData!['gender'] ?? '-'}"),
                  Text(
                      "생년월일: ${userData!['birthDate']?.split('T').first ?? '-'}"),
                  Text("출생시간: ${userData!['birthTime'] ?? '모름'}"),
                  Text("달력: ${userData!['solar']}"),
                ],
              ),
      ),
    );
  }
}
