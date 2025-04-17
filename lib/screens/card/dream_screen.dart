// dream_screen.dart
import 'package:flutter/material.dart';
import 'package:haengunse/screens/dream/dream_chat_box.dart';

class DreamScreen extends StatelessWidget {
  const DreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("꿈 해몽"),
        centerTitle: true,
      ),
      body: const DreamChatBox(),
    );
  }
}
