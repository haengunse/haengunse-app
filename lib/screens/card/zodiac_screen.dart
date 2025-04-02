import 'package:flutter/material.dart';

class ZodiacScreen extends StatelessWidget {
  const ZodiacScreen({super.key});

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
      body: const Center(
        child: Text("띠 운세 화면"),
      ),
    );
  }
}
