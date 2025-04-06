import 'package:flutter/material.dart';

class RandomScreen extends StatelessWidget {
  final String message;

  const RandomScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("랜덤 질문 화면")),
      body: Center(child: Text(message, style: const TextStyle(fontSize: 18))),
    );
  }
}
