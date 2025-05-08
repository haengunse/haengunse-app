import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('이용약관')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text("이용약관 내용이 여기에 표시됩니다."),
      ),
    );
  }
}
