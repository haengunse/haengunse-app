import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "행운세";

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? "행운세";
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1st section: 인사, 날짜, 날씨
          Container(
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
                    Text(
                      "반가워요 $userName님!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SplashScreen()),
                        );
                      },
                      child: const Text(
                        "오늘은\n어떤 하루일까요?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getTodayDate(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildWeatherInfo(),
                  ],
                ),
              ],
            ),
          ),

          // 2nd section: 운세 카드 타이틀
          Container(
            height: screenHeight / 3,
            width: double.infinity,
            color: const Color(0xFFFFF7D6), // 연노랑
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("다양한 운세를 알아볼까요?",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                SizedBox(height: 8),
                Text("운세 카드",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // 3rd section: 운세 차트
          Container(
            height: screenHeight / 3,
            width: double.infinity,
            color: const Color(0xFFE3F2FD), // 연하늘
            padding: const EdgeInsets.all(24),
            child: _buildHoroscopeChart(),
          ),
        ],
      ),
    );
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일";
  }

  Widget _buildWeatherInfo() {
    return SizedBox(
      width: 330, // ← 원하는 너비로 조절
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
                Text(
                  "1° | -7°",
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                ),
                Text(
                  "대체로 맑지만 오후에 비가 올 예정이에요",
                  style: TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoroscopeChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "운세 차트",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildChartRow("오늘의 오하야사 순위", "물병자리", "쌍둥이자리"),
        _buildChartRow("오늘의 띠별 운세", "양띠", "돼지띠"),
      ],
    );
  }

  Widget _buildChartRow(String title, String left, String right) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            Row(
              children: [
                Text(left, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text(right, style: const TextStyle(color: Colors.redAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
