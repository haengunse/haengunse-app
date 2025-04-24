import 'package:flutter/material.dart';
import 'package:haengunse/screens/dream/dream_chat_box.dart';

class DreamScreen extends StatelessWidget {
  const DreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const DreamChatBox(),
    );
  }
}
