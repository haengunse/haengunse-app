import 'package:flutter/material.dart';

class SajuScreen extends StatelessWidget {
  final String manseInfo;
  final Map<String, String> sajuResult;
  final String userName;

  const SajuScreen({
    super.key,
    required this.manseInfo,
    required this.sajuResult,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌌 배경 이미지
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('사주 운세',
                style: TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: Colors.black.withOpacity(0.5),
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // 저장 또는 공유 기능
            },
            icon: const Icon(Icons.check),
            label: const Text('확인'),
            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.85),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _buildSection("🧾 사주 정보", "$userName님의 사주\n\n$manseInfo"),
                  const SizedBox(height: 16),
                  _buildSection("📜 전체 해석", sajuResult['summary'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("💬 내 성격은", sajuResult['personality'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("🌿 오행 분석", sajuResult['fiveElements'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("🌟 십성 분석", sajuResult['tenGods'] ?? ''),
                  const SizedBox(height: 80), // FAB 공간 확보
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
