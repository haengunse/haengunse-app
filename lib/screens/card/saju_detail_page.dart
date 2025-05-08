import 'package:flutter/material.dart';

class SajuDetailPage extends StatelessWidget {
  const SajuDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사주 해석 도움말')),
      body: const Center(child: Text('여기에 해석 도움말 또는 설명 추가')),
    );
  }
}
