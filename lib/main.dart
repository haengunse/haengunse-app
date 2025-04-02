// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    // 테스트용 강제 초기화 (배포 시 제거)
    await prefs.clear();

    return prefs.getBool('isFirstRun') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "오늘의 운세",
      theme: ThemeData(primarySwatch: Colors.green),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
