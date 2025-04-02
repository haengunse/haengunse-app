import 'package:flutter/material.dart';

class DreamScreen extends StatelessWidget {
  const DreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(child: Text("꿈 해몽 화면")),
    );
  }
}
