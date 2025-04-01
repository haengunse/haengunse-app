import 'package:flutter/material.dart';

class SessionDay extends StatelessWidget {
  final double screenHeight;

  const SessionDay({super.key, required this.screenHeight});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      width: double.infinity,
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("운세 차트",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildChartRow("오늘의 오하야사 순위", "물병자리", "쌍둥이자리"),
          _buildChartRow("오늘의 띠별 운세", "양띠", "돼지띠"),
        ],
      ),
    );
  }
}
