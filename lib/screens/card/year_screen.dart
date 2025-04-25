import 'package:flutter/material.dart';

class YearScreen extends StatelessWidget {
  const YearScreen({super.key});

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
        child: Text("신년 사주"),
      ),
    );
  }
}
