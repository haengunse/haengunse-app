import 'package:flutter/material.dart';

class SajuLoadingPage extends StatelessWidget {
  const SajuLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // 바깥 barrierColor가 적용됨
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "신년 사주를 해석 중이에요...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "잠시만 기다려주세요 ✨",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
