import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final double screenHeight;

  const SessionCard({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      width: double.infinity,
      color: const Color(0xFFFFF7D6),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("다양한 운세를 알아볼까요?",
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          SizedBox(height: 8),
          Text("운세 카드",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
