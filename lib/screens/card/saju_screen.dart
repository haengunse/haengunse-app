import 'package:flutter/material.dart';
import 'package:haengunse/screens/card/saju_detail_page.dart';
import 'package:haengunse/screens/card/user_saju_section.dart';

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
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('사주 해석',
                style: TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SajuDetailPage()),
              );
            },
            backgroundColor:
                const Color.fromARGB(255, 114, 212, 140).withOpacity(0.85),
            child:
                const Icon(Icons.question_mark, size: 28, color: Colors.white),
            shape: const CircleBorder(),
          ),
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  UserSajuSection(
                    title: "$userName님의 사주",
                    content: "$manseInfo",
                  ),
                  const SizedBox(height: 16),
                  _buildSection("💭 전체 해석", sajuResult['summary'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("💬 내 성격은", sajuResult['personality'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("🌿 오행 분석", sajuResult['fiveElements'] ?? ''),
                  const SizedBox(height: 16),
                  _buildSection("⚖️ 십성 분석", sajuResult['tenGods'] ?? ''),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJusSelector() {
    final jus = ['시주', '일주', '월주', '년주'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: jus
            .map(
              (label) => Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
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
