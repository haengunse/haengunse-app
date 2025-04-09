import 'package:flutter/material.dart';
import 'package:haengunse/screens/progress_loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "오늘의 운세",
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ProgressLoadingPage(
        payload: {
          "birthDate": "1995-06-15",
          "solar": true,
          "birthTime": "자시 (23:30~1:30)",
          "gender": "M",
          "name": "홍길동"
        },
      ),
    );
  }
}
