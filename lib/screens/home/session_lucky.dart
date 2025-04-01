import 'package:flutter/material.dart';
import 'package:haengunse/screens/splash_screen.dart';
import 'package:haengunse/service/today.dart';

class SessionLucky extends StatelessWidget {
  final String userName;
  final double screenHeight;

  const SessionLucky({
    super.key,
    required this.userName,
    required this.screenHeight,
  });

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일";
  }

  Widget _buildWeatherInfo() {
    return SizedBox(
      width: 330,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.wb_sunny, color: Colors.orange, size: 10),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("1° | -7°",
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
                Text("대체로 맑지만 오후에 비가 올 예정이에요",
                    style: TextStyle(fontSize: 8, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3.7,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 244, 231),
      ),
      padding: const EdgeInsets.fromLTRB(24, 65, 5, 16),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Image.asset(
              "assets/images/home_main.png",
              width: 230,
              height: 230,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("반가워요 $userName님!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                    fontFamily: 'Pretendard',
                  )),
              GestureDetector(
                onTap: () async {
                  final data = await getTodayRequestData();
                  debugPrint("요청 데이터: $data");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                  );
                },
                child: const Text(
                  "오늘은\n어떤 하루일까요?",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard'),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _getTodayDate(),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontFamily: 'Pretendard'),
              ),
              const SizedBox(height: 10),
              _buildWeatherInfo(),
            ],
          ),
        ],
      ),
    );
  }
}
