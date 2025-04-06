import 'package:flutter/material.dart';

class CookieScreen extends StatelessWidget {
  final String message;

  const CookieScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("포춘쿠키 화면")),
      body: Center(child: Text(message, style: const TextStyle(fontSize: 18))),
    );
  }
}
