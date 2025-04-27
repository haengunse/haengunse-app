import 'package:flutter/material.dart';

class SajuScreen extends StatelessWidget {
  final String manseInfo;
  final String resultText;

  const SajuScreen({
    super.key,
    required this.manseInfo,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사주 해석')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("🧾 사주 정보",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(manseInfo),
            const SizedBox(height: 20),
            const Text("📜 해석 결과",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
