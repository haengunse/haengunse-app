import 'package:flutter/material.dart';

class CookieScreen extends StatelessWidget {
  final String answer;

  const CookieScreen({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("포춘쿠키 화면")),
      body: Center(child: Text(answer, style: const TextStyle(fontSize: 18))),
    );
  }
}
