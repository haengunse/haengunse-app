import 'package:flutter/material.dart';
import 'home_screen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "오늘의 운세 상세 화면입니다.",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
    );
  }
}
