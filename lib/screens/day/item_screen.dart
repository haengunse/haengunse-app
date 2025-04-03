import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  final String answer;

  const ItemScreen({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("행운 아이템 화면")),
      body: Center(child: Text(answer, style: const TextStyle(fontSize: 18))),
    );
  }
}
