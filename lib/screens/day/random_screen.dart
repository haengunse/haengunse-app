import 'package:flutter/material.dart';

class RandomScreen extends StatelessWidget {
  final String answer;

  const RandomScreen({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("랜덤 질문 화면")),
      body: Center(child: Text(answer, style: const TextStyle(fontSize: 18))),
    );
  }
}
